from html.parser import HTMLParser
import sys
import re
import csv

class CypressResultDetailParser(HTMLParser):
    def __init__(self):
        HTMLParser.__init__(self)
        self.in_detail_section = False
        self.current_url = None
        self.data = []
        self.in_td = False

    def handle_starttag(self, tag, attrs):
        if tag == 'table':
            for a in attrs:
                if a[0] == 'id' and a[1] == 'patient_subset':
                    self.in_detail_section = True
        if self.in_detail_section:
            if tag == "tr":
                self.current_row = []
            if tag == "td":
                self.in_td = True
                for a in attrs:
                    if a[0] == 'class':
                        if a[1] == 'marker p':
                            self.current_row.append(True)
                        elif a[1] == 'marker ':
                            self.current_row.append(False)
                        else:
                            self.current_row.append("Unknown class: " + a[1])
            elif tag == "a" and self.in_td:
                for a in attrs:
                    if a[0] == 'href':
                        self.current_url = a[1]
#            print("Encountered a start tag:", tag)            
    def handle_endtag(self, tag):
        if self.in_detail_section and tag == 'table':
            self.in_detail_section = False
        if self.in_detail_section:
            if tag == "tr":
#                print("adding row " + str(self.current_row))
                if len(self.current_row) > 0:                
                    self.current_row.append(self.current_url)
                    self.data.append(self.current_row) 
                self.current_row = None
            if tag == "td":
                self.in_td = False
    def handle_data(self, data):
        if self.in_detail_section and self.in_td:
            self.current_row.append(data.strip())
#            print("Encountered some data  :", data)


s=sys.stdin.read()
parser=CypressResultDetailParser()
parser.feed(s)

csvfile = open('answer_details.csv', 'w', newline='')
awriter = csv.writer(csvfile, quoting=csv.QUOTE_MINIMAL)
prev = None
num = 0
for row in parser.data:
    if row[0] == prev:
        num = num + 1
    else:
        num = 0
    prev = row[0]
#    row.append(re.sub('[a-z]*([0-9]*).*', 'measure_\\1_' + str(num) + '_patient_summary', row[0]))
    awriter.writerow(row)
