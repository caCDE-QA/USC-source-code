\ir defaults.sql

create index concept_concept_code_idx on :base_vocab_schema.concept(concept_code);
create index concept_concept_code_vocab_id_idx on :base_vocab_schema.concept(concept_code, vocabulary_id);
create index concept_relationship_hqmf_relationship_id on :base_vocab_schema.concept_relationship(relationship_id) where relationship_id in (:value_set_member_relationship_id, :value_set_member_relationship_id_mapped);
create index source_to_concept_map_source_code_idx on :base_vocab_schema.source_to_concept_map(source_code);
analyze :base_vocab_schema.concept;
analyze :base_vocab_schema.concept_relationship;
