\set omop_schema omop_test4
\set qrdf_schema source_data_ep
\set vocab_schema vocabulary_plus4
\set valueset_schema valuesets
\set statuskey '''HL7 ActStatus'''

\set procedure_type_concept_id  42865905
\set observation_type_concept_id 38000277
\set loinc_vocabulary 6

set search_path = :omop_schema, :qrdf_schema, :vocab_schema;

alter table procedure_occurrence add column procedure_timestamp timestamp;
alter table visit_occurrence add column visit_end_timestamp timestamp;
alter table condition_occurrence add column condition_end_timestamp timestamp;
alter table drug_exposure add column drug_exposure_end_timestamp timestamp;
alter table procedure_occurrence add column procedure_status text;

create or replace function strip_quotes(text) returns text as $$
DECLARE
  str alias for $1;
  retval text;
BEGIN
  retval = regexp_replace(trim(str), '^"(.*)"$', '\1');
  if retval = '' then
     retval = null;
  end if;
  return retval;
END
$$
LANGUAGE 'plpgsql' immutable;

create or replace function textnum2timestamp(text) returns timestamp as $$
DECLARE
  str alias for $1;
  retval timestamp;
BEGIN
  str = strip_quotes(str);
  if str similar to '[0-9.-]+' then
     return to_timestamp(str::numeric);
  end if;
  return null;
END
$$
LANGUAGE 'plpgsql' immutable;

create or replace function first_code (json) returns table (vocabulary text, code text) as $$
   select
      strip_quotes(k::text) vocabulary,
      strip_quotes(json_array_elements(a.codes->k)::text) code
   from (
      select $1 codes, json_object_keys($1) k) a limit 1
$$ LANGUAGE SQL;



create table non_performed_procedures (
  procedure_occurrence_id integer primary key,
  person_id integer references person(person_id),
  procedure_concept_id integer,
  procedure_date date,
  procedure_type_concept_id integer,
  associated_provider_id integer,
  visit_occurrence_id integer,
  relevant_condition_concept_id integer,
  procedure_source_value text,
  provenance_id integer,
  procedure_timestamp timestamp,
  procedure_status text
);

create table unobserved_observations (
   observation_id integer primary key,
   person_id integer references person(person_id),
   observation_concept_id integer,
   observation_date date,
   observation_time time,
   value_as_number numeric,
   value_as_string text,
   value_as_concept_id integer,
   unit_concept_id integer,
   range_low numeric,
   range_high numeric, 
   observation_type_concept_id integer,
   associated_provider_id integer, 
   visit_occurrence_id integer,
   relevant_condition_concept_id integer,
   observation_source_value text,
   units_source_value text,
   provenance_id integer,
   status text
);

create view qrdf_vocabulary_map as
   select hqmf_code_system_name code_vocabulary,
     omop_vocabulary_id vocabulary_id
from valuesets.unified_vocabulary_map;

create table qrdf_person_id_map (
  person_id serial not null unique,
  medical_record_number uuid primary key
);

insert into qrdf_person_id_map(medical_record_number)
  select strip_quotes((patient->'medical_record_number')::text)::uuid from patient_json;

insert into person (
  person_id,
  gender_concept_id,
  year_of_birth,
  month_of_birth,
  day_of_birth,
  race_concept_id,
  ethnicity_concept_id,
  person_source_value,
  gender_source_value,
  race_source_value,
  ethnicity_source_value
) select
  pm.person_id,
  gc.concept_id,
  date_part('year', textnum2timestamp((p.patient->'birthdate')::text)),
  date_part('month', textnum2timestamp((p.patient->'birthdate')::text)),
  date_part('day', textnum2timestamp((p.patient->'birthdate')::text)),
  rc.concept_id,
  ec.concept_id,
  strip_quotes((p.patient->'medical_record_number')::text),
  strip_quotes((p.patient->'gender')::text),
  strip_quotes((p.patient->'race'->'name')::text),
  strip_quotes((p.patient->'ethnicity'->'name')::text)
