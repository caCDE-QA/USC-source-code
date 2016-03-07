:r "C:\Ephir\hqmf2sql\omop_etl\defaults.sql"

DECLARE @birthdate_concept_id int =  3022007;

--create schema :hqmf_schema;
--set search_path = :hqmf_schema, :omop_hqmf_additions_schema, :omop_schema, :omop_mapping_schema, :vocab_schema;
EXEC ('CREATE SCHEMA '+@hqmf_schema+';');

EXEC('create type '+@hqmf_schema+'.hqmf_omop_audit 
	as  table (
   type_name text,
   key_value integer
);');

EXEC('create type '+@hqmf_schema+'.qds_generic_event 
as table (
   patient_id integer,
   start_dt datetime,
   end_dt datetime,
   audit_key_type text,
   audit_key_value bigint
);');


EXEC('create view '+@hqmf_schema+'.patients as select
   person_id as patient_id,
   cast(NULL as timestamp) as start_dt,
   cast(NULL as timestamp) as end_dt,
   cast(NULL as int) as code,
   cast(NULL as varchar(max)) as status,
   cast(NULL as int) as negation,
   cast(NULL as varchar(max)) as value,
   ''person''audit_key_type,
   person_id as audit_key_value
from '+@omop_schema+'.person;');

--create or replace function unmapped_value(text) returns text as $$
--DECLARE
--   input_string alias for $1;
--BEGIN
--   return('unmapped value: '::text || input_string);
--END
--$$
--LANGUAGE 'plpgsql' immutable;

--create or replace function unmapped_numeric_value(text) returns numeric as $$
--DECLARE
--   input_string alias for $1;
--BEGIN
--   return(NULL::numeric);
--END
--$$
--LANGUAGE 'plpgsql' immutable;

-- What we need is a code set that includes procedure/diagnosis codes that
-- indicate encounters; then we could take just that subset. But we don't
-- have that, so we'll make a huge materialized view of all procedures and
-- all encounters.


EXEC('create view '+@hqmf_schema+'.encounter 
WITH SCHEMABINDING
as select
   p.person_id as patient_id,
   p.visit_start_date as start_dt,
   p.visit_end_date as end_dt,
   p.procedure_concept_id as code,
   cast(NULL as varchar(max)) as status,
   cast(NULL as int) as negation,
   cast(NULL as varchar(max)) as value,
   ''procedure_occurrence'' as audit_key_type,
   p.procedure_occurrence_id as audit_key_value,
   p.place_of_service_concept_id as FACILITY_LOCATION
from '+@omop_hqmf_additions_schema+'.visit_procedure_view p
union all 
	select
  v.person_id as patient_id,
  v.condition_start_date as start_dt,
  v.condition_end_date as end_dt,
  v.condition_concept_id as code,
  ''active'' as status,
  cast(NULL as int) as negation,
  cast(NULL as varchar(5000)) as value,
  ''condition_occurrence''as audit_key_type,
  v.condition_occurrence_id as audit_key_value,
  v.place_of_service_concept_id as FACILITY_LOCATION 
from '+@omop_hqmf_additions_schema+'.visit_condition_view v;');

--can not create these indexes in SQL Server. It requires UNIQUE CLUSTERED index to be created first.
--EXEC('create index encounter_patient_idx on '+@hqmf_schema+'.encounter(patient_id);');
--EXEC('create index encounter_start_dt_idx on '+@hqmf_schema+'.encounter(start_dt);');
--EXEC('create index encounter_end_dt_idx on '+@hqmf_schema+'.encounter(end_dt);');
--EXEC('create index encounter_code_idx on '+@hqmf_schema+'.encounter(code);');
--cluster encounter using encounter_patient_idx;
--analyze encounter;


EXEC('create view '+@hqmf_schema+'.drug_view as select
  d.*,
  m.*
  from '+@omop_schema+'.drug_exposure d 
  left join '+@omop_mapping_schema+'.med_status_map m on d.drug_type_concept_id = m.omop_concept_id;');

EXEC('create view '+@hqmf_schema+'.medication_view as select
  person_id as patient_id,
-- Uncomment if you have extended OMOP with start/end timestamp fields
--  drug_exposure_start_timestamp as start_dt,
--  drug_exposure_end_timestamp as end_dt,
-- Otherwise, use these:
  drug_exposure_start_date as start_dt,
  drug_exposure_end_date as end_dt,
  drug_concept_id as code,
  hqmf_status as status,
  cast(NULL as int) as negation,
  cast(NULL as varchar(max)) as value,
  ''drug_exposure'' as audit_key_type,
  drug_exposure_id as audit_key_value,
  days_supply as CUMULATIVE_MEDICATION_DURATION
--* interval ''1 day'' 
from '+@hqmf_schema+'.drug_view;');

EXEC('create view '+@hqmf_schema+'.medication_active as select * from '+@hqmf_schema+'.medication_view where status = ''active'';');
EXEC('create view '+@hqmf_schema+'.medication_administered as select * from '+@hqmf_schema+'.medication_view where status = ''administered'';');
EXEC('create view '+@hqmf_schema+'.medication_dispensed as select * from '+@hqmf_schema+'.medication_view where status = ''dispensed'';');
EXEC('create view '+@hqmf_schema+'.medication_order as select * from '+@hqmf_schema+'.medication_view where status = ''ordered'';');


EXEC('create view '+@hqmf_schema+'.diagnosis_view 
WITH SCHEMABINDING
as select
  person_id as patient_id,
  condition_start_date as start_dt,
  condition_end_date as end_dt,
  condition_concept_id as code,
  ''active'' as status,
  cast(NULL as int) as negation,
  cast(NULL as varchar(max)) as value,
  ''condition_occurrence''as audit_key_type,
  condition_occurrence_id as audit_key_value,
-- Severity is not modeled in OMOP. But it might be in the source data.
  cast(NULL as int) as severity,					     
  --unmapped_numeric_value(''ORDINAL'') as ordinal
  cast(null as numeric) as ordinal
from '+@omop_schema+'.condition_occurrence;');

EXEC('create view '+@hqmf_schema+'.diagnosis_active as select * from '+@hqmf_schema+'.diagnosis_view where status = ''active'';');
EXEC('create view '+@hqmf_schema+'.diagnosis_inactive as select * from '+@hqmf_schema+'.diagnosis_view where status = ''inactive'';');
EXEC('create view '+@hqmf_schema+'.diagnosis_resolved as select * from '+@hqmf_schema+'.diagnosis_view where status = ''resolved'';');


EXEC('create view '+@hqmf_schema+'.procedure_view 
WITH SCHEMABINDING
as select
  person_id as patient_id,
-- Uncomment if you have extended OMOP with start/end timestamp fields
--  procedure_timestamp as start_dt,
--  procedure_timestamp as end_dt,
-- Otherwise, use these:
  procedure_date as start_dt,
  procedure_date as end_dt,
  procedure_concept_id as code,
  ''performed'' as status,
  cast(NULL as int) as negation,
  cast(NULL as numeric) as value,
  ''procedure_occurrence'' as audit_key_type,
  procedure_occurrence_id as audit_key_value,
  --unmapped_numeric_value(''REASON'') as reason
  cast(null as numeric) as reason
from '+@omop_schema+'.procedure_occurrence
-- Uncomment if you have extended OMOP with a table for procedures with negative statuses
-- union select
--   person_id as patient_id,
--   procedure_timestamp as start_dt,
--   procedure_timestamp as end_dt,
--   procedure_concept_id as code,
--   procedure_status as status,
--   NULL::integer as negation,
--   NULL::numeric as value,
--   ''procedure_occurrence'' as audit_key_type,
--   procedure_occurrence_id as audit_key_value,
--   unmapped_numeric_value(''REASON'') as reason
--	 cast(null as numeric) as reason
-- from '+@omop_hqmf_additions_schema+'.non_performed_procedures
;');


EXEC('create view '+@hqmf_schema+'.procedure_performed 
--WITH SCHEMABINDING
as select * from '+@hqmf_schema+'.procedure_view where status in (''performed'', null)
  union select patient_id, start_dt, end_dt, code, status, negation, null, audit_key_type, audit_key_value, 
  --unmapped_numeric_value(''REASON'') as reason
  cast(NULL as varchar(5000)) as reason
  from '+@hqmf_schema+'.diagnosis_view;');
--can not create these indecies in SQL Server, it requires UNIQUE CLUSTERED index to be created
--EXEC('create index procedure_performed_patient_idx on '+@hqmf_schema+'.procedure_performed(patient_id);');
--EXEC('create index procedure_performed_start_dt_idx on '+@hqmf_schema+'.procedure_performed(start_dt);');
--EXEC('create index procedure_performed_end_dt_idx on '+@hqmf_schema+'.procedure_performed(end_dt);');
--EXEC('create index procedure_performed_code_idx on '+@hqmf_schema+'.procedure_performed(code);');
--cluster procedure_performed using procedure_performed_patient_idx;
--analyze procedure_performed;


EXEC('create view '+@hqmf_schema+'.diagnostic_study_performed as select * from '+@hqmf_schema+'.procedure_view where status in (''performed'', null);');
EXEC('create view '+@hqmf_schema+'.device_applied as select * from '+@hqmf_schema+'.procedure_view where status in (''performed'', null);');
EXEC('create view '+@hqmf_schema+'.communication as select * from '+@hqmf_schema+'.procedure_view;');


EXEC('create view '+@hqmf_schema+'.laboratory_test 
--WITH SCHEMABINDING
as select
  person_id as patient_id,
  observation_time as start_dt,
  observation_time as end_dt,
  observation_concept_id as code,
  cast(NULL as varchar(max)) as status,
  cast(NULL as int)  as negation,
  case
    when observation_type_concept_id = '+@lab_observation_concept_code_concept_id+'
         then value_as_concept_id
when observation_type_concept_id = '+@lab_observation_text_concept_id+'
         and value_as_number is null and value_as_concept_id is null
         and value_as_string is not null
         then (select concept_id from '+@omop_vocab_schema+'.concept where concept_code = '+@lab_observation_unmapped_text_name+')
    else coalesce(value_as_concept_id, cast(value_as_number as numeric))
    end as value,
    ''observation'' as audit_key_type,
    observation_id as audit_key_value
from '+@omop_hqmf_additions_schema+'.observation_view where value_as_number is not null or value_as_concept_id is not null
     or observation_type_concept_id in (select concept_id from '+@valueset_schema+'.lab_test_observation_types)
union 
select patient_id, start_dt, end_dt, code, status, negation, value, 
audit_key_type, audit_key_value from '+@hqmf_schema+'.diagnostic_study_performed;');

--can not create these indecies in SQL Server, it requires UNIQUE CLUSTERED index to be created
--EXEC('create clustered index laboratory_test_patient_idx on '+@hqmf_schema+'.laboratory_test(patient_id);');
--EXEC('create index laboratory_test_start_dt_idx on '+@hqmf_schema+'.laboratory_test(start_dt);');
--EXEC('create index laboratory_test_end_dt_idx on '+@hqmf_schema+'.laboratory_test(end_dt);');
--EXEC('create index laboratory_test_code_idx on '+@hqmf_schema+'.laboratory_test(code);');
--cluster laboratory_test using laboratory_test_patient_idx;
--analyze laboratory_test;

EXEC('create view '+@hqmf_schema+'.physical_exam as select * from '+@hqmf_schema+'.laboratory_test;');
EXEC('create view '+@hqmf_schema+'.procedure_result as select * from '+@hqmf_schema+'.laboratory_test;');

EXEC('create view '+@hqmf_schema+'.diagnostic_study_result as select * from '+@hqmf_schema+'.laboratory_test
union select patient_id, start_dt, end_dt, code, status, negation, null as value, audit_key_type, audit_key_value
from '+@hqmf_schema+'.diagnosis_view;');

--can not create these indecies in SQL Server, it requires UNIQUE CLUSTERED index to be created
--EXEC('create clustered index diagnostic_study_result_patient_idx on '+@hqmf_schema+'.diagnostic_study_result(patient_id);');
--EXEC('create index diagnostic_study_result_start_dt_idx on '+@hqmf_schema+'.diagnostic_study_result(start_dt);');
--EXEC('create index diagnostic_study_result_end_dt_idx on '+@hqmf_schema+'.diagnostic_study_result(end_dt);');
--EXEC('create index diagnostic_study_result_code_idx on '+@hqmf_schema+'.diagnostic_study_result(code);');
--cluster diagnostic_study_result using diagnostic_study_result_patient_idx;
--analyze diagnostic_study_result;


EXEC('create view '+@hqmf_schema+'.allergy as select
  person_id as patient_id,
  observation_timestamp as start_dt,
  cast(null as timestamp) as end_dt,
  observation_concept_id as code,
  cast(NULL as varchar(max)) as status,
  cast(NULL as int) as negation,
  cast(NULL as numeric) as value,
  ''observation'' as audit_key_type,
  observation_id as audit_key_value
from '+@omop_hqmf_additions_schema+'.observation_view;');

EXEC('create view '+@hqmf_schema+'.device_intolerance as select * from '+@hqmf_schema+'.allergy;');
EXEC('create view '+@hqmf_schema+'.procedure_intolerance as select * from '+@hqmf_schema+'.allergy;');

EXEC('create view '+@hqmf_schema+'.risk_category_assessment as select * from '+@hqmf_schema+'.procedure_view;');

EXEC('create view '+@hqmf_schema+'.individual_characteristic 
--WITH SCHEMABINDING
	as select
   person_id as patient_id,
--   ydm_to_date(year_of_birth, month_of_birth, day_of_birth) as start_dt,
   cast(cast(coalesce(day_of_birth, 1) as varchar)+''/''+cast(coalesce(month_of_birth, 1) as varchar)+''/''
   +cast(coalesce(year_of_birth, 1990) as varchar) as date) as start_dt,
   cast(NULL as timestamp) as end_dt,
   '+@birthdate_concept_id+' as code,
   cast(NULL as varchar(max)) as status,
   cast(NULL as int) as negation,
   cast(NULL as varchar(max)) as value,
   ''person'' as audit_key_type,
   person_id as audit_key_value
from '+@omop_schema+'.person
union select
   p.person_id as patient_id,
--   ydm_to_date(p.year_of_birth, p.month_of_birth, p.day_of_birth)::timestamp as start_dt,
   cast(cast(coalesce(day_of_birth, 1) as varchar)+''/''+cast(coalesce(month_of_birth, 1) as varchar)+''/''
   +cast(coalesce(year_of_birth, 1990) as varchar) as date) as start_dt,
   cast(NULL as timestamp) as end_dt,
   p.gender_concept_id as code,
   cast(NULL as varchar(max)) as status,
   cast(NULL as int) as negation,
   c.concept_code as value,
   ''person''as audit_key_type,
   person_id as audit_key_value
from '+@omop_schema+'.person p join '+@vocab_schema+'.concept c on c.concept_id = p.gender_concept_id
union select
   person_id as patient_id,
   death_date as start_dt,
   cast(NULL as timestamp) as end_dt,
   death_type_concept_id as code,
   cast(NULL as varchar(max)) as status,
   cast(NULL as int) as  negation,
   cast(NULL as varchar(max)) as value,
   ''death'' as audit_key_type,
   person_id as audit_key_value
from '+@omop_schema+'.death
union select distinct
   person_id as patient_id,
   condition_start_date as start_dt,
   cast(NULL as timestamp) as end_dt,
   c.condition_concept_id as code,
   ''active'' as status,
   cast(NULL as int) as negation,
   cast(NULL as varchar(max)) as value,
   ''condition_occurrence'' as audit_key_type,
   condition_occurrence_id as audit_key_value
from '+@omop_schema+'.condition_occurrence c join '+@valueset_schema+'.code_lists l on l.code = c.condition_concept_id
join '+@valueset_schema+'.value_sets vs on vs.value_set_oid = l.code_list_id
where lower(vs.value_set_name) like ''%tobacco%'' or lower(vs.value_set_name) like ''%smok%'';');

--can not create these indecies in SQL Server, it requires UNIQUE CLUSTERED index to be created
--EXEC('create clustered index individual_characteristic_patient_idx on '+@hqmf_schema+'.individual_characteristic(patient_id);');
--EXEC('create index individual_characteristic_start_dt_idx on '+@hqmf_schema+'.individual_characteristic(start_dt);');
--EXEC('create index individual_characteristic_end_dt_idx on '+@hqmf_schema+'.individual_characteristic(end_dt);');
--EXEC('create index individual_characteristic_code_idx on '+@hqmf_schema+'.individual_characteristic(code);');
--cluster individual_characteristic using '+@hqmf_schema+'.individual_characteristic_patient_idx;');
--analyze individual_characteristic;

-- kludge until data model is revamped
EXEC('create view '+@hqmf_schema+'.encounter_performed as select * from '+@hqmf_schema+'.encounter ;');
EXEC('create view '+@hqmf_schema+'.patient_characteristic_payer as select * from '+@hqmf_schema+'.individual_characteristic;');
EXEC('create view '+@hqmf_schema+'.patient_characteristic_gender as select * from '+@hqmf_schema+'.individual_characteristic;');
EXEC('create view '+@hqmf_schema+'.patient_characteristic_ethnicity as select * from '+@hqmf_schema+'.individual_characteristic;');
EXEC('create view '+@hqmf_schema+'.patient_characteristic_race as select * from '+@hqmf_schema+'.individual_characteristic;');
EXEC('create view '+@hqmf_schema+'.patient_characteristic_birthdate as select * from '+@hqmf_schema+'.individual_characteristic;');
EXEC('create view '+@hqmf_schema+'.patient_characteristic_expired as select * from '+@hqmf_schema+'.individual_characteristic;');
EXEC('create view '+@hqmf_schema+'.physical_exam_performed as select * from '+@hqmf_schema+'.physical_exam;');
EXEC('create view '+@hqmf_schema+'.procedure_ordered as select * from '+@hqmf_schema+'.procedure_performed where status = ''ordered'';');
EXEC('create view '+@hqmf_schema+'.intervention_ordered as select * from '+@hqmf_schema+'.procedure_ordered;');
EXEC('create view '+@hqmf_schema+'.intervention_performed as select * from '+@hqmf_schema+'.procedure_performed;');
EXEC('create view '+@hqmf_schema+'.medication_ordered as select * from '+@hqmf_schema+'.medication_order;');
EXEC('create view '+@hqmf_schema+'.laboratory_test_performed as select * from '+@hqmf_schema+'.laboratory_test;');
EXEC('create view '+@hqmf_schema+'.medication_intolerance as select * from '+@hqmf_schema+'.allergy;');
EXEC('create view '+@hqmf_schema+'.medication_allergy as select * from '+@hqmf_schema+'.allergy;');
EXEC('create view '+@hqmf_schema+'.laboratory_test_ordered as select * from '+@hqmf_schema+'.laboratory_test;');
EXEC('create view '+@hqmf_schema+'.patient_characteristic as select * from '+@hqmf_schema+'.individual_characteristic;');
EXEC('create view '+@hqmf_schema+'.functional_status_result as select * from '+@hqmf_schema+'.procedure_result;');
EXEC('create view '+@hqmf_schema+'.diagnostic_study_ordered as select * from '+@hqmf_schema+'.laboratory_test_ordered;');

EXEC('create view '+@hqmf_schema+'.patient_characteristic_sex as select * from '+@hqmf_schema+'.individual_characteristic;');
EXEC('create view '+@hqmf_schema+'.diagnostic_study_order as select * from '+@hqmf_schema+'.laboratory_test_ordered;');

EXEC('create view '+@hqmf_schema+'.laboratory_test_order as select * from '+@hqmf_schema+'.laboratory_test;');
EXEC('create view '+@hqmf_schema+'.diagnosis_family_history as select * from '+@hqmf_schema+'.diagnosis_active where false;');
EXEC('create view '+@hqmf_schema+'.procedure_order as select * from '+@hqmf_schema+'.procedure_performed where status = ''ordered'';');
EXEC('create view '+@hqmf_schema+'.patient_characteristic_clinical_trial_participant as select * from '+@hqmf_schema+'.individual_characteristic;');
EXEC('create view '+@hqmf_schema+'.functional_status_performed as select * from '+@hqmf_schema+'.procedure_performed;');