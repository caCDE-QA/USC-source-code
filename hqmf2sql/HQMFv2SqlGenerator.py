from HQMFParserListener import HQMFParserListener
from HQMFParser import *
from HQMFUtil import *
from sqlalchemy import *
#from sqlalchemy.sql.expression import *
from sqlalchemy.sql.functions import *
from sqlalchemy.sql.elements import Label
from sqlalchemy.types import Boolean, Integer, String, DateTime, Date
from sqlalchemy.schema import CreateTable
from HQMFv2SymbolTable import SymbolTable, DataCriterion, TemporalReferrant, MeasurePeriod, PopulationCriterion, Precondition
from HQMFv2SymbolTable import ValueSetRhs, CdRhs, ValueAnyNonNullRhs, IvlPqRhs
import sys
import sqlparse
from datetime import timedelta
from HQMFIntervalUtil import HQMFIntervalType, HQMFIntervalUtil, HQMFResultUtil
from HQMFv2TemporalFunctions import TemporalFunctions
from toposort import toposort, toposort_flatten
import html

VALUESET_SCHEMA = 'valuesets'
HQMF='hqmf'
VALUESET='valueset'


class QDMConstants:
    PATIENT_ID_COL = 'patient_id'
    STARTTIME="start_dt"
    ENDTIME="end_dt"
    UNIQUE_ID="audit_key_value"
    ROW_NUMBER="row_number"

        

class DBConnection:
    DBURL='dburl'
    def __init__(self, dburl, hqmf_schema, valueset_schema=VALUESET_SCHEMA):
        self.dburl=dburl
        self.hqmf_schema=hqmf_schema
        self.valueset_schema=valueset_schema
        self.schemas = {HQMF : self.hqmf_schema, VALUESET : self.valueset_schema}
        self.engine = create_engine(dburl)
        self.conn = self.engine.connect()
        self.meta = MetaData()
        self.meta.reflect(bind=self.engine, schema=self.valueset_schema, views=True)
        self.meta.reflect(bind=self.engine, schema=hqmf_schema, views=True)

    def get_table(self, schema, table_name):
        table = self.meta.tables.get(self.schemas.get(schema) + '.' + table_name)
        if table is None:
            raise ValueError("Can't find table for " + str(schema) + "." + str(table_name))
        return self.meta.tables[self.schemas.get(schema) + '.' + table_name]

    def get_tables(self):
        return self.meta.tables

    def hqmf_table_name(self, name):
        return(self.hqmf_schema + '.' + name)

    def valueset_table_name(self, name):
        return(self.valueset_schema + '.' + name)

class DataSelectable:
    SORT_DESCENDING = "sort_descending"
    ORDINAL = "ordinal"
    FUNCTION = "function"