from patient_json p
join qrdf_person_id_map pm on pm.medical_record_number = strip_quotes((p.patient->'medical_record_number')::text)::uuid
left join concept gc on gc.vocabulary_id = 12 and gc.concept_code = strip_quotes((p.patient->'gender')::text)
left join concept rc on rc.vocabulary_id = 13 and trim(rc.concept_name) = strip_quotes((p.patient->'race'->'name')::text)
left join concept ec on ec.vocabulary_id = 44 and trim(ec.concept_name) = strip_quotes((p.patient->'ethnicity'->'name')::text);

create table qrdf_visit_occurrence_id_map (
   visit_occurrence_id serial not null unique,
   medical_record_number uuid not null,
   start_time timestamp not null,
   primary key (medical_record_number, start_time)
);

insert into qrdf_visit_occurrence_id_map (
   medical_record_number,
   start_time
) select x.mrn::uuid, textnum2timestamp((x.encounter->'start_time')::text) from
   (select strip_quotes((p.patient->'medical_record_number')::text) mrn, json_array_elements(p.patient->'encounters') encounter
       from patient_json p) x;

alter table visit_occurrence alter column place_of_service_concept_id drop not null;

insert into visit_occurrence (
   visit_occurrence_id,
   person_id,
   visit_start_date,
   visit_end_date,
   visit_start_timestamp,
   visit_end_timestamp
) select
   vm.visit_occurrence_id,
   pm.person_id,
   textnum2timestamp((x.encounter->'start_time')::text),
   textnum2timestamp((x.encounter->'end_time')::text),
   textnum2timestamp((x.encounter->'start_time')::text),
   textnum2timestamp((x.encounter->'end_time')::text)
from 
   (select strip_quotes((p.patient->'medical_record_number')::text) mrn, json_array_elements(p.patient->'encounters') encounter
      from patient_json p) x
   join qrdf_visit_occurrence_id_map vm on x.mrn::uuid = vm.medical_record_number and 
     textnum2timestamp((x.encounter->'start_time')::text) = vm.start_time
   join qrdf_person_id_map pm on x.mrn::uuid = pm.medical_record_number;

create sequence qrdf_observation_and_procedure_sequence;

create table qrdf_visit_procedure_id_map (
   procedure_occurrence_id integer not null default nextval('qrdf_observation_and_procedure_sequence') unique,
   medical_record_number uuid not null,
   start_time timestamp not null,
   code_vocabulary text not null,
   code_value text not null,
   primary key (medical_record_number, start_time, code_vocabulary, code_value)
);

insert into qrdf_visit_procedure_id_map (
   medical_record_number,
   start_time,
   code_vocabulary,
   code_value
) select
   a.mrn::uuid,
   a.start_time,
   a.code_vocabulary,
   a.code
from (select x.mrn, textnum2timestamp((x.encounter->'start_time')::text) start_time,
       (first_code(x.encounter->'codes')).vocabulary code_vocabulary,
       (first_code(x.encounter->'codes')).code from
       (select strip_quotes((p.patient->'medical_record_number')::text) mrn, json_array_elements(p.patient->'encounters') encounter
        from patient_json p) x) a;

insert into procedure_occurrence (
  procedure_occurrence_id,
  person_id,
  procedure_concept_id,
  procedure_date,
  procedure_type_concept_id,
  associated_provider_id,
  visit_occurrence_id,
  procedure_source_value,
  procedure_timestamp
) select distinct
  prm.procedure_occurrence_id,
  pm.person_id,
  c.concept_id,
  prm.start_time,
  :procedure_type_concept_id,
  a.performer_id::integer,
  vm.visit_occurrence_id,
  prm.code_value,
  prm.start_time
from qrdf_visit_procedure_id_map prm
  join qrdf_person_id_map pm on prm.medical_record_number = pm.medical_record_number
  join qrdf_visit_occurrence_id_map vm on prm.medical_record_number = vm.medical_record_number and prm.start_time = vm.start_time
  join (select y.mrn, y.start_time, y.performer_id,
     strip_quotes(json_array_elements(y.status_code->:statuskey)::text) status_code,
     code_vocabulary, code_value from
      (select x.mrn::uuid mrn, x.performer_id performer_id,
               textnum2timestamp((x.encounter->'start_time')::text) start_time,
               x.encounter->'status_code' status_code,
               (first_code(x.encounter->'codes')).vocabulary code_vocabulary,
               (first_code(x.encounter->'codes')).code code_value from
       (select strip_quotes((p.patient->'performer_id')::text) performer_id,
                strip_quotes((p.patient->'medical_record_number')::text) mrn,
                json_array_elements(p.patient->'encounters') encounter
        from patient_json p) x
       ) y
     ) a on a.mrn = prm.medical_record_number and a.start_time = prm.start_time and 
           a.code_vocabulary = prm.code_vocabulary and a.code_value = prm.code_value
  join qrdf_vocabulary_map vom on vom.code_vocabulary = prm.code_vocabulary
  join concept c on c.vocabulary_id = vom.vocabulary_id and c.concept_code = prm.code_value
  where a.status_code = 'performed';


