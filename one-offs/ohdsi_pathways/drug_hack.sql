set search_path = omop_altamed_2015_11_01;

create view drug_exposure as select
drug_exposure_id,
person_id,
drug_concept_id,
drug_exposure_start_date,
drug_exposure_end_date,
drug_type_concept_id,
stop_reason,
refills,
quantity,
days_supply::integer,
sig,
prescribing_provider_id,
visit_occurrence_id,
relevant_condition_concept_id,
drug_source_value,
provenance_id,
drug_source_description,
drug_exposure_start_timestamp
from drug_exposure_real;
