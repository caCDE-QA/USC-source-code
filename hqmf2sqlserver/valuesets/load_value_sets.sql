-- ************************
-- PostgreSQL database dump
-- not used in hqmf setup
-- NOT PORTED TO SQL SERVER
--

\ir defaults.sql
set search_path = :valueset_schema;


\copy value_sets(value_set_oid,value_set_name,value_set_version) from 'vs_cache/value_sets.csv' with csv header
cluster value_sets;
analyze value_sets;

\copy value_set_entries(value_set_oid,code,code_system,code_system_name,code_system_version,display_name,black_list,white_list) from 'vs_cache/value_set_entries.csv' with csv header
cluster value_set_entries;
analyze value_set_entries;

\copy vocabulary_map(hqmf_code_system_oid,hqmf_code_system_name,hqmf_code_system_version,omop_vocabulary_id) from 'raw/vocabulary_map.csv' with csv header
cluster vocabulary_map;
analyze vocabulary_map;