create table qrdf_procedure_id_map (
   procedure_occurrence_id integer not null default nextval('qrdf_observation_and_procedure_sequence') unique,
   medical_record_number uuid not null,
   start_time timestamp not null,
   code_vocabulary text not null,
   code_value text not null,
   primary key (medical_record_number, start_time, code_vocabulary, code_value)
);

insert into qrdf_procedure_id_map (
   medical_record_number,
   start_time,
   code_vocabulary,
   code_value
) select distinct
   a.mrn::uuid,
   a.start_time,
   a.vocabulary,
   a.code
from (select x.mrn, textnum2timestamp((x.proc->'start_time')::text) start_time,
        (first_code(x.proc->'codes')).vocabulary,
        (first_code(x.proc->'codes')).code from
       (select strip_quotes((p.patient->'medical_record_number')::text) mrn, json_array_elements(p.patient->'procedures') proc
        from patient_json p) x) a;

insert into procedure_occurrence (
  procedure_occurrence_id,
  person_id,
  procedure_concept_id,
  procedure_date,
  procedure_type_concept_id,
  associated_provider_id,
  procedure_source_value,
  procedure_timestamp
) select distinct
  prm.procedure_occurrence_id,
  pm.person_id,
  c.concept_id,
  prm.start_time,
  :procedure_type_concept_id,
  a.performer_id::integer,
  prm.code_value,
  prm.start_time
from qrdf_procedure_id_map prm
  join qrdf_person_id_map pm on prm.medical_record_number = pm.medical_record_number
  join (select y.mrn, y.start_time, y.end_time, y.performer_id,
     strip_quotes(json_array_elements(y.status_code->:statuskey)::text) status_code,
     code_vocabulary, code_value from
      (select x.mrn::uuid mrn, x.performer_id performer_id,
               textnum2timestamp((x.proc->'start_time')::text) start_time,
               textnum2timestamp((x.proc->'end_time')::text) end_time,
               x.proc->'status_code' status_code,
               (first_code(x.proc->'codes')).vocabulary code_vocabulary,
               (first_code(x.proc->'codes')).code code_value from
       (select strip_quotes((p.patient->'performer_id')::text) performer_id,
                strip_quotes((p.patient->'medical_record_number')::text) mrn,
                json_array_elements(p.patient->'procedures') proc
        from patient_json p) x
       ) y
     ) a on a.mrn = prm.medical_record_number and a.start_time = prm.start_time and 
           a.code_vocabulary = prm.code_vocabulary and a.code_value = prm.code_value
  join qrdf_vocabulary_map vom on vom.code_vocabulary = prm.code_vocabulary
  join concept c on c.vocabulary_id = vom.vocabulary_id and c.concept_code = prm.code_value
  where a.status_code = 'performed';


insert into non_performed_procedures (
  procedure_occurrence_id,
  person_id,
  procedure_concept_id,
  procedure_date,
  procedure_type_concept_id,
  associated_provider_id,
  procedure_source_value,
  procedure_timestamp,
  procedure_status
) select distinct
  prm.procedure_occurrence_id,
  pm.person_id,
  c.concept_id,
  prm.start_time,
  :procedure_type_concept_id,
  a.performer_id::integer,
  prm.code_value,
  prm.start_time,
  a.status_code
