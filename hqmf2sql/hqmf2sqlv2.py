import json
import sys
import argparse
from antlr4 import *
from HQMFv2SymbolTable import *
from HQMFv2JSONLexer import HQMFv2JSONLexer
from HQMFv2JSONParser import HQMFv2JSONParser
from HQMFv2Data import *
from HQMFv2SqlGenerator import SQLGenerator, DBConnection
from sqlalchemy.sql.functions import *
from datetime import datetime
#from pathlib import Path

usage="Usage:" + sys.argv[0] + "[-j] [-n] [-s start_time] [-e end_time] [-d] [-u] [-x] dbname infile"

DB_BASE_URL="postgresql+psycopg2:///"
DEFAULT_HQMF_SCHEMA="hqmf_test"
DEFAULT_RESULT_SCHEMA="results"
DEFAULT_COHORT_SCHEMA="public"

def main(argv):
    print_json = False
    print_sql = True

    cohort_schema=DEFAULT_COHORT_SCHEMA
    debug=False
    ugly=False

    parser = argparse.ArgumentParser()
    parser.add_argument('-j', help="print json", action='store_true')
    parser.add_argument('-n', help="don't print sql", action='store_true')
    parser.add_argument('-d', help="debug", action='store_true')
    parser.add_argument('-u', help="ugly", action='store_true')
    parser.add_argument('-x', help="skip exceptions", action='store_true')    
    parser.add_argument('-H', "--hqmf_schema", help="hqmf_schema", action="store", default=DEFAULT_HQMF_SCHEMA)
    parser.add_argument('-r', "--result_schema", help="result_schema", action="store", default=DEFAULT_RESULT_SCHEMA)
    parser.add_argument('-c', "--cohort_schema", help="cohort_schema", action="store", default=DEFAULT_COHORT_SCHEMA)
    parser.add_argument('-s', "--start_time", help="measure period start time", action="store", default=None)
    parser.add_argument('-e', "--end_time",  help="measure period end end time", action="store", default=None)
    parser.add_argument('dbname')
    parser.add_argument('infile')
    ns=parser.parse_args()

    dbname=ns.dbname
    infile=ns.infile
#    name_from_file=Path(infile).stem.lower()
    hqmf_schema=ns.hqmf_schema
    result_schema=ns.result_schema
    cohort_schema=ns.cohort_schema
    start_time=ns.start_time
    end_time=ns.end_time
    skip_exceptions = False
    if ns.j:
        print_json = True
    if ns.n:
        print_sql = False
    if ns.d:
        debug=True
    if ns.u:
        ugly=True
    if ns.x:
        skip_exceptions=True
    input = FileStream(infile, encoding='utf8')
    lexer = HQMFv2JSONLexer(input)
    stream = CommonTokenStream(lexer)
    parser = HQMFv2JSONParser(stream)
    tree = parser.hqmf()
    builder = SymbolTableBuilder()
    walker = ParseTreeWalker()
    walker.walk(builder, tree)
    measure = builder.get_measure()
#    measure.set_measure_name(name_from_file)
    if start_time != None or end_time != None:
        measure.get_symbol_table().get_measure_period().override_values(datetime.strptime(start_time, '%Y-%m-%d'), datetime.strptime(end_time, '%Y-%m-%d'))
    if debug:
        print(json.dumps(measure, indent=4, cls=MyEncoder))
        #print(str(measure))
        # for p in measure.populations:
        #     print(str(measure))
        #     print("=== POPULATION ===")
        #     print(str(p))
        #     print("population: ")
        #     print("   value_dict: " + str(p.value_dict))
        #     print("   population_criteria: " + str(p.population_criteria))
        sys.exit(0)

    generator = SQLGenerator(DB_BASE_URL+dbname, hqmf_schema, result_schema, measure, inline_preference=False)
    if debug:
        generator.print_debug()
    print("set search_path = " + result_schema + ";")
    generator.generate_sql(not ugly, skip_exceptions=skip_exceptions)

if __name__ == '__main__':
    main(sys.argv)
    sys.exit(0)
