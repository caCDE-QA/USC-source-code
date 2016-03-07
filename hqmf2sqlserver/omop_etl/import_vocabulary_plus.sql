:r "c:\Ephir\hqmf2sql\omop_etl\defaults.sql"
--set search_path = :vocab_schema;

--\copy relationship_extras(relationship_id,relationship_name,is_hierarchical,defines_ancestry,reverse_relationship) from 'raw/relationship_extras.csv' with csv header
--\copy vocabulary_extras(vocabulary_id,vocabulary_name) from 'raw/vocabulary_extras.csv' with csv header
-- The name of the schema that has your vanilla OMOP vocabulary tables (vocabulary, concept, etc.):
EXEC('SET IDENTITY_INSERT '+@vocab_schema+'.relationship_extras  ON;
BULK INSERT '+@vocab_schema+'.relationship_extras 
FROM ''C:\Ephir\hqmf2sql\omop_etl\raw\relationship_extras.csv'' 
WITH (KEEPIDENTITY, FIRSTROW = 2, FIELDTERMINATOR = '','');
SET IDENTITY_INSERT '+@vocab_schema+'.relationship_extras OFF;');
--
EXEC('SET IDENTITY_INSERT '+@vocab_schema+'.vocabulary_extras  ON;
BULK INSERT '+@vocab_schema+'.vocabulary_extras FROM ''C:\Ephir\hqmf2sql\omop_etl\raw/vocabulary_extras.csv'' 
WITH (KEEPIDENTITY, FIRSTROW = 2, FIELDTERMINATOR = '','');
SET IDENTITY_INSERT '+@vocab_schema+'.vocabulary_extras  OFF;');