from qrdf_procedure_id_map prm
  join qrdf_person_id_map pm on prm.medical_record_number = pm.medical_record_number
  join (select y.mrn, y.start_time, y.end_time, y.performer_id,
     strip_quotes(json_array_elements(y.status_code->:statuskey)::text) status_code,
     code_vocabulary, code_value from
      (select x.mrn::uuid mrn, x.performer_id performer_id,
               textnum2timestamp((x.proc->'start_time')::text) start_time,
               textnum2timestamp((x.proc->'end_time')::text) end_time,
               x.proc->'status_code' status_code,
               (first_code(x.proc->'codes')).vocabulary code_vocabulary,
               (first_code(x.proc->'codes')).code code_value from
       (select strip_quotes((p.patient->'performer_id')::text) performer_id,
                strip_quotes((p.patient->'medical_record_number')::text) mrn,
                json_array_elements(p.patient->'procedures') proc
        from patient_json p) x
       ) y
     ) a on a.mrn = prm.medical_record_number and a.start_time = prm.start_time and 
           a.code_vocabulary = prm.code_vocabulary and a.code_value = prm.code_value
  join qrdf_vocabulary_map vom on vom.code_vocabulary = prm.code_vocabulary
  join concept c on c.vocabulary_id = vom.vocabulary_id and c.concept_code = prm.code_value
  where a.status_code is distinct from 'performed';


create table qrdf_condition_occurrence_id_map (
  condition_occurrence_id serial not null unique,
  medical_record_number uuid not null,
  start_time timestamp not null,
  code_vocabulary text not null,
  code_value text not null,
  primary key (medical_record_number, start_time, code_vocabulary, code_value)
);

insert into qrdf_condition_occurrence_id_map (
   medical_record_number,
   start_time,
   code_vocabulary,
   code_value
) select distinct
   a.mrn::uuid,
   a.start_time,
   a.code_vocabulary,
   a.code_value
from (select x.mrn, textnum2timestamp((x.condition->'start_time')::text) start_time,
         (first_code(x.condition->'codes')).vocabulary code_vocabulary,
         (first_code(x.condition->'codes')).code code_value from
       (select strip_quotes((p.patient->'medical_record_number')::text) mrn, json_array_elements(p.patient->'conditions') condition
        from patient_json p) x) a;

alter table condition_occurrence alter column condition_type_concept_id drop not null;

insert into condition_occurrence (
  condition_occurrence_id,
  person_id,
  condition_concept_id,
  condition_start_date,
  condition_end_date,
  visit_occurrence_id,
  condition_source_value,
  condition_start_timestamp,
  condition_end_timestamp
) select distinct
  cm.condition_occurrence_id,
  pm.person_id,
  c.concept_id,
  a.start_time,
  a.end_time,
  vm.visit_occurrence_id,
  cm.code_value,
  a.start_time,
  a.end_time
from qrdf_condition_occurrence_id_map cm
  join qrdf_person_id_map pm on cm.medical_record_number = pm.medical_record_number
  left join qrdf_visit_occurrence_id_map vm on cm.medical_record_number = vm.medical_record_number and cm.start_time = vm.start_time
  join (select y.mrn, y.start_time, y.end_time,
     strip_quotes(json_array_elements(y.status_code->:statuskey)::text) status_code,
     code_vocabulary, code_value from
      (select x.mrn::uuid mrn, 
               textnum2timestamp((x.condition->'start_time')::text) start_time,
	       case
                  when (x.condition->'end_time')::text != 'null' then textnum2timestamp((x.condition->'end_time')::text)
                  else null
               end end_time,
               x.condition->'status_code' status_code,
              (first_code(x.condition->'codes')).vocabulary code_vocabulary,
              (first_code(x.condition->'codes')).code code_value from
       (select strip_quotes((p.patient->'performer_id')::text) performer_id,
                strip_quotes((p.patient->'medical_record_number')::text) mrn,
                json_array_elements(p.patient->'conditions') condition
        from patient_json p) x
       ) y
     ) a on a.mrn = cm.medical_record_number and a.start_time = cm.start_time and 
           a.code_vocabulary = cm.code_vocabulary and a.code_value = cm.code_value
  join qrdf_vocabulary_map vom on vom.code_vocabulary = cm.code_vocabulary
  join concept c on c.vocabulary_id = vom.vocabulary_id and c.concept_code = cm.code_value
  where status_code in ('active', 'null');



create table med_status_reverse_map as
  select hqmf_status, min(omop_concept_id) concept_id from :valueset_schema.med_status_map
  group by hqmf_status;

