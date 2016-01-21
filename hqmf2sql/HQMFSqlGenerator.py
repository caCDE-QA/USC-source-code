import json
from HQMFParserListener import HQMFParserListener
from HQMFParser import *
from HQMFUtil import *
from sqlalchemy import *
from sqlalchemy.sql.expression import *
from sqlalchemy.sql.functions import *
from sqlalchemy.types import Boolean, Integer, String, DateTime, Date
from sqlalchemy.schema import CreateTable
from HQMFData import DataCriterion, HQMF, VALUESET, TemporalReferrant, MeasurePeriod
from HQMFSymbolTable import SymbolTable
import sys
import sqlparse
from datetime import timedelta
from HQMFIntervalUtil import HQMFIntervalType, HQMFIntervalUtil, HQMFResultUtil
from toposort import toposort, toposort_flatten

VALUESET_SCHEMA = 'valuesets'

class QDMConstants:
    PATIENT_ID_COL = 'patient_id'
    STARTTIME="start_dt"
    ENDTIME="end_dt"
    UNIQUE_ID="audit_key_value"

class HQMFCustomEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, BasePrecondition) or isinstance(obj, DataCriterion):
            return obj.to_json()

        return json.JSONEncoder.default(self, obj)

class TemporalFunctions:
    @classmethod
    def date_delta(cls, units, d1, d2, inline=True):
        # Logic from Appendix C of
        # http://www.cms.gov/Regulations-and-Guidance/Legislation/EHRIncentivePrograms/Downloads/eCQM_LogicGuidance_v110_May2015.pdf
        # It's not stated explicitly, but they seem to always want positive values as results

        if units == 'year' or units == 'a':
            return cls.year_delta(d1, d2, inline)
        elif units == 'month' or units == 'mo':
            return cls.month_delta(d1, d2, inline)
        elif units == 'week' or units == 'wk':
            return cls.week_delta(d1, d2, inline)
        elif units == 'day' or units == 'd':
            return cls.day_delta(d1, d2, inline)
        else:
            raise NotImplementedError("Date difference with unit " + units + " is not implemented")

    @classmethod
    def year(cls, date):
        return extract('year', date)


    @classmethod
    def month(cls, date):
        return extract('month', date)

    @classmethod
    def day(cls, date):
        return extract('day', date)

    

    @classmethod
    def year_delta(cls, d1, d2, inline=True):
        if not inline:
            return func.year_delta(d1, d2)
        return case([
                (d2 >= d1, cls.signed_year_delta(d1, d2)),
                (d2 < d1, cls.signed_year_delta(d2, d1))],
                    else_ = null())

    @classmethod
    def signed_year_delta(cls, d1, d2):
        return case([
                (cls.month(d2) < cls.month(d1), cls.year(d2) - cls.year(d1) - 1),
                (and_(cls.month(d2) == cls.month(d1), cls.day(d2) >= cls.day(d1)), cls.year(d2) - cls.year(d1)),
                (and_(cls.month(d2) == cls.month(d1), cls.day(d2) < cls.day(d1)), cls.year(d2) - cls.year(d1) - 1),
                (cls.month(d2) > cls.month(d1), cls.year(d2) - cls.year(d1))
                ])
    

    @classmethod
    def month_delta(cls, d1, d2, inline=True):
        if not inline:
            return func.month_delta(d1, d2)
        return case([
                (d2 >= d1, cls.signed_month_delta(d1, d2)),
                (d2 < d1, cls.signed_month_delta(d2, d2))],
                    else_ = null())

    @classmethod
    def signed_month_delta(cls, d1, d2):
        return case([
                (cls.day(d2) >= cls.day(d1), (cls.year(d2) - cls.year(d1)) * 12 + cls.month(d2) - cls.month(d1)),
                (cls.day(d2) < cls.day(d1), (cls.year(d2) - cls.year(d1)) * 12 + cls.month(d2) - cls.month(d1) - 1)
                ])


    # Per appendix C: "For the purposes of quality measures, duration expressed in weeks ignores the time of day"                
    @classmethod
    def week_delta(cls, d1, d2, inline=True):
        if not inline:
            return func.week_delta(d1, d2)
        return func.floor(cls.day_delta(d1, d2) / 7)


    # Per appendix C: "For the purposes of quality measures, duration expressed in days ignores the time of day"
    @classmethod
    def day_delta(cls, d1, d2, inline=True):
        if not inline:
            return func.day_delta(d1, d2)
        return func.abs(cast(d2, Date) - cast(d1, Date))

    @classmethod
    def get_method(cls, name):
        methods = {
            'SBS' : {'func' : cls.compare_svs, 'op' : Column.__lt__, 'inclusive' : Column.__le__},
            'SBE' : {'func' : cls.compare_sve, 'op' : Column.__lt__, 'inclusive' : Column.__le__},
            'EBS' : {'func' : cls.compare_evs, 'op' : Column.__lt__, 'inclusive' : Column.__le__},
            'EBE' : {'func' : cls.compare_eve, 'op' : Column.__lt__, 'inclusive' : Column.__le__},
            'SAS' : {'func' : cls.compare_svs, 'op' : Column.__gt__, 'inclusive' : Column.__ge__},
            'SAE' : {'func' : cls.compare_sve, 'op' : Column.__gt__, 'inclusive' : Column.__ge__},
            'EAS' : {'func' : cls.compare_evs, 'op' : Column.__gt__, 'inclusive' : Column.__ge__},
            'EAE' : {'func' : cls.compare_eve, 'op' : Column.__gt__, 'inclusive' : Column.__ge__},

            'DURING' : {'func' : cls.add_during},
            'CONCURRENT' : {'func' : cls.add_concurrent},
            'SDU' : {'func' : cls.add_sdu},
            'EDU' : {'func' : cls.add_edu},
            'ECWS' : {'func' : cls.add_ecws},
            'SCW' : {'func' : cls.add_scw},
            'ECW' : {'func' : cls.add_ecw},
            'OVERLAP' : {'func' : cls.add_overlap}
            }
        return methods[name]

    @classmethod
    def process(cls, operator, sel, data_selectable, referrant, symbol_table, temporal_range=None, outer=True):
        specs = cls.get_method(operator)
        func = specs['func']
        return func(sel, data_selectable, referrant, symbol_table, specs, temporal_range, outer, symbol_table.get_inline_preference())

    @classmethod
    def range_to_offset(cls, range, spec):
        if range == None:
            return None
        offset = dict()
        for key in ['high', 'low']:
            offset[key] = cls.to_offset(range.get(key), spec.get('op'))
        return offset

    @classmethod
    def to_offset(cls, range, operator):
        if range == None:
            return None
        unit = range.get('unit')
        val = int(range.get('value'))
        if operator == Column.__gt__:
            val = val * -1
        if unit == 'a':
            return timedelta(days=(val*365))
        elif unit == 'mo':
            return timedelta(days=(val*30))            
        else:
            raise ValueError('unknown unit ' + unit)

    @classmethod
    def get_initial_comparison_op(cls, specs, temporal_range):
        if temporal_range is None:
            return specs.get('op')
        else:
            return specs.get('inclusive')
            
    @classmethod
    def compare_svs(cls, sel, data_selectable, referrant, symbol_table, specs, temporal_range, outer, inline=True):
        return cls.simple_compare(specs.get('op'), sel, data_selectable.get_start_time(outer), referrant.get_start_time(outer), temporal_range, inline)

    @classmethod
    def compare_sve(cls, sel, data_selectable, referrant, symbol_table, specs, temporal_range, outer, inline=True):
        return cls.simple_compare(specs.get('op'), sel, data_selectable.get_start_time(outer), referrant.get_end_time(outer), temporal_range, inline)

    @classmethod
    def compare_evs(cls, sel, data_selectable, referrant, symbol_table, specs, temporal_range, outer, inline=True):
        return cls.simple_compare(specs.get('op'), sel, data_selectable.get_end_time(outer), referrant.get_start_time(outer), temporal_range, inline)

    @classmethod
    def compare_eve(cls, sel, data_selectable, referrant, symbol_table, specs, temporal_range, outer, inline=True):
        return cls.simple_compare(specs.get('op'), sel, data_selectable.get_end_time(outer), referrant.get_end_time(outer), temporal_range, inline)

    @classmethod
    def add_during(cls, sel, data_selectable, referrant, symbol_table, specs, temporal_range, outer, inline=True):
        sel = cls.simple_compare(Column.__ge__, sel, data_selectable.get_start_time(outer), referrant.get_start_time(outer), None, inline)
        return cls.simple_compare(Column.__le__, sel, data_selectable.get_end_time(outer), referrant.get_end_time(outer), None, inline)

    @classmethod
    def add_overlap(cls, sel, data_selectable, referrant, symbol_table, specs, temporal_range, outer):
        sel = sel.where(or_(
                and_(not_(data_selectable.get_end_time(outer) < referrant.get_start_time(outer)),
                     not_(referrant.get_end_time(outer) < data_selectable.get_start_time(outer))),
                and_(data_selectable.get_start_time(outer) <= referrant.get_end_time(outer),
                     data_selectable.get_end_time(outer) == None),
                and_(referrant.get_start_time(outer) <= data_selectable.get_end_time(outer),
                     referrant.get_end_time(outer) == None),
                and_(data_selectable.get_start_time(outer) == None, data_selectable.get_end_time(outer) == None)))

        return sel

    @classmethod
    def add_concurrent(cls, sel, data_selectable, referrant, symbol_table, specs, temporal_range, outer, inline=True):
        sel = cls.simple_compare(Column.__eq__, sel, data_selectable.get_start_time(outer), referrant.get_start_time(outer), None, inline)
        return cls.simple_compare(Column.__eq__, sel, data_selectable.get_end_time(outer), referrant.get_end_time(outer), None, inline)

    @classmethod
    def add_sdu(cls, sel, data_selectable, referrant, symbol_table, specs, temporal_range, outer, inline=True):
        return cls.add_xdu(sel, data_selectable.get_start_time(outer), referrant, outer, inline)

    @classmethod
    def add_edu(cls, sel, data_selectable, referrant, symbol_table, specs, temporal_range, outer, inline=True):
        return cls.add_xdu(sel, data_selectable.get_end_time(outer), referrant, outer, inline)


    @classmethod
    def add_xdu(cls, sel, time_col, referrant, outer, inline=True):
        sel = cls.simple_compare(Column.__ge__, sel, time_col, referrant.get_start_time(outer), None, inline)
        return cls.simple_compare(Column.__le__, sel, time_col, referrant.get_end_time(outer), None, inline)

    @classmethod
    def add_ecws(cls, sel, data_selectable, referrant, symbol_table, specs, temporal_range, outer, inline=True):
        sel = cls.simple_compare(Column.__eq__, sel, data_selectable.get_end_time(outer), referrant.get_start_time(outer), None, inline)

    @classmethod
    def add_scw(cls, sel, data_selectable, referrant, symbol_table, specs, temporal_range, outer, inline=True):
        sel = cls.simple_compare(Column.__eq__, sel, data_selectable.get_start_time(outer), referrant.get_start_time(outer), None, inline)

    @classmethod
    def add_ecw(cls, sel, data_selectable, referrant, symbol_table, specs, temporal_range, outer, inline=True):
        sel = cls.simple_compare(Column.__eq__, sel, data_selectable.get_end_time(outer), referrant.get_end_time(outer), None, inline)

    @classmethod
    def simple_compare(cls, operator, sel, leftcol, rightcol, temporal_range, inline=True):
        sel = sel.where(operator(leftcol, rightcol))
        if temporal_range == None:
            return sel

        low = temporal_range.get('low')
        high = temporal_range.get('high')
        if low is not None:
            if low.get('inclusive?'):
                sel = sel.where(cls.date_delta(low.get('unit'), leftcol, rightcol, inline) >= int(low.get('value')))
            else:
                sel = sel.where(cls.date_delta(low.get('unit'), leftcol, rightcol, inline) > int(low.get('value')))

        if high is not None:
            if high.get('inclusive?'):
                sel = sel.where(cls.date_delta(high.get('unit'), leftcol, rightcol, inline) <= int(high.get('value')))
            else:
                sel = sel.where(cls.date_delta(high.get('unit'), leftcol, rightcol, inline) < int(high.get('value')))

        return sel


