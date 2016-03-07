\ir defaults.sql

\set icd9_vocabulary_id_5 'ICD9CM'
\set icd9_vocabulary_id_4 2

set search_path = :vocab_schema;

create table concepts_from_v5 (like :omop_vocab_schema.concept including all);

create or replace view concept as
select * from concept_extras
union select * from concepts_from_v5
union select * from :omop_vocab_schema.concept;

insert into concepts_from_v5(
  concept_id,
  concept_name,
  concept_level,
  concept_class,
  vocabulary_id,
  concept_code,
  valid_start_date,
  valid_end_date
) select
  concept_id,
  concept_name,
  2,
  concept_class_id,
  :icd9_vocabulary_id_4,
  concept_code,
  valid_start_date,
  valid_end_date
from :vocabulary_5.concept where vocabulary_id = :icd9_vocabulary_id_5;
  