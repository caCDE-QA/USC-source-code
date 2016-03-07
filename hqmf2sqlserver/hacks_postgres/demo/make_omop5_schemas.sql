\set omop_schema omop_test
\set base_vocab_schema vocabulary

create schema :omop_schema;
create schema :base_vocab_schema;

alter table attribute_definition set schema :omop_schema;
alter table care_site set schema :omop_schema;
alter table cdm_source set schema :omop_schema;
alter table cohort set schema :omop_schema;
alter table cohort_attribute set schema :omop_schema;
alter table cohort_definition set schema :omop_schema;
alter table concept set schema :base_vocab_schema;
alter table concept_ancestor set schema :base_vocab_schema;
alter table concept_class set schema :base_vocab_schema;
alter table concept_relationship set schema :base_vocab_schema;
alter table concept_synonym set schema :base_vocab_schema;
alter table condition_era set schema :omop_schema;
alter table condition_occurrence set schema :omop_schema;
alter table death set schema :omop_schema;
alter table device_cost set schema :omop_schema;
alter table device_exposure set schema :omop_schema;
alter table domain set schema :base_vocab_schema;
alter table dose_era set schema :omop_schema;
alter table drug_cost set schema :omop_schema;
alter table drug_era set schema :omop_schema;
alter table drug_exposure set schema :omop_schema;
alter table drug_strength set schema :omop_schema;
alter table fact_relationship set schema :omop_schema;
alter table location set schema :omop_schema;
alter table measurement set schema :omop_schema;
alter table note set schema :omop_schema;
alter table observation set schema :omop_schema;
alter table observation_period set schema :omop_schema;
alter table payer_plan_period set schema :omop_schema;
alter table person set schema :omop_schema;
alter table procedure_cost set schema :omop_schema;
alter table procedure_occurrence set schema :omop_schema;
alter table provider set schema :omop_schema;
alter table relationship set schema :omop_schema;
alter table source_to_concept_map set schema :base_vocab_schema;
alter table specimen set schema :omop_schema;
alter table visit_cost set schema :omop_schema;
alter table visit_occurrence set schema :omop_schema;
alter table vocabulary set schema :base_vocab_schema;
