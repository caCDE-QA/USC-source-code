#!/usr/bin/python

DEFAULT_DBURL="postgresql+psycopg2:///cqm"
DEFAULT_SOURCE_SCHEMA="results"
DEFAULT_KEY_SCHEMA="expected"

import sys
from TestKey import TestKey

if __name__ == '__main__':
    measures = sys.argv[1:]
    dburl=DEFAULT_DBURL
    source_schema=DEFAULT_SOURCE_SCHEMA
    key_schema=DEFAULT_KEY_SCHEMA
    tk = TestKey(dburl, key_schema)
    tk.create_test_detail_table(source_schema)

    for m in measures:
        tk.make_comparison_table(m, source_schema)
        tk.add_test_detail(m)


        
