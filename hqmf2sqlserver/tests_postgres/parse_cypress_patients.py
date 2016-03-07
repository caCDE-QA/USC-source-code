#!/usr/bin/python

from CypressParser import *
import xml.dom
import sys
import json

if __name__ == '__main__':
    parser = CypressParser()
    if len(sys.argv) < 2:
        print("Usage: " + sys.argv[0] + " patient_file ...")
        sys.exit(1)
    results = []
    for a in sys.argv[1:]:
        patient = parser.parsePatientFile(a)
        results.append(patient)
    print(json.dumps(results))
