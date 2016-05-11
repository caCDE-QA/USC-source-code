from html.parser import HTMLParser
import sys
import re
import csv

class CypressResultParser(HTMLParser):
    def __init__(self):
        HTMLParser.__init__(self)
        self.in_measure_section = False
        self.in_h4 = False
        self.data = []
        self.skip_column = True
        self.in_td = False
        self.current_data = ""
        self.detail_links = dict()
        self.in_link = False
        self.current_link = None
        
    def handle_starttag(self, tag, attrs):
        if tag == 'h4':
            self.in_h4 = True
        if self.in_measure_section:
            if tag == "tr":
                self.current_row = []
            if tag == "td":
                self.in_td = True
            if tag == 'a' and self.in_td:
                for a in attrs:
                    if a[0] == 'href':
                        self.current_link = a[1]
#            print("Encountered a start tag:", tag)            
    def handle_endtag(self, tag):
        if tag == 'h4':
            self.in_h4 = False
        if tag == "section" and self.in_measure_section:
#            print("found end of measure section")
            self.in_measure_section = False
        if self.in_measure_section:
            if tag == "tr":
#                print("adding row " + str(self.current_row))
                if len(self.current_row) > 0:
                    row = []
                    for col in self.current_row:
                        col = re.sub('^(CMS[^/]*).*', '\\1', col)
                        col = re.sub('.*/(.*)', '\\1', col)
                        if col == '':
                            col = None
                        else:
                            col = col.lower()
                        row.append(col)
                    row.append(self.current_row[0])
                    row.append(self.current_link)
                    self.data.append(row) 
                self.skip_column = True
            if tag == "td":
                if not self.skip_column:
#                    print("adding data" + self.current_data)
                    data = self.current_data
                    self.current_row.append(data)
                self.current_data = ""
                self.in_td = False
                self.skip_column = False
#            print("Encountered an end tag :", tag)
    def handle_data(self, data):
        if self.in_h4 and "MEASURES" in data:
            self.in_measure_section = True
        if self.in_measure_section:
            if self.in_td:
                self.current_data = self.current_data + data.strip()
#            print("Encountered some data  :", data)


s=sys.stdin.read()
parser=CypressResultParser()
parser.feed(s)

csvfile = open('answer_summary.csv', 'w', newline='')
awriter = csv.writer(csvfile, quoting=csv.QUOTE_MINIMAL)
prev = None
num = 0
for row in parser.data:
    if row[0] == prev:
        num = num + 1
    else:
        num = 0
    prev = row[0]
    row.append(re.sub('[a-z]*([0-9]*).*', 'measure_\\1_' + str(num) + '_patient_summary', row[0]))
    awriter.writerow(row)
