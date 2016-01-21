set search_path = :omop_v5_schema;

update condition_occurrence co set condition_concept_id = c.concept_id
from concept c
where c.concept_code = co.condition_source_value
and c.vocabulary_id = 'ICD9CM';

set search_path = :vocab_schema;

insert into concept_extras(
  concept_id,
  concept_name,
  concept_level,
  concept_class,
  vocabulary_id,
  concept_code,
  valid_start_date,
  valid_end_date,
  invalid_reason
) select 
  concept_id,
  concept_name,
  2,
  concept_class_id,
  2,
  concept_code,
  valid_start_date,
  valid_end_date,
  invalid_reason
from :vocabulary_5.concept where vocabulary_id = 'ICD9CM';