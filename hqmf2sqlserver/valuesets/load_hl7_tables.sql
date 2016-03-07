:r "C:\Ephir\hqmf2sql\valuesets\defaults.sql"

--set search_path = :valueset_schema;


EXEC('create table '+@valueset_schema+'.hl7_template_xref (
  template_id text,
  template_name text
);');

--\copy hl7_template_xref (template_id, template_name) from 'raw/hl7_template_xref.csv' with csv header
EXEC ('BULK INSERT '+@valueset_schema+'.hl7_template_xref FROM ''C:\Ephir\hqmf2sql\valuesets\raw\hl7_template_xref.csv'' WITH (FIRSTROW = 2, FIELDTERMINATOR = '','');');