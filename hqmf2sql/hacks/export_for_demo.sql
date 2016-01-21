create schema export_hqmf;

set search_path = export_hqmf;

create table generic_hqmf_event as select * from hqmf_cypress_ep.generic_hqmf_event;

CREATE TABLE diagnosis_active as select * from hqmf_cypress_ep.diagnosis_active;

create table patients as select * from hqmf_cypress_ep.patients;
alter table patients add primary key(patient_id);
cluster patients using patients_pkey;

create table individual_characteristic as select * from hqmf_cypress_ep.individual_characteristic;
create index individual_characteristic_patient_id_code on individual_characteristic(patient_id, code);
cluster individual_characteristic using individual_characteristic_patient_id_code;


SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'LATIN9';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: hqmf_cypress_ep; Type: SCHEMA; Schema: -; Owner: -
--

--
-- Name: qds_generic_event; Type: TYPE; Schema: hqmf_cypress_ep; Owner: -
--

CREATE TYPE qds_generic_event AS (
	patient_id integer,
	start_dt timestamp without time zone,
	end_dt timestamp without time zone,
	audit_key_type text,
	audit_key_value integer
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: allergy; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW allergy AS
 SELECT DISTINCT g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    (g.value)::numeric AS value,
    g.audit_key_type,
    g.audit_key_value
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = ANY (ARRAY['device_allergy'::text, 'medication_allergy'::text]));


--
-- Name: communication; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW communication AS
 SELECT DISTINCT g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    (g.value)::numeric AS value,
    g.audit_key_type,
    g.audit_key_value,
    NULL::numeric AS reason
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = 'communication'::text);


--
-- Name: device_applied; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW device_applied AS
 SELECT DISTINCT g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    (g.value)::numeric AS value,
    g.audit_key_type,
    g.audit_key_value,
    g.start_dt AS start_datetime,
    g.target_site_concept_id AS anatomical_structure,
    NULL::numeric AS reason
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = 'device_applied'::text);


--
-- Name: diagnosis_inactive; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW diagnosis_inactive AS
 SELECT DISTINCT g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    (g.value)::numeric AS value,
    g.audit_key_type,
    g.audit_key_value
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = 'diagnosis_inactive'::text);


--
-- Name: diagnosis_resolved; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW diagnosis_resolved AS
 SELECT DISTINCT g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    (g.value)::numeric AS value,
    g.audit_key_type,
    g.audit_key_value
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = 'diagnosis_resolved'::text);


--
-- Name: diagnostic_study_performed; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW diagnostic_study_performed AS
 SELECT DISTINCT g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    (g.value)::numeric AS value,
    g.audit_key_type,
    g.audit_key_value,
    NULL::numeric AS reason
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = 'diagnostic_study_performed'::text);


--
-- Name: diagnostic_study_result; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW diagnostic_study_result AS
 SELECT DISTINCT g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    (g.value)::numeric AS value,
    g.audit_key_type,
    g.audit_key_value
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = 'diagnostic_study_result'::text);


--
-- Name: encounter; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW encounter AS
 SELECT DISTINCT g.event_id,
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value,
    g.event_type,
    g.status_code,
    g.template_ids,
    g.value_codesystem,
    g.value_code,
    g.discharge_status,
    g.route_concept_id,
    g.target_site_concept_id,
    g.priority_concept_id,
    g.audit_key_type,
    g.audit_key_value,
    NULL::integer AS facility_location,
    g.start_dt AS admission_datetime,
    g.end_dt AS discharge_datetime,
    (g.end_dt - g.start_dt) AS length_of_stay,
    NULL::numeric AS reason
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = 'encounter'::text);


--
-- Name: encounter_performed; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW encounter_performed AS
 SELECT encounter.event_id,
    encounter.patient_id,
    encounter.start_dt,
    encounter.end_dt,
    encounter.code,
    encounter.status,
    encounter.negation,
    encounter.value,
    encounter.event_type,
    encounter.status_code,
    encounter.template_ids,
    encounter.value_codesystem,
    encounter.value_code,
    encounter.discharge_status,
    encounter.route_concept_id,
    encounter.target_site_concept_id,
    encounter.priority_concept_id,
    encounter.audit_key_type,
    encounter.audit_key_value,
    encounter.facility_location,
    encounter.admission_datetime,
    encounter.discharge_datetime,
    encounter.length_of_stay,
    encounter.reason
   FROM encounter;


--
-- Name: procedure_performed; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW procedure_performed AS
 SELECT DISTINCT g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    (g.value)::numeric AS value,
    g.audit_key_type,
    g.audit_key_value,
    g.priority_concept_id AS ordinal,
    NULL::numeric AS reason
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = ANY (ARRAY['procedure_performed'::text, 'intervention_performed'::text]));


--
-- Name: procedure_ordered; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW procedure_ordered AS
 SELECT procedure_performed.patient_id,
    procedure_performed.start_dt,
    procedure_performed.end_dt,
    procedure_performed.code,
    procedure_performed.status,
    procedure_performed.negation,
    procedure_performed.value,
    procedure_performed.audit_key_type,
    procedure_performed.audit_key_value,
    procedure_performed.ordinal,
    procedure_performed.reason
   FROM procedure_performed
  WHERE (procedure_performed.status = 'ordered'::text);


