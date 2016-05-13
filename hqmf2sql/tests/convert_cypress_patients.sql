\set vocab_schema vocabulary_plus
\set valueset_schema valuesets
\set birthdate_concept_id 3022007
\set gender_vocabulary_id 12
\set assertion_concept_id 1002046929
\set race_concept_id 4013886
\set ethnicity_concept_id 4271761
\set payer_concept_id 3048872
\set zipcode_concept_id 4083591
\set cdc_race_vocabulary_id 13
\set cdc_race_overflow_vocabulary_id 40125


set search_path = :cypress_schema, :valueset_schema, :vocab_schema;

create or replace function expand_timestamp(json) returns timestamp as $$
   select
     case
       when ($1)::text = 'null' then null
       else (($1)->>'date')::date + (($1)->>'time')::time
     end
$$ LANGUAGE SQL;

create table patient_data as select
   (p->'metadata'->>'patient_number')::integer patient_number,
   p->'patient_data'->'individual_characteristics'->>'unique_patient_id' cypress_unique_id,
   p->'metadata'->>'filename' source_filename,
   p->'patient_data'->'individual_characteristics' individual_characteristics,
   p->'patient_data'->'events' events
from (select json_array_elements(patient) p from patient_json) a;

alter table patient_data add primary key(patient_number);
cluster patient_data using patient_data_pkey;
analyze patient_data;

create sequence event_sequence;

create table event_base as select
   nextval('event_sequence') event_id,
   p.events as event,
   p.patient_number
from (select patient_number, json_array_elements(events) events from patient_data) p;

alter table event_base add primary key(event_id);

create table event as select
   min(b.event_id) event_id,
   b.patient_number,
   b.event->>'classCode' classCode,
   b.event->>'event_type' event_type,
   b.event->>'moodCode' moodCode,
   b.event->>'status_code' status_code,
   b.event->>'text' event_text,
   expand_timestamp(b.event->'start_time') start_time,
   expand_timestamp(b.event->'end_time') end_time,
   expand_timestamp(b.event->'effective_time') effective_time,
   (b.event->>'negationInd')::boolean negationInd,
   codes->>'code' event_code,
   codes->>'codeSystem' event_codesystem,
   b.event->'value'->>'code' value_code,
   b.event->'value'->>'codeSystem' value_codesystem,
   b.event->'value'->>'type' value_type,
   cast(b.event->'value'->'translation' as text) value_translation,
   b.event->'value'->>'unit' value_unit,
   (b.event->'value'->>'value')::numeric value_numeric,
   b.event->'dischargeDispositionCode'->>'code' discharge_disposition_code,
   b.event->'dischargeDispositionCode'->>'codeSystem' discharge_disposition_codesystem,
   b.event->'routeCode'->>'code' route_code,
   b.event->'routeCode'->>'codeSystem' route_codesystem,
   b.event->'targetSiteCode'->>'code' target_site_code,
   b.event->'targetSiteCode'->>'codeSystem' target_site_codesystem,
   b.event->'priorityCode'->>'code' priority_code,
   b.event->'priorityCode'->>'codeSystem' priority_codesystem
from (select *, json_array_elements(event->'codes') codes from event_base) b
group by
   b.patient_number,
   b.event->>'classCode',
   b.event->>'event_type',
   b.event->>'moodCode',
   b.event->>'status_code',
   b.event->>'text',
   expand_timestamp(b.event->'start_time'),
   expand_timestamp(b.event->'end_time'),
   expand_timestamp(b.event->'effective_time'),
   (b.event->>'negationInd')::boolean,
   codes->>'code',
   codes->>'codeSystem',
   b.event->'value'->>'code',
   b.event->'value'->>'codeSystem',
   b.event->'value'->>'type',
   cast(b.event->'value'->'translation' as text),
   b.event->'value'->>'unit',
   (b.event->'value'->>'value')::numeric,
   b.event->'dischargeDispositionCode'->>'code',
   b.event->'dischargeDispositionCode'->>'codeSystem',
   b.event->'routeCode'->>'code',
   b.event->'routeCode'->>'codeSystem',
   b.event->'targetSiteCode'->>'code',
   b.event->'targetSiteCode'->>'codeSystem',
   b.event->'priorityCode'->>'code',
   b.event->'priorityCode'->>'codeSystem'