class DataSelectable:
    ROW_NUMBER="row_number"
    SORT_DESCENDING = "sort_descending"
    ORDINAL = "ordinal"
    FUNCTION = "function"

# SORT_DESCENDING: True = sort descending, False = sort ascending, None = no sort
# ORDINAL: N means take only the Nth row, None means don't impose a single-row restriction
    SUBSET_SPECS = {'RECENT' : {SORT_DESCENDING : True, ORDINAL : 1},
                    'FIRST' : {SORT_DESCENDING : False, ORDINAL : 1},
                    'SECOND' : {SORT_DESCENDING : False, ORDINAL : 2},
                    'THIRD' : {SORT_DESCENDING : False, ORDINAL : 3},
                    'FOURTH' : {SORT_DESCENDING : False, ORDINAL : 4},
                    'FIFTH' : {SORT_DESCENDING : False, ORDINAL : 5}}
    VALUE_COL = 'value'

    select_colnames = [QDMConstants.PATIENT_ID_COL, QDMConstants.STARTTIME, QDMConstants.ENDTIME]

    def __init__(self, dc, symbol_table):
        self.dc = dc
        self.columns = dict()
        self.outer_columns = dict()
        self.symbol_table = symbol_table
        self.uncorrelated_selectable = self.create_uncorrelated_selectable(symbol_table)
        self.set_table_alias(self.uncorrelated_selectable)
        self.set_alias_name()

    def set_alias_name(self):
        self.alias_name = ('pc_' + str(self.symbol_table.get_next_seqno()) + '_' + self.dc.name)[:self.dc.max_table_alias_length]

    def get_alias_name(self):
        return self.alias_name

    def add_temporal_references_mp(self, sel):
        mp = self.symbol_table.get_measure_period()
        for t in self.dc.get_temporal_references():
            ref_name = t.get_reference()
            if ref_name == 'MeasurePeriod':
                sel = TemporalFunctions.process(t.get_operator(), sel, self, mp, self.symbol_table, t.get_range(), False)
        return sel

    def add_temporal_references_dc(self, sel):
        for t in self.dc.get_temporal_references():
            ref_name = t.get_reference()
            if ref_name != 'MeasurePeriod':
                referrant = self.symbol_table.get_data_criterion(ref_name).get_selectable(self.symbol_table)
                sel = TemporalFunctions.process(t.get_operator(), sel, self, referrant, self.symbol_table, t.get_range(), True)
        return sel


