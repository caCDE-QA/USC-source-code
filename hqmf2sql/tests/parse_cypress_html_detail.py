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
        self.in_th = False
        self.headers = []
        self.current_col = 0

    def handle_starttag(self, tag, attrs):
        if tag == 'table':
            for a in attrs:
                if a[0] == 'id' and a[1] == 'patient_subset':
                    self.in_detail_section = True
        if self.in_detail_section:
            if tag == "tr":
                self.current_row = dict()
                self.current_col = 0
            if tag == "th":
                self.in_th = True
            if tag == "td":
                self.in_td = True
                for a in attrs:
                    if a[0] == 'class':
                        if a[1] == 'marker p':
                            self.current_row[self.headers[self.current_col]] = True
                        elif a[1] == 'marker ':
                            self.current_row[self.headers[self.current_col]] = False
                        else:
                            self.current_row[self.headers[self.current_col]] = "Unknown class: " + a[1]
                        self.current_col = self.current_col + 1                            
            elif tag == "a" and self.in_td:
                for a in attrs:
                    if a[0] == 'href':
                        self.current_url = a[1]
    def handle_endtag(self, tag):
        if self.in_detail_section and tag == 'table':
            self.in_detail_section = False
        if self.in_detail_section:
            if tag == "tr":
                if len(self.current_row) > 0:                
                    self.current_row['url'] = self.current_url
                    self.data.append(self.current_row) 
                self.current_row = None
            if tag == "td":
                self.in_td = False
            if tag == "th":
                self.in_th = False
    def handle_data(self, data):
        if self.in_detail_section:
            if self.in_td:
                if self.current_row.get(self.headers[self.current_col]) == None:
                    self.current_row[self.headers[self.current_col]] = data.strip()
                else:
                    self.current_row[self.headers[self.current_col]].append(data.strip())
                self.current_col = self.current_col + 1                    
            if self.in_th:
                self.headers.append(data.strip())


def main(argv):
    infile=argv[1]
    outfile=argv[2]
    s=open(infile).read()
    parser=CypressResultDetailParser()
    parser.feed(s)

    csvfile = open(outfile, 'w', newline='')
    headers=['POP', 'DEN', 'EXCL', 'NUM', 'EXCP', 'OUT', 'Last Name', 'First Name', 'DOB', 'Gender', 'url']
    dwriter = csv.DictWriter(csvfile, headers, quoting=csv.QUOTE_MINIMAL)
    prev = None
    num = 0
    for row in parser.data:
        dwriter.writerow(row)

if __name__ == '__main__':
    main(sys.argv)
    sys.exit(0)
        