;

create or replace view event_templates as 
  select event_id, array_agg(t) template_ids
from (select event_id, json_array_elements(event->'templateId')->>'root' t from event_base) x
group by event_id;

create or replace view expanded_event_templates as
  select e.event_id, e.event_text, regexp_replace(e.event_text, ':.*', '') short_event_text, t.template_ids
from event e join event_templates t on e.event_id = t.event_id;

create schema :hqmf_schema;
set search_path = :hqmf_schema, :cypress_schema, :valueset_schema, :vocab_schema;

create type qds_generic_event as (
   patient_id integer,
   start_dt timestamp,
   end_dt timestamp,
   audit_key_type text,
   audit_key_value integer
);


drop table if exists generic_hqmf_event;
create table generic_hqmf_event as select
  e.event_id,
  e.patient_number patient_id,
  coalesce(e.start_time, e.effective_time) start_dt,
  coalesce(e.end_time, e.effective_time) end_dt,
  code_c.concept_id code,
  e.status_code status,
  e.negationind::integer negation,
  coalesce(min(value_c.concept_id)::text, e.value_numeric::text) as value,
  e.event_type,
  e.status_code,
  t.template_ids,
  e.value_codesystem,
  e.value_code,
  min(dis_c.concept_id) discharge_status,
  min(route_c.concept_id) route_concept_id,
  min(target_site_c.concept_id) target_site_concept_id,
  min(priority_c.concept_id) priority_concept_id,
  'event'::text as audit_key_type,
  e.event_id as audit_key_value
from event e
join unified_vocabulary_map code_vm on code_vm.hqmf_code_system_oid = e.event_codesystem
left join unified_vocabulary_map value_vm on value_vm.hqmf_code_system_oid = e.value_codesystem
left join unified_vocabulary_map dis_vm on dis_vm.hqmf_code_system_oid = e.discharge_disposition_codesystem
join concept code_c on code_c.vocabulary_id = code_vm.omop_vocabulary_id and code_c.concept_code = e.event_code
left join concept value_c on value_c.vocabulary_id = value_vm.omop_vocabulary_id and value_c.concept_code = e.value_code
left join concept dis_c on dis_c.vocabulary_id = dis_vm.omop_vocabulary_id and dis_c.concept_code = e.discharge_disposition_code
left join unified_vocabulary_map route_vm on route_vm.hqmf_code_system_oid = e.route_codesystem
left join concept route_c on route_c.vocabulary_id = route_vm.omop_vocabulary_id and route_c.concept_code = e.route_code
left join unified_vocabulary_map target_site_vm on target_site_vm.hqmf_code_system_oid = e.target_site_codesystem
left join concept target_site_c on target_site_c.vocabulary_id = target_site_vm.omop_vocabulary_id and target_site_c.concept_code = e.target_site_code
left join unified_vocabulary_map priority_vm on priority_vm.hqmf_code_system_oid = e.priority_codesystem
left join concept priority_c on priority_c.vocabulary_id = priority_vm.omop_vocabulary_id and priority_c.concept_code = e.priority_code
left join event_templates t on t.event_id = e.event_id
group by
  e.event_id,
  e.patient_number,
  e.value_code,
  e.value_numeric,
  e.start_time,
  e.effective_time,
  e.end_time,
  code_c.concept_id,
  e.status_code,
  e.negationind::integer,
  e.event_type,
  e.status_code,
  e.value_codesystem,
  e.value_code,
  t.template_ids
;