create table qrdf_drug_exposure_id_map (
  drug_exposure_id serial unique not null,
   medical_record_number uuid not null,
   start_time timestamp not null,
   code_vocabulary text not null,
   code_value text not null,
   primary key (medical_record_number, start_time, code_vocabulary, code_value)
);

insert into qrdf_drug_exposure_id_map (
   medical_record_number,
   start_time,
   code_vocabulary,
   code_value
) select distinct
   a.mrn::uuid,
   a.start_time,
   a.code_vocabulary,
   a.code_value
from (select x.mrn, textnum2timestamp((x.medication->'start_time')::text) start_time,
         (first_code(x.medication->'codes')).vocabulary code_vocabulary,
         (first_code(x.medication->'codes')).code code_value from
       (select strip_quotes((p.patient->'medical_record_number')::text) mrn, json_array_elements(p.patient->'medications') medication
        from patient_json p) x) a;

insert into drug_exposure (
  drug_exposure_id,
  person_id,
  drug_concept_id,
  drug_exposure_start_date,
  drug_exposure_end_date,
  drug_type_concept_id,
  drug_source_value,
  drug_exposure_start_timestamp,
  drug_exposure_end_timestamp
) select distinct
  dm.drug_exposure_id,
  pm.person_id,
  c.concept_id,
  a.start_time,
  a.end_time,
  tm.concept_id,
  dm.code_value,
  a.start_time,
  a.end_time
from qrdf_drug_exposure_id_map dm
join qrdf_person_id_map pm on dm.medical_record_number = pm.medical_record_number
  join (select y.mrn, y.start_time, y.end_time,
     strip_quotes(json_array_elements(y.status_code->:statuskey)::text) status_code,
     y.code_vocabulary, y.code_value from
      (select x.mrn::uuid mrn, 
               textnum2timestamp((x.medication->'start_time')::text) start_time,
	       case
                  when (x.medication->'end_time')::text != 'null' then textnum2timestamp((x.medication->'end_time')::text)
                  else null
               end end_time,
               x.medication->'status_code' status_code,
               (first_code(x.medication->'codes')).vocabulary code_vocabulary,
               (first_code(x.medication->'codes')).code code_value from
       (select strip_quotes((p.patient->'performer_id')::text) performer_id,
                strip_quotes((p.patient->'medical_record_number')::text) mrn,
                json_array_elements(p.patient->'medications') medication
        from patient_json p) x
       ) y
     ) a on a.mrn = dm.medical_record_number and a.start_time = dm.start_time and 
           a.code_vocabulary = dm.code_vocabulary and a.code_value = dm.code_value
  join qrdf_vocabulary_map vom on vom.code_vocabulary = dm.code_vocabulary
  join concept c on c.vocabulary_id = vom.vocabulary_id and c.concept_code = dm.code_value
  join med_status_reverse_map tm on tm.hqmf_status = a.status_code;

create table qrdf_vital_signs_id_map (
   observation_id integer not null default nextval('qrdf_observation_and_procedure_sequence') unique,
   medical_record_number uuid not null,
   start_time timestamp not null,
   code_vocabulary text not null,
   code_value text not null,
   primary key (medical_record_number, start_time, code_vocabulary, code_value)
);

insert into qrdf_vital_signs_id_map (
   medical_record_number,
   start_time,
   code_vocabulary,
   code_value
) select distinct
   a.mrn::uuid,
   a.start_time,
   code_vocabulary,
   code_value
from (select x.mrn, textnum2timestamp((x.vital_signs->'start_time')::text) start_time,
        (first_code(x.vital_signs->'codes')).vocabulary code_vocabulary,
        (first_code(x.vital_signs->'codes')).code code_value from
       (select strip_quotes((p.patient->'medical_record_number')::text) mrn, json_array_elements(p.patient->'vital_signs') vital_signs
        from patient_json p) x) a;

insert into observation (
  observation_id,
  person_id,
  observation_concept_id,
  observation_date,
  observation_time,
  value_as_number,
  value_as_string,
  value_as_concept_id,
  observation_type_concept_id,
  observation_source_value,
  units_source_value
) select distinct
  vm.observation_id,
  pm.person_id,
  c.concept_id,
  a.start_time,
  a.start_time,
  case
    when a.val_scalar ~ '^[0-9.]+$' then a.val_scalar::numeric
    else null
  end,
  coalesce(a.val_scalar, a.val_loinc),
  (select concept_id from concept where vocabulary_id = :loinc_vocabulary and concept_code = a.val_loinc),
  :observation_type_concept_id,
  coalesce(a.val_scalar, a.val_loinc),
  a.val_units
