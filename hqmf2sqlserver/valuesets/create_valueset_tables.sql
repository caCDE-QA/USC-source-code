:r "C:\Ephir\hqmf2sql\valuesets\defaults.sql"

--create schema :valueset_schema;
--set search_path = :valueset_schema;
EXEC ('CREATE SCHEMA '+@valueset_schema+';');

EXEC('create table '+@valueset_schema+'.value_sets (
    value_set_oid varchar(5000) primary key,
    value_set_name varchar(5000) not null,
    value_set_version varchar(5000) not null
);');

--comment on table value_sets is 'Value set names (from standard value set definitions)';

EXEC('create table '+@valueset_schema+'.value_set_entries (
    value_set_entry_id int identity(1,1) primary key NONCLUSTERED,
    value_set_oid varchar(5000) not null references '+@valueset_schema+'.value_sets(value_set_oid),
    code varchar(5000) not null,
    code_system varchar(5000) not null,
    code_system_name varchar(5000) not null,
    code_system_version varchar(5000),
    display_name varchar(5000),
    black_list varchar(5000),
    white_list varchar(5000),
    unique(value_set_oid, code_system, code)
);');

EXEC('create clustered index value_set_entries_code_system_value_set_code on '+@valueset_schema+'.value_set_entries(code_system, value_set_oid, code);');
EXEC('create index value_set_entries_value_set_oid on '+@valueset_schema+'.value_set_entries(value_set_oid);');
EXEC('create index value_set_entries_code on '+@valueset_schema+'.value_set_entries(code);');
EXEC('create index value_set_entries_code_system_name_version_code on '+@valueset_schema+'.value_set_entries(code_system_name, code_system_version, code);');
EXEC('create index value_set_entries_code_system_version_code on '+@valueset_schema+'.value_set_entries(code_system, code_system_version, code);');

--cluster value_set_entries using value_set_entries_code_system_value_set_code;

--comment on table value_set_entries is 'Value set entries (from standard value set definitions)';

EXEC('create table '+@valueset_schema+'.vocabulary_map (
  hqmf_code_system_oid varchar(5000) not null,
  hqmf_code_system_name varchar(5000) not null,
  hqmf_code_system_version varchar(5000),
  omop_vocabulary_id integer
);');

EXEC('create index vocabulary_map_hqmf_idx on '+@valueset_schema+'.vocabulary_map(hqmf_code_system_oid, hqmf_code_system_version);');

--comment on table vocabulary_map is 'Mapping of NLM value set OIDs to OMOP vocabulary IDs';
execute sp_addextendedproperty 'MS_Description', 
   'Mapping of NLM value set OIDs to OMOP vocabulary IDs',
   'schema', @valueset_schema, 'table', 'vocabulary_map';
--comment on column vocabulary_map.hqmf_code_system_oid is 'Code system OID; corresponds to the code_system column of value_set_entries';
execute sp_addextendedproperty 'MS_Description', 
   'HQMF vocabulary OID.',
   'schema', @valueset_schema, 'table', 'vocabulary_map', 'column', 'hqmf_code_system_oid';
--comment on column vocabulary_map.hqmf_code_system_name is 'Code system name; used for display purposes only';
execute sp_addextendedproperty 'MS_Description', 
   'Code system name; used for display purposes only',
   'schema', @valueset_schema, 'table', 'vocabulary_map', 'column', 'hqmf_code_system_name';
--comment on column vocabulary_map.omop_vocabulary_id is 'OMOP vocabulary id';
execute sp_addextendedproperty 'MS_Description', 
   'OMOP vocabulary id',
   'schema', @valueset_schema, 'table', 'vocabulary_map', 'column', 'omop_vocabulary_id';

EXEC('create table '+@valueset_schema+'.lab_test_observation_types (
  concept_id integer not null primary key,
  concept_name varchar(5000) not null,
  concept_level integer not null,
  concept_class varchar(5000) not null,
  vocabulary_id integer not null,
  concept_code varchar(5000) not null,
  valid_start_date date,
  valid_end_date date,
  invalid_reason char(1)
  );');

EXEC ('create view '+@valueset_schema+'.individual_code_map as
select
   ''2.16.840.1.113883.6.1'' code_system_oid,
   ''LOINC''  code_system,
   concept_code data_code,
   concept_code measure_code,
   concept_id code
   from '+@vocab_schema+'.concept
   where vocabulary_id = '+@loinc_vocabulary_id+'
union
select
   ''2.16.840.1.113762.1.4.1'' code_system_oid,
   ''Administrative Sex'' code_system,
   concept_code data_code,
   concept_code measure_code,
   concept_id code
   from '+@vocab_schema+'.concept
   where vocabulary_id = '+@administrative_sex_vocabulary_id+'
union
select
   ''2.16.840.1.113883.6.96'' code_system_oid,
   ''SNOMED-CT'' code_system,
   concept_code data_code,
   concept_code measure_code,
   concept_id code
   from '+@vocab_schema+'.concept
   where vocabulary_id = '+@snomed_vocabulary_id+';'   
);