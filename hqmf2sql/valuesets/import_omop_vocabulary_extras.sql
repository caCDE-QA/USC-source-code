\ir defaults.sql
\ir ../targets/omop/defaults.sql
set search_path = :vocab_schema;

\copy vocabulary_extras(vocabulary_id,vocabulary_name) from 'raw/vocabulary_extras.csv' with csv header
--\copy concept_extras(concept_id,concept_name,concept_level,concept_class,vocabulary_id,concept_code,valid_start_date,valid_end_date,invalid_reason) from 'raw/concept_extras.csv' with csv header
\copy relationship_extras(relationship_id, relationship_name, is_hierarchical, defines_ancestry, reverse_relationship) from 'raw/relationship_extras.csv' with csv header