# Table linked with the person table, with code list condition
    def create_uncorrelated_selectable(self, symbol_table):
        derivation_operator = self.dc.get_derivation_operator()
        if derivation_operator == None:
            return self.create_uncorrelated_data_selectable(symbol_table)

        selectable_children = []
        for cname in self.dc.get_child_criteria_names():
            child=symbol_table.get_data_criterion(cname)
            selectable_children.append(symbol_table.get_data_criterion(cname).to_correlated_selectable(symbol_table))

        if derivation_operator == 'UNION':
            agg = union(*selectable_children)
        elif derivation_operator == 'INTERSECT':            
            agg = intersect(*selectable_children)
        else:
            raise NotImplementedError("Derivation operator " + derivation_operator + " is not implemented")

        sel = agg
        for c in sel.columns:
            self.columns[c.name] = c
            self.add_row_number_column()
        sel = sel.alias()
        self.table = sel
        return sel


    def create_selectable_codelist_only(self, symbol_table):
        self.table = symbol_table.get_data_table(self.dc.table_name())
        self.set_table_alias()
        self.initialize_columns()
        codes = symbol_table.code_lists().alias()
        join = self.table.join(codes, codes.c.code == self.table.c.code)
        sel = select(self.select_columns(symbol_table))\
            .where(codes.c.code_list_id == self.dc.get_code_list_id())\
            .select_from(join)
        self.codelist_only_selectable = sel
        return sel

    def create_uncorrelated_data_selectable(self, symbol_table):
        sel = self.create_selectable_codelist_only(symbol_table)
        sel = self.add_temporal_references_mp(sel)
        sel = self.add_subset_restrictions(sel)
        sel = self.add_value_spec(sel, self.dc.get_value())
        return sel

    def select_columns(self, symbol_table):
        cols = []
        for name in self.select_colnames:
            col = self.columns.get(name)
            if col is not None:
                cols.append(self.columns.get(name))
        return cols

    def row_column_name(self):
        return self.ROW_NUMBER + '_' + self.dc.uniqueno
    
    def initialize_columns(self):
        for c in self.table.columns:
            self.columns[c.key] = c
        self.add_row_number_column()

    def new_row_number_column(self):
        desc_flag = self.get_sort_descending_flag(self.get_subset_type())
        col = func.coalesce(self.get_start_time(False), self.get_end_time(False))
        if desc_flag == True:
            col = col.desc()
        return func.row_number().over(partition_by=self.columns.get(QDMConstants.PATIENT_ID_COL), order_by=col).label(self.row_column_name())

    def add_row_number_column(self):
        if self.get_ordinal(self.get_subset_type()) is not None:
            if self.columns.get(self.ROW_NUMBER) is None:
                self.columns[self.ROW_NUMBER] = self.new_row_number_column()
                self.select_colnames.append(self.ROW_NUMBER)

    @classmethod
    def get_ordinal_spec(cls, subset_type):
        if subset_type == None:
            return None
        d = cls.SUBSET_SPECS.get(subset_type)
        if d == None:
            raise NotImplementedError("Don't know how to apply subset operator " + subset_type)
        if d.get(cls.ORDINAL) != None:
            return d
        else:
            return None

    @classmethod
    def get_sort_descending_flag(cls, subset_type):
        d = cls.get_ordinal_spec(subset_type)
        if d == None:
            return None
        return d.get(cls.SORT_DESCENDING)

    @classmethod
    def get_ordinal(cls, subset_type):
        d = cls.get_ordinal_spec(subset_type)
        if d == None:
            return None
        return d.get(cls.ORDINAL)

    def get_subset_type(self):
        if not self.dc.has_subset_operators():
            return None
        subset_ops = self.dc.get_subset_operators()
        if len(subset_ops) > 1:
            raise NotImplementedError("Don't know how to combine subset operators " + str(subset_ops) + "in the same criterion")
        return subset_ops[0].get('type')


    def set_table_alias(self, selectable=None):
        if selectable == None:
            self.table = self.table.alias()
        else:
            self.table = selectable.alias()

    def get_column(self, colname):
        return self.columns[colname]

    def get_outer_column(self, colname):
        return self.get_column(colname)

    def get_comparison_column(self, name, outer):
        if (outer):
            return self.get_outer_column(name)
        else:
            return self.get_column(name)

    def get_start_time(self, outer):
        return self.get_comparison_column(QDMConstants.STARTTIME, outer)

    def get_end_time(self, outer):
        return self.get_comparison_column(QDMConstants.ENDTIME, outer)

    def get_unique_id(self, outer=True):
        return self.get_comparison_column(QDMConstants.UNIQUE_ID, outer)

    def add_value_spec(self, sel, val):
        if val == None:
            return sel
        valtype = val.get_value_attr('type')
        if valtype == "ANYNonNull":
            sel = sel.where(self.get_value_col() != None)
        elif valtype == "IVL_PQ":
            sel = self.add_ivl_pq(sel, val, 'low')
            sel = self.add_ivl_pq(sel, val, 'high')
        elif valtype == 'CD':
            code_list_id = val.get_value_attr('code_list_id')
            code_list_table = self.symbol_table.code_lists()
            code_map_table = self.symbol_table.individual_code_map()

            if code_list_id is not None:
                codes = select([cast(code_map_table.c.data_code, String(256))])\
                    .select_from(code_list_table.join(code_map_table, code_list_table.c.code == code_map_table.c.code))\
                .where(code_list_table.c.code_list_id == code_list_id)\
                    .alias()
                
                sel = sel.where(cast(self.get_value_col(), String(256)).in_(codes))

            code_system = val.get_value_attr('system')
            code_values = val.get_value_attr('code')

            if code_system is not None and code_values is not None:
                codes = select([cast(code_map_table.c.data_code, String(256))])\
                .where(and_(code_map_table.c.code_system == code_system,
                            code_map_table.c.measure_code.in_(code_values)))\
                .alias()

                sel = sel.where(cast(self.get_value_col(), String(256)).in_(codes))
        else:
            raise NotImplementedError("value type " + str(valtype) + " is not implemented")
        return sel

    def add_ivl_pq(self, sel, val, comparison_type):
        val_range = val.get_value_attr('range')
        if val_range == None:
            raise ValueError("No range specified in value spec for " + self.dc.name)
        attrs = val_range.get(comparison_type)
        if attrs == None:
            return sel
        value = attrs.get("value")
        col = self.get_value_col()
        if value == None:
            raise ValueError("No value specified in value spec for " + self.dc.name)
        if comparison_type == 'low':
            if attrs.get('inclusive?'):
                return(sel.where(col >= value))
            else:
                return(sel.where(col > value))
        if comparison_type == 'high':
            if attrs.get('inclusive?'):
                return(sel.where(col <= value))
            else:
                return(sel.where(col < value))
        raise NotImplementedError("Don't know how to do '" + comparison_type + "' comparison")
        

    def get_value_col(self):
        return self.get_column(self.VALUE_COL)

    def has_subset_restrictions(self):
        return self.get_ordinal(self.get_subset_type()) is not None

    def add_subset_restrictions(self, sel):
        ordinal = self.get_ordinal(self.get_subset_type())
        if ordinal is not None:
            child = sel.alias()
            sel = select(child.c)
            sel = sel.where(child.c.get(self.row_column_name()) == ordinal)
        return sel