--
-- Name: intervention_ordered; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW intervention_ordered AS
 SELECT procedure_ordered.patient_id,
    procedure_ordered.start_dt,
    procedure_ordered.end_dt,
    procedure_ordered.code,
    procedure_ordered.status,
    procedure_ordered.negation,
    procedure_ordered.value,
    procedure_ordered.audit_key_type,
    procedure_ordered.audit_key_value,
    procedure_ordered.ordinal,
    procedure_ordered.reason
   FROM procedure_ordered;


--
-- Name: laboratory_test; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW laboratory_test AS
 SELECT DISTINCT g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    (g.value)::numeric AS value,
    g.audit_key_type,
    g.audit_key_value
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = 'laboratory_test'::text);


--
-- Name: medication_active; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW medication_active AS
 SELECT DISTINCT g.event_id,
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value,
    g.event_type,
    g.status_code,
    g.template_ids,
    g.value_codesystem,
    g.value_code,
    g.discharge_status,
    g.route_concept_id,
    g.target_site_concept_id,
    g.priority_concept_id,
    g.audit_key_type,
    g.audit_key_value,
    (g.end_dt - g.start_dt) AS cumulative_medication_duration
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = 'medication_active'::text);


--
-- Name: medication_administered; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW medication_administered AS
 SELECT DISTINCT g.event_id,
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value,
    g.event_type,
    g.status_code,
    g.template_ids,
    g.value_codesystem,
    g.value_code,
    g.discharge_status,
    g.route_concept_id,
    g.target_site_concept_id,
    g.priority_concept_id,
    g.audit_key_type,
    g.audit_key_value,
    (g.end_dt - g.start_dt) AS cumulative_medication_duration
   FROM generic_hqmf_event g
  WHERE ((EXISTS ( SELECT 1
           FROM valuesets.hl7_template_xref x
          WHERE ((x.template_id = ANY (g.template_ids)) AND (x.template_name = 'medication_activity_consolidation'::text)))) AND (NOT (EXISTS ( SELECT 1
           FROM valuesets.hl7_template_xref x
          WHERE ((x.template_id = ANY (g.template_ids)) AND (x.template_name = ANY (ARRAY['medication_active'::text, 'medication_dispensed'::text, 'medication_order'::text])))))));


--
-- Name: medication_discharge; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW medication_discharge AS
 SELECT DISTINCT g.event_id,
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value,
    g.event_type,
    g.status_code,
    g.template_ids,
    g.value_codesystem,
    g.value_code,
    g.discharge_status,
    g.route_concept_id,
    g.target_site_concept_id,
    g.priority_concept_id,
    g.audit_key_type,
    g.audit_key_value,
    (g.end_dt - g.start_dt) AS cumulative_medication_duration
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = 'medication_discharge'::text);


--
-- Name: medication_dispensed; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW medication_dispensed AS
 SELECT DISTINCT g.event_id,
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value,
    g.event_type,
    g.status_code,
    g.template_ids,
    g.value_codesystem,
    g.value_code,
    g.discharge_status,
    g.route_concept_id,
    g.target_site_concept_id,
    g.priority_concept_id,
    g.audit_key_type,
    g.audit_key_value,
    (g.end_dt - g.start_dt) AS cumulative_medication_duration
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = 'medication_dispensed'::text);


--
-- Name: medication_order; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW medication_order AS
 SELECT DISTINCT g.event_id,
    g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    g.value,
    g.event_type,
    g.status_code,
    g.template_ids,
    g.value_codesystem,
    g.value_code,
    g.discharge_status,
    g.route_concept_id,
    g.target_site_concept_id,
    g.priority_concept_id,
    g.audit_key_type,
    g.audit_key_value,
    (g.end_dt - g.start_dt) AS cumulative_medication_duration,
    NULL::integer AS reason
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = 'medication_order'::text);


--
-- Name: medication_ordered; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW medication_ordered AS
 SELECT medication_order.event_id,
    medication_order.patient_id,
    medication_order.start_dt,
    medication_order.end_dt,
    medication_order.code,
    medication_order.status,
    medication_order.negation,
    medication_order.value,
    medication_order.event_type,
    medication_order.status_code,
    medication_order.template_ids,
    medication_order.value_codesystem,
    medication_order.value_code,
    medication_order.discharge_status,
    medication_order.route_concept_id,
    medication_order.target_site_concept_id,
    medication_order.priority_concept_id,
    medication_order.audit_key_type,
    medication_order.audit_key_value,
    medication_order.cumulative_medication_duration,
    medication_order.reason
   FROM medication_order;


--
-- Name: patient_characteristic_birthdate; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW patient_characteristic_birthdate AS
 SELECT individual_characteristic.patient_id,
    individual_characteristic.start_dt,
    individual_characteristic.end_dt,
    individual_characteristic.code,
    individual_characteristic.status,
    individual_characteristic.negation,
    individual_characteristic.value,
    individual_characteristic.audit_key_type,
    individual_characteristic.audit_key_value
   FROM individual_characteristic;