alter table generic_hqmf_event add primary key(event_id);
create index generic_hqmf_event_patient_idx on generic_hqmf_event(patient_id);
create index generic_hqmf_event_code_idx on generic_hqmf_event(code);
cluster generic_hqmf_event using generic_hqmf_event_patient_idx;
analyze generic_hqmf_event;


create or replace view communication as
  select distinct 
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value::numeric,
    g.audit_key_type,
    g.audit_key_value,
    null::numeric reason
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name = 'communication';

drop table if exists diagnosis_active;
create table diagnosis_active as
  select distinct
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.value::integer code,
    g.status,
    g.negation,
    g.value,
    g.audit_key_type,
    g.audit_key_value,
    null::integer severity,
    g.priority_concept_id ordinal
from generic_hqmf_event g
join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name = 'diagnosis_active';

create index diagnosis_active_patient_id_code on diagnosis_active(patient_id, code);
cluster diagnosis_active using diagnosis_active_patient_id_code;
analyze diagnosis_active;

create or replace view medication_active as
  select distinct g.*, (end_dt - start_dt) cumulative_medication_duration
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name = 'medication_active';

create or replace view medication_administered as
  select distinct g.*, (end_dt - start_dt) cumulative_medication_duration
from generic_hqmf_event g where exists
  (select 1 from hl7_template_xref x where x.template_id = any(g.template_ids) and x.template_name = 'medication_activity_consolidation')
and not exists
  (select 1 from hl7_template_xref x where x.template_id = any(g.template_ids)
    and x.template_name in ('medication_active', 'medication_dispensed', 'medication_order'));

create or replace view medication_order as
  select distinct g.*, (end_dt - start_dt) cumulative_medication_duration, null::integer reason
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name = 'medication_order';

create or replace view medication_dispensed as
  select distinct g.*, (end_dt - start_dt) cumulative_medication_duration
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name = 'medication_dispensed';

create or replace view medication_discharge as
  select distinct g.*, (end_dt - start_dt) cumulative_medication_duration
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name = 'medication_discharge';

create or replace view diagnostic_study_performed as
  select distinct
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value::numeric,
    g.audit_key_type,
    g.audit_key_value,
    null::numeric reason
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name = 'diagnostic_study_performed';

create or replace view diagnostic_study_result as
  select distinct 
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value::numeric,
    g.audit_key_type,
    g.audit_key_value
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name = 'diagnostic_study_result';

create or replace view encounter as
  select distinct g.*, null::integer facility_location,
  g.start_dt admission_datetime, g.end_dt discharge_datetime, g.end_dt - g.start_dt length_of_stay,
  null::numeric reason
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name = 'encounter';

create or replace view laboratory_test as
  select distinct
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value::numeric,
    g.audit_key_type,
    g.audit_key_value
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name = 'laboratory_test';

create or replace view physical_exam as
  select distinct 
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value::numeric,
    g.audit_key_type,
    g.audit_key_value
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name in ('physical_exam', 'physical_exam_finding');

create or replace view procedure_performed as
  select distinct
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value::numeric,
    g.audit_key_type,
    g.audit_key_value,
    g.priority_concept_id ordinal,
    null::numeric reason
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name in ('procedure_performed', 'intervention_performed');

create or replace view procedure_result as
  select distinct
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value::numeric,
    g.audit_key_type,
    g.audit_key_value
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name in ('procedure_result', 'functional_status_result');

create or replace view risk_category_assessment as
  select distinct 
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value::numeric,
    g.audit_key_type,
    g.audit_key_value,
    null::numeric reason
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name = 'risk_category_assessment';

create or replace view device_applied as
  select distinct
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value::numeric,
    g.audit_key_type,
    g.audit_key_value,
    g.start_dt start_datetime,
    g.target_site_concept_id anatomical_structure,
    null::numeric reason
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name in ('device_applied');