class SpecificOccurrenceSelectable(DataSelectable):
    select_colnames = [ QDMConstants.PATIENT_ID_COL,
                        QDMConstants.UNIQUE_ID,
                        QDMConstants.STARTTIME,
                        QDMConstants.ENDTIME]
    def __init__(self, dc, symbol_table):
        DataSelectable.__init__(self, dc, symbol_table)
        # sel = self.add_temporal_references_mp(self.uncorrelated_selectable)
        # sel = self.add_subset_restrictions(sel)
        # self.uncorrelated_selectable = sel
        # self.set_table_alias(self.uncorrelated_selectable)
        self.basetable_alias = None

    def set_alias_name(self):
        self.alias_name = self.dc.so_name()

    def initialize_columns(self):
        for col in self.table.columns:
            self.columns[col.key] = col.label(self.dc.to_so_colname(col.name))
        self.add_row_number_column()

    def get_basetable_alias(self, symbol_table):
        if self.basetable_alias == None:
            sel = self.codelist_only_selectable
            self.basetable_alias = sel.alias(name=self.dc.so_name())
        return self.basetable_alias

    def get_outer_column(self, name):
        return self.outer_columns.get(name)


class ExtendedDataCriterion(DataCriterion, TemporalReferrant):
    def __init__(self, dc, uniqueno, max_identifier_length=64, max_column_length=32):
        self.name = dc.name
        self.dc = dc
        self.tbl = None
        self.columns = dict()
        self.uniqueno = str(uniqueno)
        self.max_identifier_length=max_identifier_length
        self.max_column_length = max_column_length
        self.max_table_alias_length=max_identifier_length - (self.max_column_length + 1)

    def is_specific_occurrence(self):
        return self.dc.is_specific_occurrence()

    def get_subset_operators(self):
        return self.dc.get_subset_operators()

    def get_derivation_operator(self):
        return self.dc.get_derivation_operator()

    def has_subset_operators(self):
        return len(self.dc.get_subset_operators()) > 0

    def get_child_criteria_names(self):
        return self.dc.get_child_criteria_names()

    def to_sql(self, symbol_table, name):
        return exists([self.to_select_alias(symbol_table, name)])

    def new_selectable(self, symbol_table):
        return DataSelectable(self, symbol_table)

    def table_name(self):
        if self.dc.get_status_attribute() == None:
            return self.dc.get_definition_attribute()
        return self.dc.get_definition_attribute() + '_' + self.dc.get_status_attribute()

    def get_code_list_id(self):
        return self.dc.get_code_list_id()
    
    def so_const(self):
        return self.dc.so_const()

    def so_inst(self):
        return self.dc.so_inst()

    def add_patient_anchor(self, sel, data_selectable, symbol_table):
        return sel.where(symbol_table.get_anchor_column() == data_selectable.columns.get(QDMConstants.PATIENT_ID_COL))

    def add_event_anchor(self, sel, data_selectable, symbol_table):
        return sel

    def _to_correlated_selectable(self, symbol_table):
        data_selectable = self.get_selectable(symbol_table)
        sel = data_selectable.uncorrelated_selectable
        if self.dc.get_derivation_operator() == None:
            sel = self.add_patient_anchor(sel, data_selectable, symbol_table)
            sel = self.add_event_anchor(sel, data_selectable, symbol_table)
            #        sel = data_selectable.add_temporal_references_mp(sel)
            #        sel = data_selectable.add_subset_restrictions(sel)
            sel = data_selectable.add_temporal_references_dc(sel)
            sel = sel.correlate(symbol_table.base_select)
        return [sel, data_selectable]

    def to_correlated_selectable(self, symbol_table):
        return self._to_correlated_selectable(symbol_table)[0]

    def to_select_alias(self, symbol_table, name):
        (sel, data_selectable) = self._to_correlated_selectable(symbol_table)
        if name == None:
            name = self.name
        return sel.alias(name=data_selectable.get_alias_name())

    def so_name(self):
        return ('so_' + self.uniqueno + '_' + self.dc.name)[:self.max_table_alias_length]

    def to_so_colname(self, colname):
        colname = self.so_name() + '_' + colname
        if len(colname) > self.max_identifier_length:
            raise ValueError("Column " + colname + " too long - adjust max_identifier_length or max_column_length")
        return colname

    def get_temporal_references(self):
        return self.dc.temporal_references

    def get_selectable(self, symbol_table):
        return self.new_selectable(symbol_table)

    def get_subset_type(self):
        if not self.dc.has_subset_operators():
            return None
        subset_ops = self.dc.get_subset_operators()
        if len(subset_ops) > 1:
            raise NotImplementedError("Don't know how to combine subset operators " + str(subset_ops) + "in the same criterion")
        return subset_ops[0].get('type')


    def row_number_col(self):
        self.add_row_number_column()
        return self.columns[self.ROW_NUMBER]

    def get_value_col(self):
        return self.get_column(self.VALUE_COL)

    def get_value(self):
        return self.dc.get_value()



class ExtendedSpecificOccurrence(ExtendedDataCriterion):
    def __init__(self, dc, seqno, max_identifier_length=64, max_column_length=32):
        ExtendedDataCriterion.__init__(self, dc, seqno, max_identifier_length, max_column_length)
        self.so_selectable = None

    def new_selectable(self, symbol_table):
        return SpecificOccurrenceSelectable(self, symbol_table)

    def get_selectable(self, symbol_table):
        if self.so_selectable == None:
            self.so_selectable = self.new_selectable(symbol_table)
        return self.so_selectable

    def to_basetable_alias(self, symbol_table):
        data_selectable = self.get_selectable(symbol_table)
        return data_selectable.get_basetable_alias(symbol_table)

    def get_unique_id(self, symbol_table=None):
        return self.get_selectable(symbol_table).get_unique_id()

    def add_event_anchor(self, sel, data_selectable, symbol_table):
        return sel.where(data_selectable.get_column(QDMConstants.UNIQUE_ID) == data_selectable.get_outer_column(QDMConstants.UNIQUE_ID))



class MyTimeStamp(TypeDecorator):
    impl = TIMESTAMP

    def process_literal_param(self, value, dialect):
        return "'" + value.isoformat() + "'"

class ExtendedMeasurePeriod(MeasurePeriod):
    def __init__(self, raw_mp):
        self.raw_mp = raw_mp

    def get_start_time(self, outer):
        return cast(self.raw_mp.get_start_time(), MyTimeStamp).label('measure_start_time')

    def get_end_time(self, outer):
        return cast(self.raw_mp.get_end_time(), MyTimeStamp).label('measure_end_time')

    def raw_start_time(self):
        return self.raw_mp.get_start_time()

    def raw_end_time(self):
        return self.raw_mp.get_end_time()