from qrdf_vital_signs_id_map vm
join qrdf_person_id_map pm on vm.medical_record_number = pm.medical_record_number
  join (select y.mrn, y.start_time, y.end_time,
     strip_quotes((y.vals->'scalar')::text) val_scalar, strip_quotes((y.val_loinc)::text) val_loinc,
     strip_quotes((y.vals->'units')::text) val_units,
     strip_quotes(json_array_elements(y.status_code->:statuskey)::text) status_code,
     code_vocabulary, code_value from
      (select x.mrn::uuid mrn, 
               textnum2timestamp((x.vital_signs->'start_time')::text) start_time,
	       case
                  when (x.vital_signs->'end_time')::text != 'null' then textnum2timestamp((x.vital_signs->'end_time')::text)
                  else null
               end end_time,
               x.vital_signs->'status_code' status_code,
               x.vals,
               case
                 when (x.vals->'codes'->'LOINC')::text is not null 
                   then json_array_elements(x.vals->'codes'->'LOINC')
                 else null
               end val_loinc,
              (first_code(x.vital_signs->'codes')).vocabulary code_vocabulary,
              (first_code(x.vital_signs->'codes')).code code_value from
         (select xx.performer_id, xx.mrn, xx.vital_signs,
                  case
                    when (xx.vital_signs->'values')::text is null then null
                    else json_array_elements(xx.vital_signs->'values') 
                  end vals from
           (select strip_quotes((p.patient->'performer_id')::text) performer_id,
                strip_quotes((p.patient->'medical_record_number')::text) mrn,
	        json_array_elements(p.patient->'vital_signs') vital_signs
            from patient_json p) xx
         ) x
       ) y
     ) a on a.mrn = vm.medical_record_number and a.start_time = vm.start_time and 
           a.code_vocabulary = vm.code_vocabulary and a.code_value = vm.code_value
  join qrdf_vocabulary_map vom on vom.code_vocabulary = vm.code_vocabulary
  join concept c on c.vocabulary_id = vom.vocabulary_id and c.concept_code = vm.code_value
  where status_code in ('performed', 'null');

insert into unobserved_observations (
  observation_id,
  person_id,
  observation_concept_id,
  observation_date,
  observation_time,
  value_as_number,
  value_as_string,
  value_as_concept_id,
  observation_type_concept_id,
  observation_source_value,
  units_source_value,
  status
) select distinct
  vm.observation_id,
  pm.person_id,
  c.concept_id,
  a.start_time,
  a.start_time,
  case
    when a.val_scalar ~ '^[0-9.]+$' then a.val_scalar::numeric
    else null
  end,
  coalesce(a.val_scalar, a.val_loinc),
  (select concept_id from concept where vocabulary_id = :loinc_vocabulary and concept_code = a.val_loinc),
  :observation_type_concept_id,
  coalesce(a.val_scalar, a.val_loinc),
  a.val_units,
  a.status_code
from qrdf_vital_signs_id_map vm
join qrdf_person_id_map pm on vm.medical_record_number = pm.medical_record_number
  join (select y.mrn, y.start_time, y.end_time,
     strip_quotes((y.vals->'scalar')::text) val_scalar, strip_quotes((y.val_loinc)::text) val_loinc,
     strip_quotes((y.vals->'units')::text) val_units,
     strip_quotes(json_array_elements(y.status_code->:statuskey)::text) status_code,
     code_vocabulary, code_value from
      (select x.mrn::uuid mrn, 
               textnum2timestamp((x.vital_signs->'start_time')::text) start_time,
	       case
                  when (x.vital_signs->'end_time')::text != 'null' then textnum2timestamp((x.vital_signs->'end_time')::text)
                  else null
               end end_time,
               x.vital_signs->'status_code' status_code,
               x.vals, 
               case
                 when (x.vals->'codes'->'LOINC')::text is not null 
                   then json_array_elements(x.vals->'codes'->'LOINC')
                 else null
               end val_loinc,
              (first_code(x.vital_signs->'codes')).vocabulary code_vocabulary,
              (first_code(x.vital_signs->'codes')).code code_value from
         (select xx.performer_id, xx.mrn, xx.vital_signs,
                  case
                    when (xx.vital_signs->'values')::text is null then null
                    else json_array_elements(xx.vital_signs->'values') 
                  end vals from
           (select strip_quotes((p.patient->'performer_id')::text) performer_id,
                strip_quotes((p.patient->'medical_record_number')::text) mrn,
	        json_array_elements(p.patient->'vital_signs') vital_signs
            from patient_json p) xx
         ) x
       ) y
     ) a on a.mrn = vm.medical_record_number and a.start_time = vm.start_time and 
           a.code_vocabulary = vm.code_vocabulary and a.code_value = vm.code_value
  join qrdf_vocabulary_map vom on vom.code_vocabulary = vm.code_vocabulary
  join concept c on c.vocabulary_id = vom.vocabulary_id and c.concept_code = vm.code_value
  where a.status_code not in ('performed', 'null');


