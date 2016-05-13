from CypressFetch import CypressFetch
import sys
import csv

usage="Usage: {me} user password".format(me=argv[0])

def main(argv):
    infile=open('url_list.csv')
    c = csv.reader(infile)
    f=CypressFetch(argv[1], argv[2])
    for row in c:
        r = f.fetch('http://cypress-demo.isi.edu' + row[0] + "/patients")
        out=open("detail_html/" + row[1].replace('_patient_summary', '.html'), "w")
        out.write(r.text)
        out.close()

if __name__ == '__main__':
    main(sys.argv)
    sys.exit(0)
    