class ExtendedSymbolTable(SymbolTable):

    CODE_LISTS='code_lists'
    INDIVIDUAL_CODE_MAP='individual_code_map'
    PATIENTS = 'patients'
    BASE_PREFIX='base_'

    def __init__(self, raw_symbol_table, db):
        SymbolTable.__init__(self)
        self.set_db(db)
        self.population_criteria = dict()
        self.specific_occurrences = dict()
        self.raw_symbol_table = raw_symbol_table
        self.measure_period = ExtendedMeasurePeriod(raw_symbol_table.measure_period)
        self.seqno = 0
        self.inline_preference=False
        for name in raw_symbol_table.get_data_criteria_names_used():
            self.seqno = self.seqno + 1
            dc = raw_symbol_table.get_data_criterion(name)
            if dc.is_specific_occurrence():
                edc = ExtendedSpecificOccurrence(dc, self.seqno)
                self.data_criteria[name] = edc
                self.add_specific_occurrence(edc)
            else:
                self.data_criteria[name] = ExtendedDataCriterion(dc, self.seqno)

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

    def get_table(self, schema, name):
        return self.db.get_table(schema, name)

    def get_anchor_column(self):
        return self.anchor_column

    def get_anchor_table(self):
        return self.anchor_table

    def code_lists(self):
        return self.code_lists_table

    def individual_code_map(self):
        return self.individual_code_map_table

    def get_metadata(self, name):
        return self.raw_symbol_table.get_metadata(name)

    def get_outer_col(self, name):
#        return self.outer_columns.get(name)
        return self.base_select.c.get(self.outer_colname(name))

    def add_specific_occurrence(self, dc):
        if dc.is_specific_occurrence():
            so_const = dc.so_const()
            so_inst = dc.so_inst()
            if self.specific_occurrences.get(so_const) == None:
                self.specific_occurrences[so_const] = {so_inst : dc}
            elif self.specific_occurrences.get(so_const).get(so_inst) == None:
                self.specific_occurrences.get(so_const)[so_inst] = dc

    def get_populations(self):
        return self.raw_symbol_table.populations

    def create_base_query(self):
        self.anchor_table = self.get_data_table(self.PATIENTS).alias(self.BASE_PREFIX + self.PATIENTS)
        anchor_column = self.anchor_table.c.get(QDMConstants.PATIENT_ID_COL).label(self.outer_colname(QDMConstants.PATIENT_ID_COL))
        base_from = self.anchor_table
        base_select_cols = [anchor_column]

        so_list = list(toposort_flatten(self.raw_symbol_table.so_temporal_dependencies))
        self.merge_so_lists(so_list, self.raw_symbol_table.data_criteria_names_used)
        so_done = []
        for so_name in so_list:
            so = self.get_data_criterion(so_name)
            so_select = so.to_basetable_alias(self)
            so_entry = {'criterion' : so, 'unique_col' : so_select.c.get(so.to_so_colname(QDMConstants.UNIQUE_ID))}
            join_conds = [so_select.c.get(so.to_so_colname(QDMConstants.PATIENT_ID_COL)) == anchor_column]
            for entry in so_done:
                other = entry.get('criterion')
                so_unique = so_select.c.get(so.to_so_colname(QDMConstants.UNIQUE_ID))
                if other.so_const() == so.so_const():
                    if other.so_inst() == so.so_inst():
                        join_conds.append(so_entry.get('unique_col') == entry.get('unique_col'))
                    else:
                        join_conds.append(so_entry.get('unique_col') != entry.get('unique_col'))
            so_done.append(so_entry)
            base_from = base_from.join(so_select,
                                       and_(*join_conds),
                                       isouter=True)
            for c in so_select.columns:
                base_select_cols.append(c)
        base_select = select(base_select_cols).select_from(base_from)

#        for so_name in so_list:
#            selectable = self.get_data_criterion(so_name).get_selectable(self)
#            for other in so_done:
#                if other.dc.so_const() == selectable.dc.so_const():
#                    if other.dc.so_inst() == selectable.dc.so_inst():
#                        base_select = base_select.where(selectable.get_unique_id(False) == other.get_unique_id(False))
#                    else:
#                        base_select = base_select.where(so.get_unique_id(False) != other.get_unique_id(False))
#            so_done.add(selectable)

        self.base_select = base_select.alias('patient_base')
        for so_name in so_list:
            so = self.get_data_criterion(so_name)
            so_selectable = so.get_selectable(self)
            for key in so_selectable.columns.keys():
                col = self.base_select.corresponding_column(so_selectable.columns[key])
                if col is not None:
                    so_selectable.outer_columns[key] = col

        self.anchor_column = self.base_select.corresponding_column(anchor_column)
#        self.anchor_column = self.base_select.c.get(self.outer_colname(QDMConstants.PATIENT_ID_COL))

    def merge_so_lists(self, so_list, additional_criteria):
        for dc_name in additional_criteria:
            dc = self.get_data_criterion(dc_name)
            if dc.is_specific_occurrence():
                found = False
                for so_name in so_list:
                    if so_name == dc_name:
                        found = True
                        break
                if not found:
                    so_list.append(dc_name)
    
    def outer_colname(self, name):
        return self.BASE_PREFIX + name

    def set_population_criteria(self, population_name, population_criteria):
        self.population_criteria[population_name] = population_criteria

    def get_population_criteria_by_name(self, population_name):
        return self.population_criteria.get(population_name)

    def get_population_criteria_by_type(self, population_type):
        name = self.get_population_name(population_type)
        if name == None:
            return None
        return self.population_criteria.get_population_criteria_by_name(name)

    def get_data_table(self, table_name):
        return self.db.get_table(HQMF, table_name)

    def get_valueset_table(self, table_name):
        return self.db.get_table(VALUESET, table_name)

    def get_measure_metadata(self):
        return self.raw_symbol_table.metadata


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
        return self.meta.tables[self.schemas.get(schema) + '.' + table_name]

    def get_tables(self):
        return self.meta.tables

    def hqmf_table_name(self, name):
        return(self.hqmf_schema + '.' + name)

    def valueset_table_name(self, name):
        return(self.valueset_schema + '.' + name)


class BasePrecondition:
    def __init__(self, population_name):
        self.id = None
        self.negation = None
        self.conjunction_code = None
        self.population_name = population_name
    def to_json(self):
        return {'id' : self.id, 'negation' : self.negation,
                'conjunction_code' : self.conjunction_code,'type' : str(type(self)),
                'enclosing_populaton' : self.population_name}

class SinglePrecondition(BasePrecondition):
    def __init__(self, population_name):
        BasePrecondition.__init__(self, population_name)
        self.child = None
        self.conjunction_type = None
    def add_child(self, child):
        if self.child != None:
            raise ValueError("Trying to add a second child to a SinglePrecondition")
        self.child = child
    def to_json(self):
        retval = BasePrecondition.to_json(self)
        retval['child'] = self.child.to_json()
        return retval
    def to_sql(self, symbol_table, name=None):
        csql = self.child.to_sql(symbol_table, name)
        if self.conjunction_type == None:
            if isinstance(csql, list):
                flatsql = and_(*csql)
            else:
                flatsql = csql
        elif self.conjunction_type == 'allTrue':
            flatsql = and_(*csql)
        elif self.conjunction_type == 'atLeastOneTrue':
            flatsql = or_(*csql)
        elif self.conjunction_type == 'allFalse':
            flatsql = not_(or_(*csql))
        else:
            raise ValueError("unknown conjunction code: " + self.conjunction_type)
        if self.negation == True:
            flatsql = not_(flatsql)
        return flatsql