# SORT_DESCENDING: True = sort descending, False = sort ascending, None = no sort
# ORDINAL: N means take only the Nth row, None means don't impose a single-row restriction
    VALUE_COL = 'value'
    NEGATION_COL = 'negation'

    select_colnames = [QDMConstants.PATIENT_ID_COL, QDMConstants.STARTTIME, QDMConstants.ENDTIME, QDMConstants.UNIQUE_ID]

    def __init__(self, dc, symbol_table):
        self.dc = dc
        self.columns = dict()
        self.symbol_table = symbol_table
        self.set_alias_name()
        self.query_from = None
        self.subquery_table = None

    def set_subquery_table(self, table):
        self.subquery_table = table
        self.query_from = self.subquery_table
        old_columns = self.columns
        self.columns = dict()
        for k in old_columns.keys():
            o = old_columns.get(k)
            if o is not None:
                c = self.subquery_table.columns.get(o.name)
                if c is not None:
                    self.columns[k] = c

    def get_from(self):
        return self.query_from

    def get_selectable(self):
        return self.get_from()

    def get_query(self):
        return self.query

    def get_column(self, colname):
        return self.columns.get(colname)

    def set_alias_name(self):
        base = "dc_"
        if self.dc.get_specific_occurrence() is not None:
            self.alias_name = self.dc.get_short_name()
        elif self.dc.get_conjunction_entries() != None:
            self.alias_name = "conj_"  + str(self.symbol_table.get_next_seqno())
        else:
            self.alias_name = base + str(self.symbol_table.get_next_seqno())

    def get_alias_name(self):
        return self.alias_name
    
    def create_selectable(self, column_names=None, correlate=True, as_view=False):
        so_ref = self.dc.get_specific_occurrence()
        if so_ref is not None:
            sel = self.create_so_reference_selectable(so_ref, column_names, correlate)
        elif self.dc.get_conjunction_entries() != None:
            sel = self.create_conjunction_selectable(column_names, correlate)
        else:
            sel = self.create_data_selectable(column_names, correlate)
        self.query_from = sel
        for colname in self.columns.keys():
            col = self.columns.get(colname)
            if col is not None:
                # currently no row number column in union/intersection
                self.columns[colname] = sel.corresponding_column(col)
        return sel

       
    def create_so_reference_selectable(self, so_ref, column_names, correlate=True):
        key = so_ref.get_criterion_id()
        so = self.symbol_table.get_specific_occurrence(key)
        so_sel = so.get_selectable(self.symbol_table)
        q_from = so_sel.get_from()
        cols = []        
        if column_names == None:
            column_names = self.select_colnames
        for name in column_names:
            col = so_sel.get_column(name)
            if col is not None:
                # don't fret about missing row_number col
                self.columns[name] = col.label(self.dc.to_so_colname(col.name))
                cols.append(col)
        sel = select(cols)
        if correlate:
            unique_col = so_sel.get_column(QDMConstants.UNIQUE_ID)
            unique_name = so_sel.expand_column_name(QDMConstants.UNIQUE_ID)
            sel = sel.where(unique_col == self.symbol_table.base_select.c.get(unique_name))
            sel = sel.correlate(self.symbol_table.base_select)
        sel = self.add_temporal_references(sel)
        sel = self.add_subset_restrictions(sel)
        sel = self.add_count(sel)
        sel = sel.alias(self.get_alias_name())
        return sel

    
    def create_conjunction_selectable(self, column_names, correlate=True):
        children = []
        child_queries = []
        child_column_names = [QDMConstants.PATIENT_ID_COL,
                              QDMConstants.STARTTIME,
                              QDMConstants.ENDTIME,
                              QDMConstants.UNIQUE_ID,
                              QDMConstants.ROW_NUMBER]
        if column_names == None:
            column_names = child_column_names
        for c in self.dc.get_conjunction_entries():
            code = c.get_conjunction_code()
            child = c.get_child_criterion(self.symbol_table)
            if child == None:
                raise(ValueError("Can't find conjunction child criterion, parent is " + self.dc.get_key()))
            child_sel = child.get_selectable(self.symbol_table, correlate=correlate)
            child_from = child_sel.get_from()
            child_query = select([child_sel.get_column(QDMConstants.PATIENT_ID_COL).label(QDMConstants.PATIENT_ID_COL),
                                  child_sel.get_column(QDMConstants.STARTTIME).label(QDMConstants.STARTTIME),
                                  child_sel.get_column(QDMConstants.ENDTIME).label(QDMConstants.ENDTIME),
                                  child_sel.get_column(QDMConstants.UNIQUE_ID).label(QDMConstants.UNIQUE_ID)])
#            children.append(child_query.alias().select())
            children.append(child_query)
        sel = self.apply_set_function(code, children)
        if len(self.dc.get_temporally_related()) > 0:
            sel = self.add_temporal_references(sel, correlate=correlate)
        sel = self.add_subset_restrictions(sel)
        sel = self.add_count(sel)
        if self.dc.is_specific_occurrence_target():
