#!/usr/bin/python

DB_BASE_URL="postgresql+psycopg2:///"
DEFAULT_DB_NAME="cqm"

from QRDACat3 import *
from HQMFResults import *
import xml.dom
import sys
import json

if __name__ == '__main__':
    qrda = QRDACat3(skip_zero_valued_supplemental_results=True)
    if len(sys.argv) < 2:
        print("Usage: " + sys.argv[0] + "{eh|ep} measure ...")
        sys.exit(1)
    mtype = sys.argv.pop(1)
    measures = []
#    hr=HQMFResults(DB_BASE_URL + DEFAULT_DB_NAME, 'hqmf_cypress_' + mtype, 'results_cypress_' + mtype)
    hr=HQMFResults(DB_BASE_URL + DEFAULT_DB_NAME, 'hqmf_test', 'results')
    for measure in sys.argv[1:]:
        measure = measure.lower()
        if hr.exists(measure):
            measures.append(measure)

    hr.process_measure(measures[0])
    qrda.updateReportingParameters(hr.parameters)


    for measure in measures:

        try:
            hr.process_measure(measure.lower())
        except ValueError:
            sys.stderr.write("Skipping " + measure + "\n")

        qrda.addMeasure(hr, measure)
#         try:
#             qrda.addMeasure(hr, measure)
#         except AttributeError as err:
#             sys.stderr.write("Error processing measure " + measure + ": " + str(err) + "\n")
#         except ValueError as err:
#             sys.stderr.write("Error processing measure " + measure + ": " + str(err) + "\n")

#    print(json.dumps(hr.measures, indent=4))
    print(qrda.doc.toprettyxml())
#    print(qrda.doc.toxml())