class Preconditions(BasePrecondition):
    def __init__(self, population_name):
        BasePrecondition.__init__(self, population_name)
        self.children = []
    def add_child(self, child):
        self.children.append(child)
    def to_json(self):
        retval = BasePrecondition.to_json(self)
        children = []
        for child in self.children:
            children.append(child.to_json())
        retval['children'] = children
        return(retval)
    def to_sql(self, symbol_table, name=None):
        # Special case -- if there's exactly one child, and it's a list, return it.
        if len(self.children) == 1 and type(self.children[0]) == list:
            return self.children[0].to_sql(symbol_table)
        sql_children = []
        for child in self.children:
            c = child.to_sql(symbol_table)
            sql_children.append(child.to_sql(symbol_table))
        return sql_children

class PopulationCriterion:
    def __init__(self, name):
        self.population_name = name
        self.precondition = None
        self.metadata = dict()

    def add_child(self, child):
        self.precondition = child
    def to_json(self):
        retval = {'population_name' : self.population_name}
        if self.precondition != None:
            retval['precondition'] = self.precondition.to_json()
        return retval
    def to_sql(self, symbol_table, name = None):
        if self.precondition == None:
            return select([true()])
        psql = self.precondition.to_sql(symbol_table, name)
        while type(psql) == list:
            if len(psql) == 1:
                psql = psql[0]
            else:
                raise ValueError("precondition length is " + str(len(psql)))
        return psql

class SQLGenerator (HQMFParserListener) :
    supplemental_codes = {"race" : [4013886], \
                              "ethnicity" : [4271761], \
                              "payer" : [3048872], \
                              "sex" : [8507, 8532], \
                              "zip" : [4083591]}

    def __init__(self, dburl, hqmf_schema, result_schema, symbol_table, print_json = False, print_sql = True, cohort_schema=None, inline_preference=True):
        self.db = DBConnection(dburl, hqmf_schema)
        self.symbol_table = ExtendedSymbolTable(symbol_table, self.db)
        self.symbol_table.set_inline_preference(inline_preference)
        self.result_util = HQMFResultUtil(result_schema)
        self.print_json = print_json
        self.print_sql = print_sql