#            if code is not None:
#                sel = sel.select()
            sel = sel.cte(self.dc.so_name())
        elif self.dc.is_variable():
            if code is not None:
                sel = sel.select()
            sel = sel.cte(self.dc.get_variable_shortname())
        else:
            sel = sel.alias()
        return sel

    def apply_set_function(self, code, children):
        if len(children) == 1:
            return children[0]

        if code == "OR":
            sel = union(*children)
        elif code == "AND":
            sel = intersect(*children)
        elif code == None:
            raise ValueError("Grouper criterion with " + len(children) + " entries")
        else:
            raise ValueError("Unknown conjunction " + str(code))
        table = self.symbol_table.sql_generator.create_table_from_select('conj_' + str(self.symbol_table.get_next_seqno()), sel)
        self.columns = dict()
        for c in table.c:
            self.columns[c.name] = c
        return select([table])

    
    def create_data_selectable(self, column_names=None, correlate=True):
        sel = self.create_selectable_codelist_only(column_names, correlate)
        sel = self.add_negation(sel)
        sel = self.add_field_value(sel)
        sel = self.add_temporal_references(sel, correlate=correlate)
        sel = self.add_value_comparison(sel, self.VALUE_COL, self.dc.get_effective_value())
        if correlate:
            sel = sel.correlate(self.symbol_table.base_select)
        sel = self.add_subset_restrictions(sel)
        sel = self.add_count(sel)
        if self.dc.is_specific_occurrence_target():
            sel = sel.cte(self.dc.so_name())
        elif self.dc.is_variable():
            sel = sel.cte(self.dc.get_variable_shortname())
        else:
            sel = sel.alias(self.get_alias_name())
        return sel

    def add_count(self, sel):
        cnt = self.dc.get_raw_count()
        if cnt == None:
            return sel
        dc = cnt.get_data_criterion()
        if dc == None:
            return sel
        rep = dc.get_repeat_number()
        low = rep.get_low()
        high = rep.get_high()
        if low == None and high == None:
            return sel
        sel = select([sel.c.get(QDMConstants.PATIENT_ID_COL)]).group_by(sel.c.get(QDMConstants.PATIENT_ID_COL))
        if low != None:
            if rep.get_low_closed() == False:
                sel = sel.having(count() > low)
            else:
                sel = sel.having(count() >= low)
        if high != None:
            if rep.get_high_closed() == False:
                sel = sel.having(count() < high)
            else:
                sel = sel.having(count() <= high)
        return sel

    def add_temporal_references(self, sel, correlate=True):
        mp = self.symbol_table.get_measure_period()
        for t in self.dc.get_temporally_related():
            ref = t.get_criteria_reference()
            if ref.get_id_extension() == 'measureperiod':
                mp = self.symbol_table.get_measure_period()
                sel = TemporalFunctions.process(t, sel, self, mp, self.symbol_table.get_inline_preference())
            else:
                referrant = self.symbol_table.get_data_criterion(ref.get_criterion_id())
                if referrant == None:
                    print("No selectable for " + ref.get_criterion_id())
                selectable = referrant.get_selectable(self.symbol_table, correlate=correlate)
                sel = TemporalFunctions.process(t, sel, self, selectable, self.symbol_table.get_inline_preference())
        return sel
    
    def add_field_value(self, sel):
        fv = self.dc.get_raw_field_value()
        if fv == None:
            return sel
        return self.add_value_comparison(sel, fv.get_field_name(), fv.get_raw_field_value())
    
    def add_ivl_pq(self, sel, col, value):
        lowval = value.get_low()
        if lowval is not None:
            lc = value.get_low_closed()
            if lc or lc is None:
                op = Column.__ge__
            else:
                op = Column.__gt__
            sel = self.add_ivl_pq_half(sel, col, op, lowval)

        highval = value.get_high()
        if highval is not None:
            hc = value.get_high_closed()
            if hc or hc is None:
                op = Column.__le__
            else:
                op = Column.__lt__
            sel = self.add_ivl_pq_half(sel, col, op, highval)
        return sel

    def add_ivl_pq_half(self, sel, col, op, val):
        if val == None or val.get_value() == None:
            return sel
        return sel.where(op(col, val.get_value()))
    
    def add_subset_restrictions(self, sel):
        ordinal = None
        if self.dc.get_recent() != None:
            ordinal = 1
        else:
            ordinal = self.dc.get_sequence_number()
        if ordinal is not None:
            child = sel.alias("ordinal_" + str(ordinal))
            sel = select(child.c)
            sel = sel.where(child.c.get(self.row_column_name()) == ordinal)
        return sel
    
    def get_start_time(self):
        return self.get_column(QDMConstants.STARTTIME)

    def get_end_time(self):
        return self.get_column(QDMConstants.ENDTIME)

    def get_unique_id(self):
        return self.get_column(QDMConstants.UNIQUE_ID)

    def add_value_comparison(self, sel, field_name, val):
        if val == None:
            return sel
        value = val.get_raw_value()
        col = self.get_column(field_name)
        if isinstance(value, ValueAnyNonNullRhs):
            sel = sel.where(col != None)
        elif isinstance(value, IvlPqRhs):
            sel = self.add_ivl_pq(sel, col, value)
        elif isinstance(value, ValueSetRhs):
            code_list_id = value.get_value_set()
            code_list_table = self.symbol_table.code_lists()
            code_map_table = self.symbol_table.individual_code_map()

            if code_list_id is not None:
                codes = select([cast(code_map_table.c.data_code, String(256))])\
                    .select_from(code_list_table.join(code_map_table, code_list_table.c.code == code_map_table.c.code))\
                .where(code_list_table.c.code_list_id == code_list_id)\
                    .alias("value_alias")

                sel = sel.where(cast(col, String(256)).in_(codes))
        elif isinstance(value, CdRhs):
            code_system = value.get_code_system()
            code_values = value.get_code()
            code_map_table = self.symbol_table.individual_code_map()

            if code_system is not None and code_values is not None:
                codes = select([cast(code_map_table.c.data_code, String(256))])\
                .where(and_(code_map_table.c.code_system == code_system,
                            code_map_table.c.measure_code.in_(code_values)))\
                .alias("code_values_alias")

                sel = sel.where(cast(col, String(256)).in_(codes))
        else:
            raise NotImplementedError("value type " + str(type(value)) + " is not implemented")
        return sel
        
        
    
    def add_negation(self, sel):
        negation = self.dc.is_negation()
        if negation == None:
            negation = False
            
        if negation:
            return sel.where(cast(self.get_column(self.NEGATION_COL), Boolean) == negation)
        else:
            return sel.where(or_(cast(self.get_column(self.NEGATION_COL), Boolean) == None, 
                             cast(self.get_column(self.NEGATION_COL), Boolean) == negation))          

    def initialize_columns(self, table):
        for c in table.columns:
            self.columns[c.key] = c
        self.add_row_number_column()
    
    def create_selectable_codelist_only(self, column_names = None, correlate=True):
        table = self.symbol_table.get_data_table(self.dc.table_name())
        self.initialize_columns(table)
        codelist = self.dc.get_code_list()
        cols = self.select_columns(self.symbol_table, column_names)
        if self.dc.is_specific_occurrence_target() or self.dc.is_variable():
            correlate = False
        if codelist is not None:
            codes = self.symbol_table.code_lists().alias()
            join = table.join(codes, and_(codes.c.code == table.c.code,
                                          codes.c.code_list_id == codelist))                        
            sel = select(cols, use_labels=True)
            if correlate:
                sel = sel.where(table.c.get(QDMConstants.PATIENT_ID_COL) == self.symbol_table.get_anchor_column())
            sel = sel.select_from(join)
        else:
            code = self.dc.get_raw_code()
            if code is not None:
                codes = self.symbol_table.individual_code_map().alias()
                join = table.join(codes,
                                       and_(codes.c.code == table.c.code,
                                            codes.c.code_system_oid == code.get_code_system(),
                                            codes.c.measure_code == code.get_code()))
                sel = select(cols, use_labels=True)
                if correlate:
                    sel = sel.where(table.c.get(QDMConstants.PATIENT_ID_COL) == self.symbol_table.get_anchor_column())
                sel = sel.select_from(join)
            else:
                sel = select(table.c)
                if correlate:
                    sel = sel.where(table.c.get(QDMConstants.PATIENT_ID_COL) == self.symbol_table.get_anchor_column())
        return sel    
    
    def select_columns(self, symbol_table, column_names = None):
        if column_names == None:
            column_names = self.select_colnames
        cols = []
        for name in column_names:
            col = self.get_column(name)
            if col is not None:
                cols.append(self.get_column(name))
        return cols
    
          
    def new_row_number_column(self):
        desc_flag = (self.dc.get_recent() != None)
        col = func.coalesce(self.get_start_time(), self.get_end_time())
        if desc_flag == True:
            col = col.desc()
