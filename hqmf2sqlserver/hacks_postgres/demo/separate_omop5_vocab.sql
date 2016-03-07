\set omop_schema omop_test
\set base_vocab_schema vocabulary

set search_path = :omop_schema;

alter table concept set schema :base_vocab_schema;
alter table concept_ancestor set schema :base_vocab_schema;
alter table concept_class set schema :base_vocab_schema;
alter table concept_relationship set schema :base_vocab_schema;
alter table concept_synonym set schema :base_vocab_schema;
alter table domain set schema :base_vocab_schema;
alter table vocabulary set schema :base_vocab_schema;
