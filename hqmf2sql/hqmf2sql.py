import json
import sys
import argparse
from antlr4 import *
from HQMFSymbolTable import *
from HQMFSqlGenerator import SQLGenerator, DBConnection, HQMFCustomEncoder, ExtendedSymbolTable, ExtendedDataCriterion
from HQMFLexer import HQMFLexer
from HQMFParser import HQMFParser
from HQMFData import *
from sqlalchemy.sql.functions import *

from HQMFSqlGenerator import TemporalFunctions

usage="Usage:" + sys.argv[0] + "[-j] [-n] [-s start_time] [-e end_time] dbname infile"

DB_BASE_URL="postgresql+psycopg2:///"
DEFAULT_HQMF_SCHEMA="hqmf_test"
DEFAULT_RESULT_SCHEMA="results"
DEFAULT_COHORT_SCHEMA="public"

def main(argv):
    print_json = False
    print_sql = True

    hqmf_schema=DEFAULT_HQMF_SCHEMA;
    result_schema=DEFAULT_RESULT_SCHEMA;
    cohort_schema=DEFAULT_COHORT_SCHEMA

    parser = argparse.ArgumentParser()
    parser.add_argument('-j', help="print json", action='store_true')
    parser.add_argument('-n', help="don't print sql", action='store_true')
    parser.add_argument('-H', "--hqmf_schema", help="hqmf_schema")
    parser.add_argument('-r', "--result_schema", help="result_schema")
    parser.add_argument('-c', "--cohort_schema", help="cohort_schema")
    parser.add_argument('-s', "--start_time", help="measure period start time")
    parser.add_argument('-e', "--end_time",  help="measure period end end time")
    parser.add_argument('dbname')
    parser.add_argument('infile')
    ns=parser.parse_args()

    dbname=ns.dbname
    infile=ns.infile
    if ns.j:
        print_json = True
    if ns.n:
        print_sql = False
    input = FileStream(infile, encoding='utf8')
    lexer = HQMFLexer(input)
    stream = CommonTokenStream(lexer)
    parser = HQMFParser(stream)
    tree = parser.hqmf()
    symbol_table = SymbolTable()
    builder = SymbolTableBuilder(symbol_table)
    walker = ParseTreeWalker()
    walker.walk(builder, tree)
    mp = symbol_table.get_measure_period()
    if (ns.start_time != None) != (ns.end_time != None):
        print("You must specify both -s and -e or neither")
        sys.exit(1)

    if ns.start_time != None and ns.end_time != None:
        mp.override_values(ns.start_time, ns.end_time)

    if ns.hqmf_schema != None:
        hqmf_schema = ns.hqmf_schema

    if ns.result_schema != None:
        result_schema = ns.result_schema

    if ns.cohort_schema != None:
        cohort_schema = ns.cohort_schema

    builder = SQLGenerator(DB_BASE_URL+dbname, hqmf_schema, result_schema, symbol_table, print_json=print_json, print_sql=print_sql, cohort_schema=cohort_schema)
    walker = ParseTreeWalker()
    walker.walk(builder, tree)

if __name__ == '__main__':
    main(sys.argv)
    sys.exit(1)