#        return func.row_number().over(partition_by=self.columns.get(QDMConstants.PATIENT_ID_COL), order_by=col).label(self.row_column_name())
        return func.row_number().over(partition_by=self.columns.get(QDMConstants.PATIENT_ID_COL), order_by=col).cast(Integer).label(self.row_column_name())

    def add_row_number_column(self):
        if self.dc.get_sequence_number() is not None or self.dc.get_recent() is not None:
            if self.columns.get(QDMConstants.ROW_NUMBER) is None:
                self.columns[QDMConstants.ROW_NUMBER] = self.new_row_number_column()
                self.select_colnames.append(QDMConstants.ROW_NUMBER)     
                
    def row_column_name(self):
        return QDMConstants.ROW_NUMBER + '_' + self.dc.uniqueno       

    def get_selectable_col(self, colname):
        return self.get_selectable().c.get(self.expand_column_name(colname))

    def get_selectable_unique_col(self):
        return self.get_selectable().c.get(self.expand_column_name(QDMConstants.UNIQUE_ID))

    def get_selectable_patient_col(self):
        return self.get_selectable().c.get(self.expand_column_name(QDMConstants.PATIENT_ID_COL))

class SpecificOccurrenceSelectable(DataSelectable):
    select_colnames = [ QDMConstants.PATIENT_ID_COL,
                        QDMConstants.UNIQUE_ID,
                        QDMConstants.STARTTIME,
                        QDMConstants.ENDTIME]
    def __init__(self, dc, symbol_table):
        DataSelectable.__init__(self, dc, symbol_table)
        self.basetable_alias = None

    def expand_column_name(self, name):
        return self.dc.to_so_colname(name)

    def set_alias_name(self):
        self.alias_name = self.dc.so_name()

    def get_basetable_alias(self, symbol_table):
        if self.basetable_alias == None:
            sel = self.table
            self.basetable_alias = sel.alias(name=self.dc.so_name())
        return self.basetable_alias

#    def get_outer_column(self, name):
#        return self.outer_columns.get(name)
    
    def initialize_columns(self, table):
        for col in table.columns:
            bc = col.base_columns
            if bc != None and len(bc) > 0:
                name = list(bc)[0].name
            self.columns[name] = col.label(self.dc.to_so_colname(col.name))
        self.add_row_number_column()
               

class MyTimeStamp(TypeDecorator):
    impl = TIMESTAMP

    def process_literal_param(self, value, dialect):
        return "'" + value.isoformat() + "'"

    
