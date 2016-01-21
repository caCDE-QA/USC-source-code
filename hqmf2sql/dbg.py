import json
#from HQMFParserListener import HQMFParserListener
#from HQMFParser import *
from HQMFUtil import *
from sqlalchemy import *
from sqlalchemy.sql.expression import *
from HQMFData import DataCriterion
import sys
import sqlparse
from HQMFIntervalUtil import HQMFIntervalType, HQMFIntervalUtil
HQMF="hqmf"
VALUESET="valueset"
PATIENTS="patients"
VALUESET_SCHEMA = 'eqmxlate_value_sets'
dburl="postgresql+psycopg2:///cqm"
hqmf_schema="hqmf_cypress_ep"
valueset_schema=VALUESET_SCHEMA
schemas={HQMF : hqmf_schema, VALUESET : valueset_schema}
engine = create_engine(dburl)
conn = engine.connect()
meta = MetaData()
meta.reflect(bind=engine, schema=valueset_schema, views=True)
meta.reflect(bind=engine, schema=hqmf_schema, views=True)
pat_tbl = meta.tables[hqmf_schema + '.' + PATIENTS]


def sql_to_string(sql):
    return str(sql.compile(compile_kwargs={"literal_binds": True}, dialect=HQMFIntervalUtil.get_dialect()))
