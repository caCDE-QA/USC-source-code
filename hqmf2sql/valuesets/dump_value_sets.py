#!/usr/bin/python

import json
import sys
import csv
from value_set_string_util import value_set_string_util

class dump_value_sets:
    vsutil = value_set_string_util(['display_name', 'code_system_name'])
    vs_attrs = ['oid', 'display_name', 'version']
    code_attrs = ['code', 'code_system', 'code_system_name', 'code_system_version', 'display_name', 'black_list', 'white_list']
    code_headers = ['value_set_oid'] + code_attrs

    def __init__(self, outdir):
        self.outdir=outdir
        self.vs_file=self.open_csvfile('value_sets.csv', self.vs_attrs)
        self.vs_entries_file=self.open_csvfile('value_set_entries.csv', self.code_headers)

    def open_csvfile(self, filename, header_attrs):
        return self.vsutil.open_csvfile(self.outdir + '/' + filename, header_attrs)

    def dump_file(self, filename):
        f = open(filename)
        model = json.load(f)
        if not model.has_key('oid'):
            print >> sys.stderr , "no oid in " + f
            return

        if not model.has_key('concepts'):
            print >> sys.stderr , "no concepts in " + f
            return

        self.vs_file.writerow(self.dict_to_row(model, self.vs_attrs))

        concepts = model['concepts']
        for code in concepts:
            self.vs_entries_file.writerow([model.get('oid')] + self.dict_to_row(code, self.code_attrs))

        f.close()

    def dict_to_row(self, from_dict, attr_list):
        row = []
        for k in attr_list:
            row.append(self.vsutil.normalize_string(k, from_dict[k]))
        return row

    def dump_concept(self, vs, csvfile, concept):
        row = []
        for a in self.measure_attrs:
            row.append(vs[a])
        for a in self.code_attrs:
            if concept.has_key(a):
                row.append(self.vsutil.normalize_string(a, concept[a]))
            else:
                row_append(None)
        csvfile.writerow(row)

if __name__ == '__main__':
    outdir = sys.argv.pop(1)
    dvs = dump_value_sets(outdir)
    for filename in sys.argv[1:]:
#        try:
            dvs.dump_file(filename)
#        except:
#            print >> sys.stderr, "Error processing", filename, sys.exc_info()[0]