class ExtendedDataCriterion(DataCriterion):
    def __init__(self, dc, uniqueno, max_identifier_length=64, max_column_length=32):
        self.name = dc.name
        self.dc = dc
        self.tbl = None
        self.columns = dict()
        self.uniqueno = str(uniqueno)
        self.max_identifier_length=max_identifier_length
        self.max_column_length = max_column_length
        self.max_table_alias_length=max_identifier_length - (self.max_column_length + 1)
        self.variable_shortname = dc.get_short_name()
        self.selectable = None

    def get_variable_shortname(self):
        return self.variable_shortname

    def get_short_name(self):
        return self.dc.get_short_name()

    def get_value(self):
        return self.dc.get_value()

    def get_raw_count(self):
        return self.dc.get_raw_count()

    def get_raw_code(self):
        return self.dc.get_raw_code()
    
    def get_effective_value(self):
        return self.dc.get_effective_value()
    
    def is_specific_occurrence_target(self):
        return self.dc.is_specific_occurrence_target()

    def to_sql(self, symbol_table, name):
        return self.to_select_alias(symbol_table, name)

    def new_selectable(self, symbol_table, correlate=True):
        self.selectable = DataSelectable(self, symbol_table)
        self.selectable.create_selectable(correlate=correlate)
        return self.selectable

    def get_selectable(self, symbol_table, correlate=True):
        if self.is_specific_occurrence_target() or self.is_variable():
            if self.selectable is not None:
                return self.selectable
        return self.new_selectable(symbol_table, correlate=correlate)

    def table_name(self):
        return self.dc.get_criteria_data_type()

    def is_specific_occurrence(self):
        return False
    
    def is_negation(self):
        return self.dc.is_negation()
    
    def get_specific_occurrence(self):
        return self.dc.get_specific_occurrence()
    
    def get_key(self):
        return self.dc.get_key()
    
    def get_id(self):
        return self.dc.get_id()

    def get_raw_id(self):
        return self.dc.get_raw_id()
    
    def get_variable_name(self):
        return self.dc.get_variable_name()
    
    def get_temporally_related(self):
        return self.dc.get_temporally_related()
    
    def get_code_list(self):
        return self.dc.get_code_list()
    
    def get_conjunction_entries(self):
        return self.dc.get_conjunction_entries()
    
    def get_raw_field_value(self):
        return self.dc.get_raw_field_value()
    
    def get_recent(self):
        return self.dc.get_recent()
    
    def get_sequence_number(self):
        return self.dc.get_sequence_number()

    def is_variable(self):
        return self.dc.is_variable()
    
    
class ExtendedSpecificOccurrence(ExtendedDataCriterion):
    def __init__(self, dc, seqno, raw_symbol_table, max_identifier_length=64, max_column_length=32):
        ExtendedDataCriterion.__init__(self, dc, seqno, max_identifier_length, max_column_length)
        if dc.is_specific_occurrence_target():
            data_type = dc.get_criteria_data_type()
            if data_type == None:
                data_type="grouper"
            self.so_table_name = 'so_' + str(dc.dc_index) + '_' + data_type
        else:
            so_ref = dc.get_specific_occurrence()
            so = raw_symbol_table.get_specific_occurrence(so_ref.get_criterion_id())
            self.so_table_name = 'so_' + str(dc.dc_index)
        self.so_selectable = None

    def so_name(self):
        return self.so_table_name
    
    def new_selectable(self, symbol_table, correlate=False):
        self.so_selectable = SpecificOccurrenceSelectable(self, symbol_table)
        self.so_selectable.create_selectable(correlate=correlate)
        return self.so_selectable
    

    def get_selectable(self, symbol_table, correlate=False):
        if self.so_selectable == None:
            self.so_selectable = self.new_selectable(symbol_table)
        return self.so_selectable

    def to_basetable_alias(self, symbol_table):
        data_selectable = self.get_selectable(symbol_table)
        return data_selectable.get_basetable_alias(symbol_table)

    def get_unique_id(self, symbol_table=None):
        return self.get_selectable(symbol_table).get_unique_id()

    def is_specific_occurrence(self):
        return True
    
    def to_so_colname(self, colname):
        return self.so_name() + '_' + colname
    
    def so_const(self):
        return self.dc.so_const()

