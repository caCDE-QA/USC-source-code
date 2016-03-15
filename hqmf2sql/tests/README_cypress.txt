1. Make the cypress test data directory:
cd .../qrdf_tests
mkdir cypress_test_data

2. Use the cypress console to generate and download a set of test patients. This will be a zip file. Unzip it into cypress_test_data or some other directory.

3. Import the test patient data

   ./cypress-import.sh [-P test_patient_directory] {eh|ep} dbname

If the -P flag is not specified, it will look for patient data in the directory cypress_test_data.

3. Convert the test patient data to hqmf

./convert-cypress-patients.sh {eh|ep} psql_args ...


To parse results of the Cypress web client (this is painful):
1. In firefox, save results as text.
2. Run ./parse_cypress_client_results.pl < [result text file] > cypress_test_client_results.csv
3. Run psql -f import_cypress_client_results.sql [db]
