EphirQueries is a DQ test data and queries setup. It require a few things be done first:

 1. The queries reference a couple tables in a schema called "valuesets" - DDL and CSV files to create and populate those tables.

 2. The queries make use of four functions: year_delta, month_delta, week_delta, and day_delta, which will have to be defined 
  before you can run them. The file is create_date_funcs.sql. HQMF has very specific guidance on how time intervals are calculated.

 3. The queries themselves are in the mssql subdirectory. They may need some changing by hand to deal with schemas (namespaces).
 They expect tables to be in schemas with the following names:
•QDM data in a schema called hqmf_cypress_ep
•Value set data (those two tables from step 1) in a schema called valuesets
They also expect an empty schema called "results" to exist; that's where the result tables will be created.



 The one thing you may need to change by hand is how the schemas are referenced; that's all currently Postgres-style (e.g., "select person_id from omop_schema.person)", so you may  need to do global replaces on "hqmf_cypress_ep.", "valuesets.", and "results.".

 The resulting test data will be stored in results.measure_*_patient_summary tables (and only those tables). 
 Every summary table should have this structure.


       Column       |  Type   | Modifiers 
--------------------+---------+-----------
 patient_id         | integer | 
 effective_ipp      | bit | 
 effective_denom    | bit | 
 effective_denex    | bit | 
 effective_numer    | bit | 
 effective_denexcep | bit | 