class ExtendedSymbolTable(SymbolTable):

    CODE_LISTS='code_lists'
    INDIVIDUAL_CODE_MAP='individual_code_map'
    PATIENTS = 'patients'
    BASE_PREFIX='base_'

    def __init__(self, raw_symbol_table, data_criteria_names_used, db):
        SymbolTable.__init__(self)
        self.set_db(db)
        self.population_criteria = dict()
        self.specific_occurrence_targets = dict()
        self.specific_occurrences = dict()
        self.raw_symbol_table = raw_symbol_table
        self.measure_period = ExtendedMeasurePeriod(raw_symbol_table.measure_period)
        self.seqno = 0
        self.data_criteria_names_used = data_criteria_names_used
        self.variables = dict()
        inline_preference=True

        for key in raw_symbol_table.get_data_criteria().keys():
            dc = raw_symbol_table.get_data_criterion(key)
            self.seqno = self.seqno + 1
            if dc.is_specific_occurrence_target():
                extended_dc = ExtendedSpecificOccurrence(dc, self.seqno, self.raw_symbol_table)
                self.specific_occurrence_targets[key] = extended_dc
            elif dc.is_specific_occurrence():
                extended_dc = ExtendedSpecificOccurrence(dc, self.seqno, self.raw_symbol_table)
                self.specific_occurrences[key] = extended_dc                
            else:
                extended_dc = ExtendedDataCriterion(dc, self.seqno)

            self.data_criteria[key] = extended_dc
            if dc.is_variable():
                self.variables[key] = extended_dc


    def set_inline_preference(self, val):
        self.inline_preference = val

    def get_inline_preference(self):
        return self.inline_preference

    def get_next_seqno(self):
        self.seqno = self.seqno + 1
        return(self.seqno)

    def set_db(self, db):
        self.db = db
        self.anchor_table = None
        self.anchor_column = None
        self.code_lists_table = self.get_table(VALUESET, self.CODE_LISTS)
        self.individual_code_map_table = self.get_table(VALUESET, self.INDIVIDUAL_CODE_MAP)

    def get_measure_period(self):
        return self.measure_period

    def outer_colname(self, name):
        return self.BASE_PREFIX + name

    def get_table(self, schema, name):
        return self.db.get_table(schema, name)
    
    def code_lists(self):
        return self.code_lists_table

    def individual_code_map(self):
        return self.individual_code_map_table


    def create_base_query(self, sql_generator):
        self.anchor_table = self.get_data_table(self.PATIENTS).alias(self.BASE_PREFIX + self.PATIENTS)
        anchor_column = self.anchor_table.c.get(QDMConstants.PATIENT_ID_COL).label(self.outer_colname(QDMConstants.PATIENT_ID_COL))
        base_from = self.anchor_table
        base_select_cols = [anchor_column]

        so_list = list(toposort_flatten(self.raw_symbol_table.so_temporal_dependencies))
        self.merge_so_lists(so_list, self.data_criteria_names_used)
        so_done = []
        for var in self.variables.values():
            if not var.is_specific_occurrence_target():
                sel = var.get_selectable(self, correlate=False)
                query = sel.get_selectable()
                sel.set_subquery_table(sql_generator.create_table_from_select(var.get_short_name(), query))
                query = sel.get_selectable()            
                for colname in [QDMConstants.UNIQUE_ID, QDMConstants.STARTTIME, QDMConstants.ENDTIME]:
                    col = sel.get_column(colname)
                    if col is not None:
                        base_select_cols.append(col)
                base_from = base_from.join(query, sel.get_column(QDMConstants.PATIENT_ID_COL) == anchor_column, isouter=True)


        for var in self.specific_occurrence_targets.values():
            sel = var.get_selectable(self, correlate=False)
            query = sel.get_selectable()
            sel.set_subquery_table(sql_generator.create_table_from_select(var.get_short_name(), query))

        processed_sos = dict()            
        for var in self.specific_occurrences.values():
            sel = var.get_selectable(self, correlate=False)            
            root = var.get_raw_id().get_root()                        
            join_conds = [sel.get_column(QDMConstants.PATIENT_ID_COL) == anchor_column]
            prior_sos = processed_sos.get(root)
            if prior_sos == None:
                processed_sos[root] = [sel]
            else:
                for prior_so in prior_sos:
                    join_conds.append(sel.get_column(QDMConstants.UNIQUE_ID) !=
                                      prior_so.get_column(QDMConstants.UNIQUE_ID))
                prior_sos.append(sel)
            base_from = base_from.join(sel.get_from(), and_(*join_conds), isouter=True)
            for colname in [QDMConstants.UNIQUE_ID, QDMConstants.STARTTIME, QDMConstants.ENDTIME]:
                col = sel.get_column(colname)
                if col is not None:
                    base_select_cols.append(col.label(var.to_so_colname(col.name)))


#        base_select = select(base_select_cols).select_from(base_from)
#        self.base_select = base_select.alias('patient_base')
#        self.anchor_column = self.base_select.corresponding_column(anchor_column)
        self.base_select = sql_generator.create_table_from_select('patient_base', select(base_select_cols).select_from(base_from))
        self.anchor_column = self.base_select.c.get(self.outer_colname(QDMConstants.PATIENT_ID_COL))
        self.anchor_table = self.base_select

    def get_anchor_column(self):
        return self.anchor_column

    def merge_so_lists(self, so_list, additional_criteria):
        for dc_name in additional_criteria:
            dc = self.get_data_criterion(dc_name)
            so = dc.get_specific_occurrence()
            if so != None:
                so_name = so.get_criterion_id()
                if not so_name in so_list:
                    so_list.append(so_name)

    def get_data_table(self, table_name):
        return self.db.get_table(HQMF, table_name)

    def get_valueset_table(self, table_name):
        return self.db.get_table(VALUESET, table_name)

    def get_measure_metadata(self):
        return self.raw_symbol_table.metadata



class ExtendedMeasurePeriod(MeasurePeriod):
    def __init__(self, raw_mp):
        self.raw_mp = raw_mp

    def get_start_time(self):
        return cast(self.raw_mp.get_start_time(), MyTimeStamp)

    def get_end_time(self):
        return cast(self.raw_mp.get_end_time(), MyTimeStamp)

    def raw_start_time(self):
        return self.raw_mp.get_start_time()

    def raw_end_time(self):
        return self.raw_mp.get_end_time()


