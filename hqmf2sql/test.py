from HQMFUtil import *
from sqlalchemy import *
#from sqlalchemy.sql.expression import *
from sqlalchemy.sql.functions import *
from sqlalchemy.types import Boolean, Integer, String, DateTime, Date
from sqlalchemy.schema import CreateTable
import sys
import sqlparse
from datetime import timedelta, datetime
from HQMFIntervalUtil import HQMFIntervalType, HQMFIntervalUtil, HQMFResultUtil

DB_BASE_URL="postgresql+psycopg2:///"
DEFAULT_HQMF_SCHEMA="hqmf_cypress_ep"
VALUESET_SCHEMA="valuesets"
DEFAULT_RESULT_SCHEMA="results"
DEFAULT_DB="cqm"
VALUESET="valueset"
HQMF="hqmf"

class DBTest:
    def __init__(self, dburl):
        self.hqmf_schema=DEFAULT_HQMF_SCHEMA
        self.valueset_schema=VALUESET_SCHEMA
        self.schemas = {HQMF : self.hqmf_schema, VALUESET : self.valueset_schema}
        self.engine=create_engine(dburl)
        self.conn = self.engine.connect()
        self.meta = MetaData()
        self.meta.reflect(bind=self.engine, schema=self.valueset_schema, views=True)
        self.meta.reflect(bind=self.engine, schema=self.hqmf_schema, views=True)

    def get_table(self, schema, table_name):
        table = self.meta.tables.get(self.schemas.get(schema) + '.' + table_name)
        if table is None:
            raise ValueError("Can't find table for " + str(schema) + "." + str(table_name))
        return self.meta.tables[self.schemas.get(schema) + '.' + table_name]

    def create_simple_query(self, table_name, base):
        table = self.get_table('hqmf', table_name).alias()
        pat = self.get_table('hqmf', 'patients').alias()
        rowcol = func.row_number().over(partition_by=table.columns.get('patient_id'), order_by=table.c.start_dt).label("rownum")
        codes = self.get_table('valueset', 'code_lists')
#        sel = select([base.corresponding_column(pat.c.patient_id), table.c.start_dt, table.c.end_dt, table.c.audit_key_value, table.c.code, rowcol], use_labels=True)
        sel = select([table.c.patient_id, table.c.start_dt, table.c.end_dt, table.c.audit_key_value, table.c.code, rowcol], use_labels=True)
        sel = sel.where(table.c.patient_id == base.corresponding_column(pat.c.patient_id))
        sel = sel.alias()
        join = sel.join(codes, and_(codes.c.code == sel.corresponding_column(table.c.code),
                                    codes.c.code_list_id == '2.16.840.1.113883.3.464.1003.103.12.1001'))
        join = join.alias()
        cols = [join.corresponding_column(table.c.patient_id), join.corresponding_column(table.c.start_dt), join.corresponding_column(table.c.end_dt)]
        sel = select(cols, use_labels=True).select_from(join)
        sel = sel.where(join.corresponding_column(table.c.get('start_dt')) >= cast(datetime.strptime('2014-01-01', '%Y-%m-%d'), MyTimeStamp))
#        sel = sel.where(sel.corresponding_column(table.c.get('start_dt')) >= cast(datetime.strptime('2014-01-01', '%Y-%m-%d'), MyTimeStamp))
# .alias works, .alias.select doesn't
#        sel = union(sel, sel).alias()
#        sel = union(sel, sel).order_by(sel.c.get('start_dt')).alias()
        sel = union(sel, sel).alias()
        sel = select(sel.c).alias().select().select_from(base)
        sel = sel.alias()
        return sel

    def create_base_query_alias(self):
        table = self.get_table('hqmf', 'patients').alias('base_patients')
        return table
#        return select([table.c.get('patient_id').label('base_patient_id')])


    def create_base_query_subquery(self):
        table = self.get_table('hqmf', 'patients')
        return subquery('base_patients', [table.c.get('patient_id').label('base_patient_id')])

    def create_base_query_cte(self):
        table = select([self.get_table('hqmf', 'patients').alias().c.get('patient_id')], use_labels=True).cte('base_patients')
        return table

def main(args):
    test=DBTest(DB_BASE_URL+DEFAULT_DB)
    base = test.create_base_query_cte()
    pat = test.get_table('hqmf', 'patients')
    sel = test.create_simple_query('diagnosis_active', base)
    print("set search_path = results;")
    i = 1;
    print("create view v_" + str(i) + " as " + sqlparse.format(sql_to_string(sel), reindent=True) + ";")
    i = i + 1

class MyTimeStamp(TypeDecorator):
    impl = TIMESTAMP

    def process_literal_param(self, value, dialect):
        return "'" + value.isoformat() + "'"


if __name__ == '__main__':
    main(sys.argv)
    sys.exit(0)
