:r "C:\Ephir\hqmf2sql\omop_etl\defaults.sql"
-- search_path = :valueset_schema;


--\copy value_sets(value_set_oid,value_set_name,value_set_version) from 'raw/value_sets.csv' with csv header
--analyze value_sets;
EXEC ('BULK INSERT '+@valueset_schema+'.value_sets FROM ''C:\Ephir\hqmf2sql\omop_etl\raw\value_sets.csv'' WITH (FIRSTROW = 2, FIELDTERMINATOR = '','');');

--\copy value_set_entries(value_set_oid,code,code_system,code_system_name,code_system_version,display_name,black_list,white_list) from 'raw/value_set_entries.csv' with csv header
--cluster value_set_entries;
--analyze value_set_entries;
EXEC ('create view '+@valueset_schema+'.v_value_set_entries as select value_set_oid,code,code_system,code_system_name,code_system_version,display_name,black_list,white_list from '+@valueset_schema+'.value_set_entries;');
EXEC ('BULK INSERT '+@valueset_schema+'.v_value_set_entries FROM ''C:\Ephir\hqmf2sql\omop_etl\raw\value_set_entries.csv'' WITH (FIRSTROW = 2, FIELDTERMINATOR = '','');');
EXEC('drop view '+@valueset_schema+'.v_value_set_entries;');



--\copy vocabulary_map(hqmf_code_system_oid,hqmf_code_system_name,hqmf_code_system_version,omop_vocabulary_id) from 'raw/vocabulary_map.csv' with csv header
--analyze vocabulary_map;
EXEC ('BULK INSERT '+@valueset_schema+'.vocabulary_map FROM ''C:\Ephir\hqmf2sql\omop_etl\raw\vocabulary_map.csv'' WITH (FIRSTROW = 2, FIELDTERMINATOR = '','');');


--\copy lab_test_observation_types(concept_id,concept_name,concept_level,concept_class,vocabulary_id,concept_code,valid_start_date,valid_end_date,invalid_reason) from 'raw/lab_test_observation_types.csv' with csv header
EXEC ('BULK INSERT '+@valueset_schema+'.lab_test_observation_types FROM ''C:\Ephir\hqmf2sql\omop_etl\raw\lab_test_observation_types.csv'' WITH (FIRSTROW = 2, FIELDTERMINATOR = '','');');
