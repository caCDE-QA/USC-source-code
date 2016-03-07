\set omop_schema omop_test
\set base_vocab_schema vocabulary

set search_path = :base_vocab_schema;

alter table concept set schema :omop_schema;
alter table concept_ancestor set schema :omop_schema;
alter table concept_class set schema :omop_schema;
alter table concept_relationship set schema :omop_schema;
alter table concept_synonym set schema :omop_schema;
alter table domain set schema :omop_schema;
alter table vocabulary set schema :omop_schema;
