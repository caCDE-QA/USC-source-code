-- kludge until data model is revamped
\set hqmf_schema hqmf_cypress_ep

set search_path = :hqmf_schema;
create view encounter_performed as select * from encounter ;
create view patient_characteristic_payer as select * from individual_characteristic;
create view patient_characteristic_gender as select * from individual_characteristic;
create view patient_characteristic_ethnicity as select * from individual_characteristic;
create view patient_characteristic_race as select * from individual_characteristic;
create view patient_characteristic_birthdate as select * from individual_characteristic;
create view physical_exam_performed as select * from physical_exam;
-- I have no idea whether this is correct.
create view procedure_ordered as select * from procedure_performed where status = 'ordered';
create view intervention_ordered as select * from procedure_ordered;
create view intervention_performed as select * from procedure_performed;
create view medication_ordered as select * from medication_order;
create view laboratory_test_performed as select * from laboratory_test;
create view medication_intolerance as select * from allergy;
create view medication_allergy as select * from allergy;
create view laboratory_test_ordered as select * from laboratory_test;
create view patient_characteristic as select * from individual_characteristic;
create view functional_status_result as select * from procedure_result;
create view diagnostic_study_ordered as select * from laboratory_test_ordered;

create view patient_characteristic_sex as select * from individual_characteristic;
create view diagnostic_study_order as select * from laboratory_test_ordered;

create view laboratory_test_order as select * from laboratory_test;
create view diagnosis_family_history as select * from diagnosis_active where false;
create view procedure_order as select * from procedure_performed where status = 'ordered';
create view patient_characteristic_clinical_trial_participant as select * from individual_characteristic;
create view patient_characteristic_expired as select * from individual_characteristic;

create view intervention_order as select * from intervention_ordered;
create view encounter_order as select * from encounter;