class SQLGenerator:
    def __init__(self, dburl, hqmf_schema, result_schema, measure, inline_preference=True):
        self.db = DBConnection(dburl, hqmf_schema)
        self.result_util = HQMFResultUtil(result_schema)
        self.measure = measure
        self.symbol_table = ExtendedSymbolTable(measure.symbol_table, measure.non_stratifier_data_criteria(), self.db)
        self.symbol_table.set_inline_preference(inline_preference)
        self.symbol_table.measure_name = self.measure_name()
        self.symbol_table.sql_generator = self

    def create_table_from_select(self, name_suffix, sel):
        table_name = 'measure_' + self.measure_name() + '_' + name_suffix
        cols = []
        for c in sel.columns:
            cols.append(Column(c.name, c.type))
        table = Table(table_name,
                      self.db.meta,
                      *cols,
                      schema=self.result_util.get_schema())
        print(str(CreateTable(table, bind=self.db.engine)))
        print(self.result_util.statement_terminator())
        print(sql_to_string(table.insert().from_select(sel.columns, sel), self.pretty))
        print(self.result_util.statement_terminator())        
        return table
        
    def measure_name(self):
        return self.measure.get_measure_name()

    def viewname_all(self, popnum):
        return 'measure_' + self.measure_name() + "_" + str(popnum) + '_all'

    def print_debug(self):
        dc_set = set()
        self.symbol_table.create_base_query(self)
        for dc in self.symbol_table.get_data_criteria().values():
            print("<hr>")
            dc.dc.print_summary(self.symbol_table.raw_symbol_table, dc_set, dc_verbose=True)
            print("<p>")
            ds = dc.new_selectable(self.symbol_table)
            if hasattr(ds, 'create_selectable'):
                sql = ds.create_selectable()
            if sql is not None:
                print(html.escape(sql_to_string(sql)))
            print("</p>")


    def generate_sql(self, pretty=True):
        self.pretty = pretty
        self.symbol_table.create_base_query(self)
        cols=self.symbol_table.base_select.columns.values()
        popnum = 0
        for pcsection in self.measure.populations:
            popnames = []
            for pclist in pcsection.population_criteria.values():
                if isinstance(pclist, list):
                    pass
#                    for pccrit in pclist:
#                        pop = ExtendedPopulationCriterion(pccrit)
#                        psql = pop.to_sql(self.symbol_table).label(pop.population_name())
#                        cols.append(psql)
                else:
                    pop = ExtendedPopulationCriterion(pclist)
                    psql = pop.to_sql(self.symbol_table)
                    if psql != None:
                        cols.append(psql.label(pop.population_name()))
                        popnames.append(pop.population_name())
            if len(cols) > 0:
                query = select(cols)
#               print(sql_to_string(query))
                print(self.result_util.create_view(self.viewname_all(popnum), query, pretty))
                self.create_patient_summary_table(popnames, popnum)
                popnum = popnum+1

    def create_patient_summary_table(self, popnames, popnum):
        result_table = Table('measure_' + self.measure_name() + '_' + str(popnum) + '_patient_summary', self.db.meta,
                             Column('patient_id', Integer),
                             Column('effective_ipp', Boolean),
                             Column('effective_denom', Boolean),
                             Column('effective_denex', Boolean),
                             Column('effective_numer', Boolean),
                             Column('effective_denexcep', Boolean),
                             schema=self.result_util.get_schema())

        print(str(CreateTable(result_table, bind=self.db.engine)))
        print(self.result_util.statement_terminator())

        popquery = self.make_popquery(popnames, popnum)
        ins = result_table.insert().from_select([
                'patient_id',
                'effective_ipp',
                'effective_denom',
                'effective_denex',
                'effective_numer',
                'effective_denexcep'], popquery)
        print(sql_to_string(ins))
        print(self.result_util.statement_terminator())

    def constant_string(self, str):
        return cast(str, String(256))

    def make_popquery(self, popnames, popnum):
        cdict = dict()
        self.make_ipp_col(popnames, cdict)
        self.make_denom_col(popnames, cdict)
        self.make_denex_col(popnames, cdict)
        self.make_numer_col(popnames, cdict)
        self.make_denexcep_col(popnames, cdict)

        fromview = text(self.result_util.qualified_artifact_name(self.viewname_all(popnum)))
        basename = self.measure_name() + '_' + str(popnum)

        viewname = basename + '_patient_summary'
        patient_col = column('base_patient_id')

        order_cols=[]
        for key in ['denominatorExclusions', 'numerator', 'denominatorExceptions', 'denominator']:
            col = cdict.get(key)
            if col is None:
                cdict[key] = cast(null(), Boolean)
            else:
                order_cols.append(col.desc())

        if cdict.get('STRAT') is None:
            cdict['STRAT'] = cast(null(), Boolean)

        summary_cols = [
            patient_col.label('patient_id'),
            cdict.get('initialPopulation').label('effective_ipp'),
            cdict.get('denominator').label('effective_denom'),
            cdict.get('denominatorExclusions').label('effective_denex'),
            cdict.get('numerator').label('effective_numer'),
            cdict.get('denominatorExceptions').label('effective_denexcep'),
            ]

        rowcol = func.rank().over(partition_by=patient_col, order_by = order_cols)
        summary_cols.append(rowcol.label('rank'))
        base = select(summary_cols).select_from(fromview).where(cdict.get('initialPopulation')).alias()
        query=select([
                base.c.patient_id,
                base.c.effective_ipp,
                base.c.effective_denom,
                base.c.effective_denex,
                base.c.effective_numer,
                base.c.effective_denexcep]).where(base.c.rank == 1).distinct()

        return(query.alias())

    def make_ipp_col(self, popnames, cdict):
        cdict['initialPopulation'] = column('initialPopulation')

    def make_denom_col(self, popnames, cdict):
        sname = 'denominator'
        ipp = cdict.get('initialPopulation')
        if sname in popnames:
            denom = column(sname)
            cdict['denominator'] = and_(ipp, denom)
        else:
            cdict['denominator'] = ipp


    def make_denex_col(self, popnames, cdict):
        sname = 'denominatorExclusions'
        if sname in popnames:
            denex = column(sname)
            denom = cdict.get('denominator')
            cdict[sname] = and_(denom, denex)

    def make_numer_col(self, popnames, cdict):
        sname = 'numerator'
        if sname in popnames:
            numer = column(sname)
            denom = cdict.get('denominator')
            denex = cdict.get('denominatorExclusions')
            if denex is not None:
                numer = and_(denom, not_(denex), numer)
            else:
                numer = and_(denom, numer)
            cdict['numerator'] = numer
        else:
            raise ValueError("No numerator in population")

    def make_denexcep_col(self, popnames, cdict):
        sname = 'denominatorExceptions'
        if sname in popnames:
            denexcep = column(sname)
            numer = cdict.get('numerator')
            denom = cdict.get('denominator')
            denex = cdict.get('denominatorExclusions')
            if denex is not None:
                denexcep = and_(denom, not_(denex), not_(numer), denexcep)
            else:
                denexcep = and_(denom, not_(numer), denexcep)