--
-- Name: patient_characteristic_ethnicity; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW patient_characteristic_ethnicity AS
 SELECT individual_characteristic.patient_id,
    individual_characteristic.start_dt,
    individual_characteristic.end_dt,
    individual_characteristic.code,
    individual_characteristic.status,
    individual_characteristic.negation,
    individual_characteristic.value,
    individual_characteristic.audit_key_type,
    individual_characteristic.audit_key_value
   FROM individual_characteristic;


--
-- Name: patient_characteristic_gender; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW patient_characteristic_gender AS
 SELECT individual_characteristic.patient_id,
    individual_characteristic.start_dt,
    individual_characteristic.end_dt,
    individual_characteristic.code,
    individual_characteristic.status,
    individual_characteristic.negation,
    individual_characteristic.value,
    individual_characteristic.audit_key_type,
    individual_characteristic.audit_key_value
   FROM individual_characteristic;


--
-- Name: patient_characteristic_payer; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW patient_characteristic_payer AS
 SELECT individual_characteristic.patient_id,
    individual_characteristic.start_dt,
    individual_characteristic.end_dt,
    individual_characteristic.code,
    individual_characteristic.status,
    individual_characteristic.negation,
    individual_characteristic.value,
    individual_characteristic.audit_key_type,
    individual_characteristic.audit_key_value
   FROM individual_characteristic;


--
-- Name: patient_characteristic_race; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW patient_characteristic_race AS
 SELECT individual_characteristic.patient_id,
    individual_characteristic.start_dt,
    individual_characteristic.end_dt,
    individual_characteristic.code,
    individual_characteristic.status,
    individual_characteristic.negation,
    individual_characteristic.value,
    individual_characteristic.audit_key_type,
    individual_characteristic.audit_key_value
   FROM individual_characteristic;



--
-- Name: physical_exam; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW physical_exam AS
 SELECT DISTINCT g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    (g.value)::numeric AS value,
    g.audit_key_type,
    g.audit_key_value
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = ANY (ARRAY['physical_exam'::text, 'physical_exam_finding'::text]));


--
-- Name: physical_exam_performed; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW physical_exam_performed AS
 SELECT physical_exam.patient_id,
    physical_exam.start_dt,
    physical_exam.end_dt,
    physical_exam.code,
    physical_exam.status,
    physical_exam.negation,
    physical_exam.value,
    physical_exam.audit_key_type,
    physical_exam.audit_key_value
   FROM physical_exam;


--
-- Name: procedure_intolerance; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW procedure_intolerance AS
 SELECT DISTINCT g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    (g.value)::numeric AS value,
    g.audit_key_type,
    g.audit_key_value
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = 'procedure_intolerance'::text);


--
-- Name: procedure_result; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW procedure_result AS
 SELECT DISTINCT g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    (g.value)::numeric AS value,
    g.audit_key_type,
    g.audit_key_value
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = ANY (ARRAY['procedure_result'::text, 'functional_status_result'::text]));


--
-- Name: risk_category_assessment; Type: VIEW; Schema: hqmf_cypress_ep; Owner: -
--

CREATE VIEW risk_category_assessment AS
 SELECT DISTINCT g.patient_id,
    g.start_dt,
    g.end_dt,
    g.code,
    g.status,
    g.negation,
    (g.value)::numeric AS value,
    g.audit_key_type,
    g.audit_key_value,
    NULL::numeric AS reason
   FROM (generic_hqmf_event g
     JOIN valuesets.hl7_template_xref x ON ((x.template_id = ANY (g.template_ids))))
  WHERE (x.template_name = 'risk_category_assessment'::text);


--
-- Name: generic_hqmf_event_pkey; Type: CONSTRAINT; Schema: hqmf_cypress_ep; Owner: -; Tablespace: 
--

ALTER TABLE ONLY generic_hqmf_event
    ADD CONSTRAINT generic_hqmf_event_pkey PRIMARY KEY (event_id);


--
-- Name: diagnosis_active_patient_id_code; Type: INDEX; Schema: hqmf_cypress_ep; Owner: -; Tablespace: 
--

CREATE INDEX diagnosis_active_patient_id_code ON diagnosis_active USING btree (patient_id, code);

ALTER TABLE diagnosis_active CLUSTER ON diagnosis_active_patient_id_code;


--
-- Name: generic_hqmf_event_code_idx; Type: INDEX; Schema: hqmf_cypress_ep; Owner: -; Tablespace: 
--

CREATE INDEX generic_hqmf_event_code_idx ON generic_hqmf_event USING btree (code);


--
-- Name: generic_hqmf_event_patient_idx; Type: INDEX; Schema: hqmf_cypress_ep; Owner: -; Tablespace: 
--

CREATE INDEX generic_hqmf_event_patient_idx ON generic_hqmf_event USING btree (patient_id);

ALTER TABLE generic_hqmf_event CLUSTER ON generic_hqmf_event_patient_idx;