create view observation_display_view as select c.concept_name observation_concept_name, o.*
from observation o join concept c on o.observation_concept_id = c.concept_id;


create sequence observation_kludge_sequence;

insert into observation (
  observation_id,
  person_id,
  observation_concept_id,
  observation_date,
  observation_time,
  value_as_number,
  value_as_string,
  value_as_concept_id,
  observation_type_concept_id,
  observation_source_value,
  units_source_value
) select distinct
  prm.procedure_occurrence_id + 10000 * nextval('observation_kludge_sequence'),
  pm.person_id,
  c.concept_id,
  prm.start_time,
  prm.start_time,
  case
    when a.val_scalar ~ '^[0-9.]+$' then a.val_scalar::numeric
    else null
  end,
  coalesce(a.val_code, a.val_scalar),
  vc.concept_id,
  :procedure_type_concept_id,
  coalesce(a.val_code, a.val_scalar),
  a.val_units
from qrdf_procedure_id_map prm
  join qrdf_person_id_map pm on prm.medical_record_number = pm.medical_record_number
  join (select y.mrn, y.start_time, y.performer_id,
     strip_quotes(json_array_elements(y.status_code->:statuskey)::text) status_code,
     code_vocabulary, code_value,
     y.val_units, y.val_scalar, y.val_code_type,
     case
        when y.val_code_type is not null then strip_quotes((json_array_elements(y.proc_values->'codes'->y.val_code_type))::text)
        else null
     end val_code
 from
     (select 
        yy.mrn, yy.performer_id, yy.start_time, yy.status_code, yy.proc_values, code_value, code_vocabulary,
        strip_quotes((yy.proc_values->'units')::text) val_units,
        strip_quotes((yy.proc_values->'scalar')::text) val_scalar,
        case
           when (yy.proc_values->'codes')::text is not null then json_object_keys(yy.proc_values->'codes')
           else null
        end val_code_type from
          (select x.mrn::uuid mrn, x.performer_id performer_id,
               textnum2timestamp((x.proc->'start_time')::text) start_time,
               x.proc->'status_code' status_code,
               case
                 when (x.proc->'values')::text is not null then json_array_elements(x.proc->'values')
                 else null
               end proc_values,
              (first_code(x.proc->'codes')).vocabulary code_vocabulary,
              (first_code(x.proc->'codes')).code code_value from
           (select strip_quotes((p.patient->'performer_id')::text) performer_id,
                strip_quotes((p.patient->'medical_record_number')::text) mrn,
                json_array_elements(p.patient->'procedures') proc
           from patient_json p) x
       ) yy
     ) y
     ) a on a.mrn = prm.medical_record_number and a.start_time = prm.start_time and 
           a.code_vocabulary = prm.code_vocabulary and a.code_value = prm.code_value
  join qrdf_vocabulary_map vom on vom.code_vocabulary = prm.code_vocabulary
  join concept c on c.vocabulary_id = vom.vocabulary_id and c.concept_code = prm.code_value
  left join qrdf_vocabulary_map vvm on vvm.code_vocabulary = a.val_code_type 
  left join concept vc on vc.vocabulary_id = vvm.vocabulary_id and a.val_code = vc.concept_code
  where a.status_code in ('performed', 'null') and (a.val_scalar is not null or a.val_code is not null);