class ExtendedPopulationCriterion(PopulationCriterion):
    def __init__(self, pop):
        PopulationCriterion.__init__(self)
        self.population_criterion = pop
        self.preconditions = pop.preconditions

    def population_name(self):
        return self.population_criterion.population_name()
    
    def population_type(self):
        return self.population_criterion.get_type()

    def to_sql(self, symbol_table, name = None):
        cols = []
        if self.preconditions == None:
            return select([None])
        for pc in self.preconditions.get_preconditions():
            precondition = ExtendedPrecondition(pc)
            psql = precondition.to_sql(symbol_table, name)
#             while type(psql) == list:
#                 if len(psql) == 1:
#                     psql = psql[0]
#                 else:
#                     raise ValueError("precondition length is " + str(len(psql)))

            if psql is not None:
                cols.append(psql)
        if len(cols) == 0:
            return None
        else:
#            return and_(*cols)
            return select([and_(*cols)])

class ExtendedPrecondition(Precondition):
    def __init__(self, prec):
        Precondition.__init__(self)
        self.precondition = prec

    def to_sql(self, symbol_table, name = None):
        sel = None
        grp = self.precondition.get_grouping()
        if grp != None:
            children = []
            for child in grp.get_preconditions():
                childsql = ExtendedPrecondition(child).to_sql(symbol_table)
                if childsql is not None:
                    children.append(childsql)
            if len(children) > 0:
                if grp.grouping_type == 'allTrue':
                    sel = select([and_(*children)])
                elif grp.grouping_type == 'atLeastOneTrue':
                    sel = select([or_(*children)])
                elif grp.grouping_type == 'allFalse':
                    sel = select([not_(or_(*children))])
                elif grp.grouping_type == 'atLeastOneFalse':
                    sel = select([not_(and_(*children))])
                else:
                    raise ValueError("Unknown grouping type: " + str(grp.grouping_type))
            return sel
        ref = self.follow_criteria_reference(symbol_table)
        if ref != None:
            if isinstance(ref, DataCriterion):
                ref_sel = ref.get_selectable(symbol_table)
                if ref_sel == None:
                    pass
                tbl = ref_sel.create_selectable()
                if tbl == None:
                    pass
                sel = exists(tbl.c)
#                sel = select([cast(True, Boolean)]).where(exists(tbl.c)).alias()

#                if ref.get_raw_count() == None:
#                    sel = exists(ref.get_selectable(symbol_table).create_selectable().c)
#                else:
#                    sel = ref.get_selectable(symbol_table).create_selectable()
        return sel
    
    def get_raw_criteria_reference(self):
        return self.precondition.get_raw_criteria_reference()

    def get_criteria_reference_id(self):
        return self.precondition.get_criteria_reference_id()

    def follow_criteria_reference(self, symbol_table):
        return self.precondition.follow_criteria_reference(symbol_table)

            