#        self.cols = None
        self.populations = []

    def enterPopulation_criterion(self, ctx):
        name = strip_quotes(ctx.any_string().getText())
        ctx.parsed_pc = PopulationCriterion(name)
        self.symbol_table.set_population_criteria(name, ctx.parsed_pc)

    def enterPopCritStringMetadata(self, ctx):
        pc = ctx.parentCtx.parsed_pc
        name = strip_quotes(ctx.pop_crit_string_metadata_name().getText())
        val =  strip_quotes(ctx.any_string().getText())
        pc.metadata[name] = val

    def enterPopCritBooleanMetadata(self, ctx):
        pc = ctx.parentCtx.parsed_pc
        name = strip_quotes(ctx.pop_crit_boolean_metadata_name().getText())
        val =  string_to_boolean(ctx.boolean_value().getText())
        pc.metadata[name] = val

    def exitPopulation_criterion(self, ctx):
        self.populations.append(ctx.parsed_pc)
        if self.print_json:
            print(json.dumps(ctx.parsed_pc.to_json(), indent=2, cls=HQMFCustomEncoder))


    def enterPreconditions(self, ctx):
        ctx.parsed_pc = Preconditions(ctx.parentCtx.parsed_pc.population_name)

    def exitPreconditions(self, ctx):
        ctx.parentCtx.parsed_pc.add_child(ctx.parsed_pc)

    def enterSingle_precondition(self, ctx):
        ctx.parsed_pc = SinglePrecondition(ctx.parentCtx.parsed_pc.population_name)

    def exitSingle_precondition(self, ctx):
        ctx.parentCtx.parsed_pc.add_child(ctx.parsed_pc)

    def enterPopulationPreconditions(self, ctx):
        ctx.parsed_pc = Preconditions(ctx.parentCtx.parsed_pc.population_name)

    def exitPopulationPreconditions(self, ctx):
        ctx.parentCtx.parsed_pc.add_child(ctx.parsed_pc)

    def enterPCID(self, ctx):
        id = ctx.NUMBER().getText()
        ctx.parentCtx.parsed_pc.id = id

    def enterPCConjunctionType(self, ctx):
        ctx.parentCtx.parsed_pc.conjunction_type=strip_quotes(ctx.conjunction_type().getText())

    def enterPCReference(self, ctx):
        data_criterion = self.symbol_table.get_data_criterion(strip_quotes(ctx.any_string().getText()))
        if data_criterion == None:
            raise ValueError("null data criterion" + strip_quotes(ctx.any_string().getText()))
        ctx.parentCtx.parsed_pc.add_child(data_criterion)

    def enterPCNegation(self, ctx):
        ctx.parentCtx.parsed_pc.negation = string_to_boolean(ctx.boolean_value().getText())

    def enterPCConjunction(self, ctx):
        ctx.parentCtx.parsed_pc.conjunction = string_to_boolean(ctx.boolean_value().getText())
        
    def viewname_all(self):
        return self.measure_name() + '_all'

    def measure_name(self):
        return self.symbol_table.get_metadata('cms_id').lower()

    def exitHqmf(self, ctx):
        if self.print_json:
            print(json.dumps(ctx.parsed_pc.to_json(), indent=2, cls=HQMFCustomEncoder))
        if self.print_sql:
            base_query = self.symbol_table.create_base_query()
            cols=self.symbol_table.base_select.columns.values()
            for pop in self.populations:
                cols.append(pop.to_sql(self.symbol_table).label(pop.population_name))
            query = select(cols)
            print(self.result_util.create_view(self.viewname_all(), query))
            self.create_measure_metadata_tables()
            self.create_patient_summary_table()
            self.create_measure_totals_view()
            self.create_supplemental_results_table()

    def create_measure_metadata_tables(self):
        metadata_table = Table(self.measure_name() + '_measure_metadata', self.db.meta,
                               Column('measure_id', String(256)),
                               Column('hqmf_id', String(256)),
                               Column('hqmf_set_id', String(256)),
                               Column('hqmf_version_number', Integer),
                               Column('population_name', String(256)),
                               Column('title', String(256)),
                               Column('description', String(256)),
                               Column('cms_id', String(256)),
                               Column('stratification', String(256)),
                               Column('stratum_name', String(256)),
                               Column('measure_period_start', String(256)),
                               Column('measure_period_end', String(256)),
                               schema=self.result_util.get_schema())
        print(str(CreateTable(metadata_table, bind=self.db.engine)))
        print(self.result_util.statement_terminator())

        population_metadata_table = Table(self.measure_name() + '_population_metadata', self.db.meta,
                                          Column('measure_id', String(256)),
                                          Column('cms_id', String(256)),
                                          Column('measure_hqmf_id', String(256)),
                                          Column('population_name', String(256)),
                                          Column('population_criterion_type', String(256)),
                                          Column('population_criterion_name', String(256)),
                                          Column('hqmf_id', String(256)),
                                          schema=self.result_util.get_schema())
        print(str(CreateTable(population_metadata_table, bind=self.db.engine)))
        print(self.result_util.statement_terminator())

                                          
        measure_metadata = self.symbol_table.get_measure_metadata()
        for pop in self.symbol_table.get_populations():
            # An insert with values would be more straightforward, but the raw sql print doesn't work
            query = select([
                    self.constant_string(measure_metadata.get('id')).label('measure_id'),
                    self.constant_string(measure_metadata.get('hqmf_id')).label('hqmf_id'),
                    self.constant_string(measure_metadata.get('hqmf_set_id')).label('hqmf_set_id'),
                    cast(measure_metadata.get('hqmf_version_number'), Integer).label('hqmf_version_number'),
                    self.constant_string(pop.get_population_metadata('id')).label('population_name'),
                    self.constant_string(measure_metadata.get('title')).label('title'),
                    self.constant_string(measure_metadata.get('description')).label('description'),
                    self.constant_string(measure_metadata.get('cms_id').lower()).label('cms_id'),
                    self.constant_string(pop.get_population_metadata('stratification')).label('stratification'),
                    self.constant_string(pop.get_population_metadata('title')).label('stratum_name'),
                    self.constant_string(self.symbol_table.get_measure_period().raw_start_time().strftime('%Y%m%d')).label('measure_period_start'),
                    self.constant_string(self.symbol_table.get_measure_period().raw_end_time().strftime('%Y%m%d')).label('measure_period_end')])
            ins = metadata_table.insert().from_select([
                               'measure_id',
                               'hqmf_id',
                               'hqmf_set_id',
                               'hqmf_version_number',
                               'population_name',
                               'title',
                               'description',
                               'cms_id',
                               'stratification',
                               'stratum_name',
                               'measure_period_start',
                               'measure_period_end'], query)
            print(sql_to_string(ins))
            print(self.result_util.statement_terminator())

            self.fill_population_metadata_table(population_metadata_table, measure_metadata, pop)
            self.population_metadata_table = population_metadata_table

    def fill_population_metadata_table(self, table, measure_metadata, pop):
        for t in ['ipp', 'denom', 'denex', 'numer', 'denexcep', 'strat']:
            pc_name = pop.population_names.get(t.upper())
            if pc_name is not None:
                pc = self.symbol_table.population_criteria.get(pc_name)
                query = select([
                        self.constant_string(measure_metadata.get('id')).label('measure_id'),
                        self.constant_string(measure_metadata.get('hqmf_id')).label('measure_hqmf_id'),
                        self.constant_string(measure_metadata.get('cms_id').lower()).label('cms_id'),
                        self.constant_string(pop.get_population_metadata('id')).label('population_name'),
                        self.constant_string(t).label('population_crierion_type'),
                        self.constant_string(pc.population_name).label('population_criterion_name'),
                        self.constant_string(pc.metadata.get('hqmf_id')).label('hqmf_id')])
                ins = table.insert().from_select([
                        'measure_id',
                        'measure_hqmf_id',
                        'cms_id',
                        'population_name',
                        'population_criterion_type',
                        'population_criterion_name',
                        'hqmf_id'], query)
                print(sql_to_string(ins))
                print(self.result_util.statement_terminator())


    def create_patient_summary_table(self):
        result_table = Table(self.measure_name() + '_patient_summary', self.db.meta,
                             Column('population_id', String(256)),
                             Column('title', String(256)),
                             Column('strat_id', String(256)),
                             Column('patient_id', Integer),
                             Column('effective_ipp', Boolean),
                             Column('effective_denom', Boolean),
                             Column('effective_denex', Boolean),
                             Column('effective_numer', Boolean),
                             Column('effective_denexcep', Boolean),
                             schema=self.result_util.get_schema())

        print(str(CreateTable(result_table, bind=self.db.engine)))
        print(self.result_util.statement_terminator())

        for pop in self.symbol_table.get_populations():
            popquery = self.make_popquery(pop)
            ins = result_table.insert().from_select([
                    'population_id',
                    'title',
                    'strat_id',
                    'patient_id',
                    'effective_ipp',
                    'effective_denom',
                    'effective_denex',
                    'effective_numer',
                    'effective_denexcep'], popquery)
            print(sql_to_string(ins))
            print(self.result_util.statement_terminator())
        self.patient_summary_table = result_table

    def create_measure_totals_view(self):
        result_table = Table(self.measure_name() + '_results', self.db.meta,
                             Column('measure_id', String(256)),
                             Column('cms_id', String(256)),
                             Column('measure_hqmf_id', String(256)),
                             Column('population_name', String(256)),
                             Column('population_criterion_type', String(256)),
                             Column('population_criterion_name', String(256)),
                             Column('hqmf_id', String(256)),
                             Column('strat_id', String(256)),
                             Column('total', Integer),
                             schema=self.result_util.get_schema())

        print(str(CreateTable(result_table, bind=self.db.engine)))
        print(self.result_util.statement_terminator())

        for t in ['ipp', 'denom', 'denex', 'numer', 'denexcep']:
            query = select([
                    self.population_metadata_table.c.measure_id,
                    self.population_metadata_table.c.cms_id,
                    self.population_metadata_table.c.measure_hqmf_id,
                    self.population_metadata_table.c.population_name.label('population_name'),
                    self.population_metadata_table.c.population_criterion_type,
                    self.population_metadata_table.c.population_criterion_name,
                    self.population_metadata_table.c.hqmf_id,
                    self.patient_summary_table.c.strat_id,
                    sum(cast(self.patient_summary_table.c.get('effective_' + t), Integer)).label('total')])\
                    .select_from((self.population_metadata_table)\
                                     .join(self.patient_summary_table,
                                           or_(
                                self.patient_summary_table.c.population_id == self.population_metadata_table.c.population_name,
                                and_(self.patient_summary_table.c.population_id == None,
                                     self.population_metadata_table.c.population_name == None))))\
                                     .group_by(*(self.population_metadata_table.c + [self.patient_summary_table.c.strat_id]))\
                    .where(self.population_metadata_table.c.population_criterion_type == t)
            ins = result_table.insert().from_select([
                    'measure_id',
                    'cms_id',
                    'measure_hqmf_id',
                    'population_name',
                    'population_criterion_type',
                    'population_criterion_name',
                    'hqmf_id',
                    'strat_id',
                    'total'], query)
            print(sql_to_string(ins))
            print(self.result_util.statement_terminator())


    def create_supplemental_results_table(self):
        result_table = Table(self.measure_name() + '_supplemental_results', self.db.meta,
                             Column('measure_id', String(256)),
                             Column('cms_id', String(256)),
                             Column('measure_hqmf_id', String(256)),
                             Column('population_id', String(256)),
                             Column('population_criterion_type', String(256)),
                             Column('population_criterion_name', String(256)),
                             Column('hqmf_id', String(256)),
                             Column('strat_id', String(256)),
                             Column('supplemental_code', String(256)),
                             Column('supplemental_value', String(256)),
                             Column('total', Integer),
                             schema=self.result_util.get_schema())

        print(str(CreateTable(result_table, bind=self.db.engine)))
        print(self.result_util.statement_terminator())

        characteristic_table = self.db.get_table(HQMF, 'individual_characteristic')
        for key in self.supplemental_codes.keys():
            for t in ['ipp', 'denom', 'denex', 'numer', 'denexcep']:
                query = select([
                        self.population_metadata_table.c.measure_id,
                        self.population_metadata_table.c.cms_id,
                        self.population_metadata_table.c.measure_hqmf_id,
                        self.population_metadata_table.c.population_name,
                        self.population_metadata_table.c.population_criterion_type,
                        self.population_metadata_table.c.population_criterion_name,
                        self.population_metadata_table.c.hqmf_id,
                        self.patient_summary_table.c.strat_id,
                        cast(key, String(256)).label('supplemental_code'),
                        characteristic_table.c.value.label('supplemental_value'),
                        sum(cast(self.patient_summary_table.c.get('effective_' + t), Integer)).label('total')])\
                        .where(characteristic_table.c.code.in_(self.supplemental_codes.get(key)))\
                        .select_from((self.population_metadata_table)\
                                         .join(self.patient_summary_table,
                                               or_(
                                    self.patient_summary_table.c.population_id == self.population_metadata_table.c.population_name,
                                    and_(self.patient_summary_table.c.population_id == None,
                                         self.population_metadata_table.c.population_name == None)))\
                                         .join(characteristic_table,
                                               characteristic_table.c.patient_id == self.patient_summary_table.c.patient_id))\
                        .where(and_(
                                                       self.population_metadata_table.c.population_criterion_type == t,
                                                       characteristic_table.c.code.in_(self.supplemental_codes.get(key))))\
                        .group_by(*[
                                                       self.population_metadata_table.c.measure_id,
                                                       self.population_metadata_table.c.cms_id,
                                                       self.population_metadata_table.c.measure_hqmf_id,
                                                       self.population_metadata_table.c.population_name,
                                                       self.population_metadata_table.c.population_criterion_type,
                                                       self.population_metadata_table.c.population_criterion_name,
                                                       self.population_metadata_table.c.hqmf_id,
                                                       self.patient_summary_table.c.strat_id,
                                                       characteristic_table.c.value])

                ins = result_table.insert().from_select([
                        'measure_id',
                        'cms_id',
                        'measure_hqmf_id',
                        'population_id',
                        'population_criterion_type',
                        'population_criterion_name',
                        'hqmf_id',
                        'strat_id',
                        'supplemental_code',
                        'supplemental_value',
                        'total'], query)
                print(sql_to_string(ins))
                print(self.result_util.statement_terminator())

    def constant_string(self, str):
        return cast(str, String(256))
        
    def make_popquery(self, pop):
        cdict = dict()
        unstratified_ipp = self.unstratified_ipp_col(pop)
        self.make_ipp_col(unstratified_ipp, cdict, pop.get_population_metadata('STRAT'))
        self.make_denom_col(pop, cdict)
        self.make_denex_col(pop, cdict)
        self.make_numer_col(pop, cdict)
        self.make_denexcep_col(pop, cdict)
        self.make_strat_col(pop, cdict)

        fromview = text(self.result_util.qualified_artifact_name(self.viewname_all()))
        pname = pop.get_population_metadata('id')
        if pname is None:
            basename = self.measure_name()
        else:
            basename = self.measure_name() + '_' + pname.lower()
        viewname = basename + '_patient_summary'
        patient_col = column('base_patient_id')

        order_cols=[]
        for key in ['DENEX', 'NUMER', 'DENEXCEP', 'DENOM']:
            col = cdict.get(key)
            if col is None:
                cdict[key] = cast(null(), Boolean)
            else:
                order_cols.append(col.desc())

        if cdict.get('STRAT') is None:
            cdict['STRAT'] = cast(null(), Boolean)

        summary_cols = [
            self.constant_string(pname).label('population_id'),
            self.constant_string(pop.get_population_metadata('title')).label('title'),
            self.constant_string(pop.get_population_metadata('stratification')).label('strat_id'),
            patient_col.label('patient_id'),
            cdict.get('IPP').label('effective_ipp'),
            cdict.get('DENOM').label('effective_denom'),
            cdict.get('DENEX').label('effective_denex'),
            cdict.get('NUMER').label('effective_numer'),
            cdict.get('DENEXCEP').label('effective_denexcep'),
            ]

        rowcol = func.rank().over(partition_by=patient_col, order_by = order_cols)
        summary_cols.append(rowcol.label('rank'))
        base = select(summary_cols).select_from(fromview).where(unstratified_ipp).alias()
        query=select([
                base.c.population_id,
                base.c.title,
                base.c.strat_id,
                base.c.patient_id,
                base.c.effective_ipp,
                base.c.effective_denom,
                base.c.effective_denex,
                base.c.effective_numer,
                base.c.effective_denexcep]).where(base.c.rank == 1).distinct()

        return(query.alias())

    def unstratified_ipp_col(self, pop):
        sname = pop.population_names.get('IPP')
        if sname is None:
            raise ValueError("No IPP in population")
        return column(sname)


    def make_ipp_col(self, unstratified_ipp, cdict, strat):
        if strat == None:
            cdict['IPP'] = unstratified_ipp
        else:
            cdict['IPP'] = and_(unstratified_ipp, column(strat))

    def make_denom_col(self, pop, cdict):
        sname = pop.population_names.get('DENOM')
        if sname is None:
            raise ValueError("No DENOM in population")
        denom = column(sname)
        ipp = cdict.get('IPP')
        cdict['DENOM'] = and_(ipp, denom)

    def make_denex_col(self, pop, cdict):
        sname = pop.population_names.get('DENEX')
        if sname is None:
            return
        denex = column(sname)
        denom = cdict.get('DENOM')
        cdict['DENEX'] = and_(denom, denex)

    def make_numer_col(self, pop, cdict):
        sname = pop.population_names.get('NUMER')
        if sname is None:
            raise ValueError("No NUMER in population")
        numer = column(sname)
        denom = cdict.get('DENOM')
        denex = cdict.get('DENEX')
        if denex is not None:
            numer = and_(denom, not_(denex), numer)
        else:
            numer = and_(denom, numer)
        cdict['NUMER'] = numer

    def make_denexcep_col(self, pop, cdict):
        sname = pop.population_names.get('DENEXCEP')
        if sname is None:
            return
        denexcep = column(sname)
        numer = cdict.get('NUMER')
        denom = cdict.get('DENOM')
        denex = cdict.get('DENEX')
        if denex is not None:
            denexcep = and_(denom, not_(denex), not_(numer), denexcep)
        else:
            denexcep = and_(denom, not_(numer), denexcep)

    def make_strat_col(self, pop, cdict):
        sname = pop.population_names.get('STRAT')
        if sname is None:
            return
        cdict['STRAT'] = column(sname)
