\ir defaults.sql
create schema :vocab_schema;
set search_path = :vocab_schema;
create table vocabulary_extras (like :omop_vocab_schema.vocabulary including all);
create view vocabulary as select * from vocabulary_extras union select * from :omop_vocab_schema.vocabulary;
create table concept_extras (like :omop_vocab_schema.concept including all);
create view concept as select * from concept_extras union select * from :omop_vocab_schema.concept;
create table concept_ancestor_extras (like :omop_vocab_schema.concept_ancestor including all);
create view concept_ancestor as select * from concept_ancestor_extras union select * from :omop_vocab_schema.concept_ancestor;
create table drug_approval_extras (like :omop_vocab_schema.drug_approval including all);
create view drug_approval as select * from drug_approval_extras union select * from :omop_vocab_schema.drug_approval;
create table drug_strength_extras (like :omop_vocab_schema.drug_strength including all);
create view drug_strength as select * from drug_strength_extras union select * from :omop_vocab_schema.drug_strength;
create table relationship_extras (like :omop_vocab_schema.relationship including all);
create view relationship as select * from relationship_extras union select * from :omop_vocab_schema.relationship;
create table concept_relationship_extras (like :omop_vocab_schema.concept_relationship including all);
create view concept_relationship as select * from concept_relationship_extras union select * from :omop_vocab_schema.concept_relationship;
create table source_to_concept_map_extras (like :omop_vocab_schema.source_to_concept_map including all);
create view source_to_concept_map as select * from source_to_concept_map_extras union select * from :omop_vocab_schema.source_to_concept_map;

create sequence vocabulary_extras_sequence minvalue 40000;
alter table vocabulary_extras alter column vocabulary_id set default nextval ('vocabulary_extras_sequence');

create sequence concept_extras_sequence minvalue 1000000001;
alter table concept_extras alter column concept_id set default nextval ('concept_extras_sequence');

create sequence relationship_extras_sequence minvalue 1000;
alter table relationship_extras alter column relationship_id set default nextval ('relationship_extras_sequence');