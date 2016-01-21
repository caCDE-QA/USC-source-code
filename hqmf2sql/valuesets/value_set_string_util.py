#!/usr/bin/python

import unicodedata
import csv

class value_set_string_util:
    def __init__(self, unicode_convert_attrs):
        self.unicode_convert_attrs = unicode_convert_attrs

    def open_csvfile(self, filename, header_attrs, append=False):
        if append:
            outfile = open(filename, 'a')
        else:
            outfile = open(filename, 'w')
        out=csv.writer(outfile)
        if append == False and header_attrs != None:
            out.writerow(header_attrs)
        return out

    def normalize_string(self, key, value):
        if value == None:
            return None
        if key in self.unicode_convert_attrs:
            return unicodedata.normalize('NFKD', value).encode('ascii', 'ignore')
        else:
            return value
        