create or replace view individual_characteristic as select
  p.patient_number as patient_id,
  expand_timestamp(p.individual_characteristics->'birthTime') start_dt,
  null::timestamp end_dt,
  :birthdate_concept_id as code,
  null::text as status,
  null::integer as negation,
  null::text as value,
  'patient_data'::text as audit_key_type,
  p.patient_number as audit_key_value
from patient_data p
union select
  p.patient_number as patient_id,
  expand_timestamp(p.individual_characteristics->'birthTime') start_dt,
  null::timestamp end_dt,
  c.concept_id as code,
  null::text as status,
  null::integer as negation,
  p.individual_characteristics->'administrativeGenderCode'->>'code' as value,
  'patient_data'::text as audit_key_type,
  p.patient_number as audit_key_value
from patient_data p
join concept c on c.vocabulary_id = :gender_vocabulary_id
and c.concept_code = p.individual_characteristics->'administrativeGenderCode'->>'code'
union select
  p.patient_number as patient_id,
  expand_timestamp(p.individual_characteristics->'birthTime') start_dt,
  null::timestamp end_dt,
  :race_concept_id as code,
  null::text as status,
  null::integer as negation,
  p.individual_characteristics->'raceCode'->>'code' as value,
  'patient_data'::text as audit_key_type,
  p.patient_number as audit_key_value
from patient_data p
union select
  p.patient_number as patient_id,
  expand_timestamp(p.individual_characteristics->'birthTime') start_dt,
  null::timestamp end_dt,
  :ethnicity_concept_id as code,
  null::text as status,
  null::integer as negation,
  p.individual_characteristics->'ethnicGroupCode'->>'code' as value,
  'patient_data'::text as audit_key_type,
  p.patient_number as audit_key_value
from patient_data p
union select
  p.patient_number as patient_id,
  expand_timestamp(p.individual_characteristics->'birthTime') start_dt,
  null::timestamp end_dt,
  :zipcode_concept_id as code,
  null::text as status,
  null::integer as negation,
  p.individual_characteristics->>'zip' as value,
  'patient_data'::text as audit_key_type,
  p.patient_number as audit_key_value
from patient_data p
union
-- assume all assertions are individual characteristics
select 
  patient_id,
  start_dt,
  end_dt,
  code,
  status,
  negation,
  coalesce(value_code, value),
  audit_key_type,
  audit_key_value
from generic_hqmf_event where code in (:assertion_concept_id, :payer_concept_id);

create or replace view allergy as
  select distinct
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value::numeric,
    g.audit_key_type,
    g.audit_key_value
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name in ('device_allergy', 'medication_allergy');

create or replace view diagnosis_inactive as
  select distinct
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value::numeric,
    g.audit_key_type,
    g.audit_key_value
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name in ('diagnosis_inactive');

create or replace view diagnosis_resolved as
  select distinct
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value::numeric,
    g.audit_key_type,
    g.audit_key_value
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name in ('diagnosis_resolved');

create or replace view procedure_intolerance as
  select distinct
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value::numeric,
    g.audit_key_type,
    g.audit_key_value
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name in ('procedure_intolerance');

create or replace view functional_status_performed as
  select distinct
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value::numeric,
    g.audit_key_type,
    g.audit_key_value,
    null::numeric reason
from generic_hqmf_event g join hl7_template_xref x on x.template_id = any(g.template_ids)
where x.template_name = 'functional_status_performed';


-- death is missing
-- tobacco_use goes into patient_characteristic (it's coded as an assertion)

create view patients as
 SELECT DISTINCT patient_number AS patient_id,
    NULL::timestamp without time zone AS start_dt,
    NULL::timestamp without time zone AS end_dt,
    NULL::integer AS code,
    NULL::text AS status,
    NULL::integer AS negation,
    NULL::text AS value,
    'patient_data'::text AS audit_key_type,
    patient_number AS audit_key_value
   FROM patient_data;
