#!/usr/bin/python

from sqlalchemy import *
from sqlalchemy.sql.expression import *
from sqlalchemy.schema import CreateTable, DropTable
from sqlalchemy.exc import *
from HQMFUtil import *

RESULT_COLUMN_PREFIX="effective_"
EXPECTED_SUFFIX="_expected"

class TestKey:

    def __init__(self, dburl, key_schema):
        self.engine = create_engine(dburl)
        self.meta = MetaData(bind=self.engine)
        self.key_schema = key_schema
        self.comparison_tables = dict()

    @staticmethod
    def terminated_statement(stmt):
        return(stmt + ";")

    def key_table_name(self, measure):
        return(measure + "_patient_summary")

    def comparison_table_name(self, measure):
        return(measure + "_comparison")

    def create_test_detail_table(self, source_schema):
        self.test_detail_table = Table('test_detail', self.meta,
                                       Column('measure_id', String(256)),
                                       Column('population_id', String(256)),
                                       Column('patient_id', Integer),
                                       Column('agreement', Boolean),
                                       schema=source_schema)
        print(self.terminated_statement(str(DropTable(self.test_detail_table, bind=self.engine))))
        print(self.terminated_statement(str(CreateTable(self.test_detail_table, bind=self.engine))))

    def add_test_detail(self, measure):
        ctable = self.comparison_tables.get(measure)
        conditions = []
        for col in ctable.c:
            if col.name.endswith(EXPECTED_SUFFIX):
                basename = col.name[:len(col.name) - len(EXPECTED_SUFFIX)]
                conditions.append(
                    or_(
                        and_(
                            ctable.c.get(basename) == None,
                            ctable.c.get(basename + EXPECTED_SUFFIX) == None),
                        ctable.c.get(basename) == ctable.c.get(basename + EXPECTED_SUFFIX)))
        query = select([
                cast(measure, String(256)).label('measure_id'),
                ctable.c.population_id,
                ctable.c.patient_id,
                and_(*conditions)]).select_from(ctable)
        ins = self.test_detail_table.insert().from_select([
                'measure_id',
                'population_id',
                'patient_id',
                'agreement'], query)
        print(self.terminated_statement(sql_to_string(ins)))
                

    def make_key_table(self, measure, source_schema):
        stable = Table(self.key_table_name(measure), self.meta,
                       schema=source_schema, autoload=True)
        dtable = Table(stable.name, self.meta, schema=self.key_schema)
        cnames=[]
        for c in stable.columns:
            dtable.append_column(Column(c.name, c.type))
            cnames.append(c.name)
        print(self.terminated_statement(str(DropTable(dtable, bind=self.engine))))
        print(self.terminated_statement(str(CreateTable(dtable, bind=self.engine))))
        query = select(stable.c)
        ins = dtable.insert().from_select(cnames, query)
        print(self.terminated_statement(sql_to_string(ins)))

    def make_comparison_table(self, measure, source_schema):
        key_fields = ['patient_id', 'population_id']
        all_cols = []
        key_table = Table(self.key_table_name(measure), self.meta, schema=self.key_schema, autoload=True)
        source_table = Table(self.key_table_name(measure), self.meta, schema=source_schema, autoload=True)

        for field in key_fields:
            kcol = key_table.c.get(field)
            all_cols.append(kcol)

        for col in key_table.c:
            if col.name.startswith(RESULT_COLUMN_PREFIX):
                basename=col.name[len(RESULT_COLUMN_PREFIX):]
                all_cols.append(source_table.c.get(col.name).label(basename))
                all_cols.append(col.label(basename + EXPECTED_SUFFIX))

        cnames = []
        table = Table(self.comparison_table_name(measure), self.meta, schema=source_schema)
        for col in all_cols:
            table.append_column(Column(col.name, col.type))
            cnames.append(col.name)
        print(self.terminated_statement(str(DropTable(table, bind=self.engine))))
        print(self.terminated_statement(str(CreateTable(table, bind=self.engine))))

        join_conds = []
        for field in key_fields:
            scol=source_table.c.get(field)
            dcol = key_table.c.get(field)
            join_conds.append(or_(
                    and_(scol == None, dcol == None),
                    scol == dcol))

        query = union(
            select(all_cols).\
                select_from(key_table.\
                                join(source_table, and_(*join_conds), isouter=True)),
            select(all_cols).\
                select_from(source_table.\
                                join(key_table, and_(*join_conds), isouter=True)))

        ins = table.insert().from_select(cnames, query)
        print(self.terminated_statement(sql_to_string(ins)))
        self.comparison_tables[measure] = table
        

if __name__ == '__main__':
    measures = sys.argv[1:]
    dburl=DEFAULT_DBURL
    source_schema=DEFAULT_SOURCE_SCHEMA
    key_schema=DEFAULT_KEY_SCHEMA
    tk = TestKey(dburl, key_schema)

    for m in measures:
        tk.make_key_table(m, source_schema)

        
