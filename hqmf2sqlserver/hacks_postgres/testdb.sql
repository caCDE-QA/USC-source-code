--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: hqmf_cypress_ep; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA hqmf_cypress_ep;


--
-- Name: results_cypress_ep; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA results_cypress_ep;


--
-- Name: valuesets; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA valuesets;


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = hqmf_cypress_ep, pg_catalog;

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


SET search_path = valuesets, pg_catalog;

--
-- Name: ydm_to_date(numeric, numeric, numeric); Type: FUNCTION; Schema: valuesets; Owner: -
--

CREATE FUNCTION ydm_to_date(numeric, numeric, numeric) RETURNS date
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
DECLARE
   i_year alias for $1;
   i_month alias for $2;
   i_day alias for $3;
BEGIN
   if ((i_year is null) or (i_month is null) or (i_day is null)) then
      return null;
   end if;
   return cast (
      (cast (i_year as char(4)) || '-' ||
       cast (i_month as char(2)) || '-' ||
       cast (i_day as char(2))) as date);
END
$_$;


SET search_path = hqmf_cypress_ep, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: generic_hqmf_event; Type: TABLE; Schema: hqmf_cypress_ep; Owner: -; Tablespace: 
--

CREATE TABLE generic_hqmf_event (
    event_id bigint NOT NULL,
    patient_id integer,
    start_dt timestamp without time zone,
    end_dt timestamp without time zone,
    code integer,
    status text,
    negation integer,
    value text,
    event_type text,
    status_code text,
    template_ids text[],
    value_codesystem text,
    value_code text,
    discharge_status integer,
    route_concept_id integer,
    target_site_concept_id integer,
    priority_concept_id integer,
    audit_key_type text,
    audit_key_value bigint
);


SET search_path = valuesets, pg_catalog;

--
-- Name: hl7_template_xref; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE hl7_template_xref (
    template_id text,
    template_name text
);


SET search_path = hqmf_cypress_ep, pg_catalog;

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
-- Name: diagnosis_active; Type: TABLE; Schema: hqmf_cypress_ep; Owner: -; Tablespace: 
--

CREATE TABLE diagnosis_active (
    patient_id integer,
    start_dt timestamp without time zone,
    end_dt timestamp without time zone,
    code integer,
    status text,
    negation integer,
    value text,
    audit_key_type text,
    audit_key_value bigint,
    severity integer,
    ordinal integer
);


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
-- Name: individual_characteristic; Type: TABLE; Schema: hqmf_cypress_ep; Owner: -; Tablespace: 
--

CREATE TABLE individual_characteristic (
    patient_id integer,
    start_dt timestamp without time zone,
    end_dt timestamp without time zone,
    code integer,
    status text,
    negation integer,
    value text,
    audit_key_type text,
    audit_key_value bigint
);


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
-- Name: patients; Type: TABLE; Schema: hqmf_cypress_ep; Owner: -; Tablespace: 
--

CREATE TABLE patients (
    patient_id integer NOT NULL,
    start_dt timestamp without time zone,
    end_dt timestamp without time zone,
    code integer,
    status text,
    negation integer,
    value text,
    audit_key_type text,
    audit_key_value integer
);


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


SET search_path = valuesets, pg_catalog;

--
-- Name: arrayed_vocabulary_map; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE arrayed_vocabulary_map (
    hqmf_code_system_oid text,
    overflow_vocabulary_id integer,
    vocabulary_ids integer[]
);


--
-- Name: hqmf_code_lists; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE hqmf_code_lists (
    code integer,
    code_list_id text
);


--
-- Name: TABLE hqmf_code_lists; Type: COMMENT; Schema: valuesets; Owner: -
--

COMMENT ON TABLE hqmf_code_lists IS 'Derived table - associates OMOP concepts (for individual codes) to HQMF vocabulary IDs';


--
-- Name: COLUMN hqmf_code_lists.code; Type: COMMENT; Schema: valuesets; Owner: -
--

COMMENT ON COLUMN hqmf_code_lists.code IS 'Concept ID associated with a particular code.';


--
-- Name: COLUMN hqmf_code_lists.code_list_id; Type: COMMENT; Schema: valuesets; Owner: -
--

COMMENT ON COLUMN hqmf_code_lists.code_list_id IS 'HQMF vocabulary OID.';


--
-- Name: omop_level_2_concept_code_lists; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE omop_level_2_concept_code_lists (
    code integer,
    code_list_id text
);


--
-- Name: code_lists; Type: VIEW; Schema: valuesets; Owner: -
--

CREATE VIEW code_lists AS
 SELECT hqmf_code_lists.code,
    hqmf_code_lists.code_list_id
   FROM hqmf_code_lists
UNION
 SELECT omop_level_2_concept_code_lists.code,
    omop_level_2_concept_code_lists.code_list_id
   FROM omop_level_2_concept_code_lists;


--
-- Name: code_lists_value_set_reverse_map; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE code_lists_value_set_reverse_map (
    value_set_oid text,
    value_set_name text,
    code_system text,
    code_system_name text,
    concept_id integer,
    concept_code text,
    concept_name text,
    vocabulary_id integer,
    vocabulary_name text,
    in_original_value_set boolean
);


--
-- Name: med_status_map; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE med_status_map (
    omop_concept_id integer,
    hqmf_status text
);


--
-- Name: overflow_vocabulary_map; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE overflow_vocabulary_map (
    overflow_vocabulary_name text NOT NULL,
    hqmf_code_system_oid text NOT NULL,
    hqmf_code_system_name text NOT NULL,
    hqmf_code_system_versions text[]
);


--
-- Name: TABLE overflow_vocabulary_map; Type: COMMENT; Schema: valuesets; Owner: -
--

COMMENT ON TABLE overflow_vocabulary_map IS 'Some codes that appear in value sets do not have corresponding OMOP concept IDs. This table defines vocabularies to use when creating new concept IDs for those codes.';


--
-- Name: COLUMN overflow_vocabulary_map.overflow_vocabulary_name; Type: COMMENT; Schema: valuesets; Owner: -
--

COMMENT ON COLUMN overflow_vocabulary_map.overflow_vocabulary_name IS 'Name of overflow vocabulary';


--
-- Name: COLUMN overflow_vocabulary_map.hqmf_code_system_oid; Type: COMMENT; Schema: valuesets; Owner: -
--

COMMENT ON COLUMN overflow_vocabulary_map.hqmf_code_system_oid IS 'Vocabulary OID (corresponds to value_set_entries.code_system)';


--
-- Name: COLUMN overflow_vocabulary_map.hqmf_code_system_name; Type: COMMENT; Schema: valuesets; Owner: -
--

COMMENT ON COLUMN overflow_vocabulary_map.hqmf_code_system_name IS 'Vocabulary name (from HQMF, for display only)';


--
-- Name: COLUMN overflow_vocabulary_map.hqmf_code_system_versions; Type: COMMENT; Schema: valuesets; Owner: -
--

COMMENT ON COLUMN overflow_vocabulary_map.hqmf_code_system_versions IS 'Vocabulary versions (from HQMF)';


--
-- Name: overflow_vocabulary_sequence; Type: SEQUENCE; Schema: valuesets; Owner: -
--

CREATE SEQUENCE overflow_vocabulary_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: unified_vocabulary_map; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE unified_vocabulary_map (
    hqmf_code_system_oid text,
    hqmf_code_system_name text,
    hqmf_code_system_versions text[],
    omop_vocabulary_id integer,
    vocabulary_name text,
    is_overflow_vocabulary boolean
);


--
-- Name: value_set_entries; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE value_set_entries (
    value_set_entry_id integer NOT NULL,
    value_set_oid text NOT NULL,
    code text NOT NULL,
    code_system text NOT NULL,
    code_system_name text NOT NULL,
    code_system_version text,
    display_name text,
    black_list text,
    white_list text
);


--
-- Name: TABLE value_set_entries; Type: COMMENT; Schema: valuesets; Owner: -
--

COMMENT ON TABLE value_set_entries IS 'Value set entries (from standard value set definitions)';


--
-- Name: unique_code_systems; Type: VIEW; Schema: valuesets; Owner: -
--

CREATE VIEW unique_code_systems AS
 SELECT DISTINCT value_set_entries.code_system,
    value_set_entries.code_system_name,
    value_set_entries.code_system_version
   FROM value_set_entries;


--
-- Name: value_code_xref; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE value_code_xref (
    code text,
    code_system text,
    code_system_name text,
    display_name text,
    concept_id integer,
    concept_name text
);


--
-- Name: value_set_code_systems; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE value_set_code_systems (
    value_set_oid text NOT NULL,
    code_system text NOT NULL,
    code_system_name text
);


--
-- Name: value_set_code_xref; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE value_set_code_xref (
    value_set_name text,
    value_set_oid text,
    code_system text,
    code text,
    code_system_name text,
    display_name text,
    concept_id integer,
    concept_name text
);


--
-- Name: value_set_entries_value_set_entry_id_seq; Type: SEQUENCE; Schema: valuesets; Owner: -
--

CREATE SEQUENCE value_set_entries_value_set_entry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: value_set_entries_value_set_entry_id_seq; Type: SEQUENCE OWNED BY; Schema: valuesets; Owner: -
--

ALTER SEQUENCE value_set_entries_value_set_entry_id_seq OWNED BY value_set_entries.value_set_entry_id;


--
-- Name: value_set_sanity_checks; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE value_set_sanity_checks (
    test_name text,
    passed boolean
);


--
-- Name: value_sets; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE value_sets (
    value_set_oid text NOT NULL,
    value_set_name text NOT NULL,
    value_set_version text NOT NULL
);


--
-- Name: TABLE value_sets; Type: COMMENT; Schema: valuesets; Owner: -
--

COMMENT ON TABLE value_sets IS 'Value set names (from standard value set definitions)';


--
-- Name: vocabulary_map; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE vocabulary_map (
    hqmf_code_system_oid text NOT NULL,
    hqmf_code_system_name text NOT NULL,
    hqmf_code_system_version text,
    omop_vocabulary_id integer
);


--
-- Name: TABLE vocabulary_map; Type: COMMENT; Schema: valuesets; Owner: -
--

COMMENT ON TABLE vocabulary_map IS 'Mapping of NLM value set OIDs to OMOP vocabulary IDs';


--
-- Name: COLUMN vocabulary_map.hqmf_code_system_oid; Type: COMMENT; Schema: valuesets; Owner: -
--

COMMENT ON COLUMN vocabulary_map.hqmf_code_system_oid IS 'Code system OID; corresponds to the code_system column of value_set_entries';


--
-- Name: COLUMN vocabulary_map.hqmf_code_system_name; Type: COMMENT; Schema: valuesets; Owner: -
--

COMMENT ON COLUMN vocabulary_map.hqmf_code_system_name IS 'Code system name; used for display purposes only';


--
-- Name: COLUMN vocabulary_map.omop_vocabulary_id; Type: COMMENT; Schema: valuesets; Owner: -
--

COMMENT ON COLUMN vocabulary_map.omop_vocabulary_id IS 'OMOP vocabulary id';


--
-- Name: value_set_entry_id; Type: DEFAULT; Schema: valuesets; Owner: -
--

ALTER TABLE ONLY value_set_entries ALTER COLUMN value_set_entry_id SET DEFAULT nextval('value_set_entries_value_set_entry_id_seq'::regclass);


SET search_path = hqmf_cypress_ep, pg_catalog;

--
-- Data for Name: diagnosis_active; Type: TABLE DATA; Schema: hqmf_cypress_ep; Owner: -
--

COPY diagnosis_active (patient_id, start_dt, end_dt, code, status, negation, value, audit_key_type, audit_key_value, severity, ordinal) FROM stdin;
0	2012-10-01 16:30:00	\N	4031328	completed	\N	4031328	event	28	\N	\N
0	2012-10-01 16:30:00	\N	4031328	completed	\N	4031328	event	15	\N	\N
0	2012-10-01 16:30:00	\N	4031328	completed	\N	4031328	event	11	\N	\N
0	2012-10-01 16:30:00	\N	4031328	completed	\N	4031328	event	18	\N	\N
0	2012-10-01 16:30:00	\N	4031328	completed	\N	4031328	event	8	\N	\N
1	2013-03-01 17:00:00	\N	4008081	completed	\N	4008081	event	333	\N	\N
2	2013-03-01 15:00:00	2013-10-20 16:00:00	4034087	completed	\N	4034087	event	813	\N	\N
2	2013-03-01 15:00:00	2013-10-20 16:00:00	4034087	completed	\N	4034087	event	798	\N	\N
2	2013-03-01 15:00:00	2013-10-20 16:00:00	4034087	completed	\N	4034087	event	805	\N	\N
2	2013-03-01 15:00:00	2013-10-20 16:00:00	4034087	completed	\N	4034087	event	790	\N	\N
2	2013-10-20 15:00:00	2013-10-20 16:00:00	4128030	completed	\N	4128030	event	794	\N	\N
3	2013-11-01 16:00:00	\N	433753	completed	\N	433753	event	1131	\N	\N
3	2013-11-01 16:00:00	\N	433753	completed	\N	433753	event	1150	\N	\N
3	2013-10-01 16:05:00	\N	4031328	completed	\N	4031328	event	1133	\N	\N
3	2013-10-01 16:05:00	\N	4031328	completed	\N	4031328	event	1147	\N	\N
3	2013-10-01 16:05:00	\N	4031328	completed	\N	4031328	event	1129	\N	\N
3	2013-10-01 16:05:00	\N	4031328	completed	\N	4031328	event	1119	\N	\N
3	2013-10-01 16:05:00	\N	4031328	completed	\N	4031328	event	1122	\N	\N
4	2013-01-04 17:00:00	\N	4008573	completed	\N	4008573	event	1172	\N	\N
4	2013-01-04 17:00:00	\N	4105172	completed	\N	4105172	event	1162	\N	\N
4	2013-01-04 17:00:00	\N	1002043696	completed	\N	1002043696	event	1168	\N	\N
5	2013-05-01 07:38:15	\N	4143828	completed	\N	4143828	event	1187	\N	\N
5	2013-05-01 07:38:15	\N	4143828	completed	\N	4143828	event	1183	\N	\N
6	2013-02-01 15:00:00	\N	4004279	completed	\N	4004279	event	1220	\N	\N
6	2013-02-01 16:00:00	\N	4277444	completed	\N	4277444	event	1239	\N	\N
6	2013-02-01 16:00:00	\N	4277444	completed	\N	4277444	event	1209	\N	\N
7	2013-03-26 16:00:00	\N	79740	completed	\N	79740	event	1295	\N	\N
7	2013-03-26 16:00:00	\N	79740	completed	\N	79740	event	1280	\N	\N
7	2013-03-26 16:00:00	\N	79740	completed	\N	79740	event	1291	\N	\N
7	2013-03-26 16:00:00	\N	4116087	completed	\N	4116087	event	1285	\N	\N
7	2013-03-26 16:00:00	\N	4116087	completed	\N	4116087	event	1297	\N	\N
8	2013-03-01 17:00:00	\N	4004279	completed	\N	4004279	event	1323	\N	\N
8	2013-03-01 17:30:00	\N	4028741	completed	\N	4028741	event	1353	\N	\N
8	2013-03-01 17:30:00	\N	4028741	completed	\N	4028741	event	1333	\N	\N
8	2013-03-01 17:05:00	\N	4119613	completed	\N	4119613	event	1344	\N	\N
8	2013-03-01 17:05:00	\N	4119613	completed	\N	4119613	event	1335	\N	\N
8	2013-03-01 17:05:00	\N	4119613	completed	\N	4119613	event	1319	\N	\N
8	2013-03-01 17:05:00	\N	4155962	completed	\N	4155962	event	1337	\N	\N
8	2013-03-01 17:05:00	\N	4155962	completed	\N	4155962	event	1346	\N	\N
8	2013-03-01 17:05:00	\N	4155962	completed	\N	4155962	event	1321	\N	\N
8	2013-03-01 17:05:00	\N	1002042273	completed	\N	1002042273	event	1325	\N	\N
9	2013-04-30 16:00:00	\N	441267	completed	\N	441267	event	1393	\N	\N
9	2013-04-30 15:30:00	\N	4129023	completed	\N	4129023	event	1403	\N	\N
9	2013-04-30 15:30:00	\N	4129023	completed	\N	4129023	event	1417	\N	\N
9	2013-04-30 15:30:00	\N	4129023	completed	\N	4129023	event	1395	\N	\N
9	2013-04-30 15:30:00	\N	4129023	completed	\N	4129023	event	1383	\N	\N
9	2013-04-30 15:30:00	\N	4145356	completed	\N	4145356	event	1385	\N	\N
9	2013-04-30 15:30:00	\N	4145356	completed	\N	4145356	event	1391	\N	\N
10	2013-01-05 21:48:14	\N	4008573	completed	\N	4008573	event	47	\N	\N
10	2013-01-05 21:48:14	\N	4105172	completed	\N	4105172	event	37	\N	\N
10	2013-01-05 21:48:14	\N	1002043696	completed	\N	1002043696	event	43	\N	\N
11	2012-02-01 17:00:00	\N	201254	completed	\N	201254	event	82	\N	\N
11	2012-02-01 17:00:00	\N	201254	completed	\N	201254	event	66	\N	\N
13	2013-01-30 17:30:00	2013-03-30 16:30:00	4049623	completed	\N	4049623	event	134	\N	\N
13	2013-01-30 17:30:00	2013-03-30 16:30:00	4049623	completed	\N	4049623	event	146	\N	\N
13	2013-01-30 17:30:00	2013-03-30 16:30:00	4049623	completed	\N	4049623	event	127	\N	\N
13	2013-01-30 17:30:00	2013-03-30 16:30:00	4049623	completed	\N	4049623	event	120	\N	\N
13	2013-04-30 16:05:00	\N	4143828	completed	\N	4143828	event	122	\N	\N
13	2013-04-30 16:05:00	\N	4143828	completed	\N	4143828	event	116	\N	\N
13	2013-01-30 17:30:00	2013-03-30 16:30:00	1002008953	completed	\N	1002008953	event	131	\N	\N
14	2013-04-30 16:05:00	\N	4143828	completed	\N	4143828	event	160	\N	\N
14	2013-04-30 16:05:00	\N	4143828	completed	\N	4143828	event	164	\N	\N
15	2013-04-01 14:00:00	\N	192279	completed	\N	192279	event	197	\N	\N
15	2013-04-01 14:00:00	\N	192279	completed	\N	192279	event	188	\N	\N
15	2011-04-01 14:00:00	\N	201254	completed	\N	201254	event	195	\N	\N
15	2011-04-01 14:00:00	\N	201254	completed	\N	201254	event	184	\N	\N
15	2013-04-01 14:00:00	\N	1002019733	completed	\N	1002019733	event	186	\N	\N
16	2013-02-26 15:00:00	\N	201254	completed	\N	201254	event	214	\N	\N
16	2013-02-26 15:00:00	\N	201254	completed	\N	201254	event	221	\N	\N
17	2013-03-02 14:30:00	\N	4091464	completed	\N	4091464	event	237	\N	\N
17	2013-03-02 14:30:00	\N	4091464	completed	\N	4091464	event	244	\N	\N
17	2013-03-02 14:45:00	\N	4167696	completed	\N	4167696	event	239	\N	\N
18	2013-03-02 14:30:00	\N	4091464	completed	\N	4091464	event	269	\N	\N
18	2013-03-02 14:30:00	\N	4091464	completed	\N	4091464	event	275	\N	\N
18	2013-03-02 14:45:00	\N	4167696	completed	\N	4167696	event	271	\N	\N
19	2013-10-01 16:05:00	\N	433753	completed	\N	433753	event	316	\N	\N
19	2013-10-01 16:05:00	\N	433753	completed	\N	433753	event	305	\N	\N
19	2013-10-01 16:05:00	\N	4031328	completed	\N	4031328	event	297	\N	\N
19	2013-10-01 16:05:00	\N	4031328	completed	\N	4031328	event	307	\N	\N
19	2013-10-01 16:05:00	\N	4031328	completed	\N	4031328	event	313	\N	\N
19	2013-10-01 16:05:00	\N	4031328	completed	\N	4031328	event	303	\N	\N
19	2013-10-01 16:05:00	\N	4031328	completed	\N	4031328	event	295	\N	\N
20	2013-03-26 14:00:00	\N	4011931	completed	\N	4011931	event	383	\N	\N
20	2013-03-26 14:00:00	\N	4059945	completed	\N	4059945	event	375	\N	\N
20	2013-03-26 14:00:00	\N	1002005079	completed	\N	1002005079	event	377	\N	\N
20	2013-03-26 14:00:00	\N	1002037384	completed	\N	1002037384	event	370	\N	\N
21	2013-02-01 15:00:00	2013-02-01 16:00:00	4128030	completed	\N	4128030	event	401	\N	\N
24	2013-03-01 17:00:00	\N	4004279	completed	\N	4004279	event	541	\N	\N
24	2013-03-01 17:05:00	\N	4028741	completed	\N	4028741	event	571	\N	\N
24	2013-03-01 17:05:00	\N	4028741	completed	\N	4028741	event	550	\N	\N
24	2013-03-01 17:05:00	\N	4119613	completed	\N	4119613	event	564	\N	\N
24	2013-03-01 17:05:00	\N	4119613	completed	\N	4119613	event	552	\N	\N
24	2013-03-01 17:05:00	\N	4119613	completed	\N	4119613	event	537	\N	\N
24	2013-03-01 17:05:00	\N	4155962	completed	\N	4155962	event	539	\N	\N
24	2013-03-01 17:05:00	\N	4155962	completed	\N	4155962	event	566	\N	\N
24	2013-03-01 17:05:00	\N	4155962	completed	\N	4155962	event	554	\N	\N
24	2013-03-01 17:05:00	\N	1002042273	completed	\N	1002042273	event	543	\N	\N
25	2002-02-03 14:00:00	\N	4008081	completed	\N	4008081	event	599	\N	\N
25	2013-05-03 15:00:00	2013-05-03 16:00:00	4033969	completed	\N	4033969	event	606	\N	\N
26	2013-01-29 15:00:00	\N	4004279	completed	\N	4004279	event	623	\N	\N
26	2013-01-29 16:00:00	\N	4277444	completed	\N	4277444	event	635	\N	\N
26	2013-01-29 16:00:00	\N	4277444	completed	\N	4277444	event	617	\N	\N
27	2012-02-01 15:00:00	\N	201254	completed	\N	201254	event	688	\N	\N
27	2012-02-01 15:00:00	\N	201254	completed	\N	201254	event	674	\N	\N
28	2012-01-31 07:28:46	\N	201254	completed	\N	201254	event	718	\N	\N
28	2012-01-31 07:28:46	\N	201254	completed	\N	201254	event	732	\N	\N
29	2013-03-01 03:49:50	2013-10-20 04:49:50	4034087	completed	\N	4034087	event	754	\N	\N
29	2013-03-01 03:49:50	2013-10-20 04:49:50	4034087	completed	\N	4034087	event	762	\N	\N
29	2013-03-01 03:49:50	2013-10-20 04:49:50	4034087	completed	\N	4034087	event	777	\N	\N
29	2013-03-01 03:49:50	2013-10-20 04:49:50	4034087	completed	\N	4034087	event	769	\N	\N
29	2013-10-20 03:49:50	2013-10-20 04:49:50	4128030	completed	\N	4128030	event	758	\N	\N
30	2013-03-09 21:49:18	\N	4091464	completed	\N	4091464	event	830	\N	\N
30	2013-03-09 21:49:18	\N	4091464	completed	\N	4091464	event	836	\N	\N
30	2013-03-09 22:04:18	\N	4167696	completed	\N	4167696	event	832	\N	\N
33	2013-03-01 16:00:00	\N	133419	completed	\N	133419	event	888	\N	\N
33	2013-03-01 15:00:00	\N	4031328	completed	\N	4031328	event	896	\N	\N
33	2013-03-01 15:00:00	\N	4031328	completed	\N	4031328	event	894	\N	\N
33	2013-03-01 15:00:00	\N	4031328	completed	\N	4031328	event	890	\N	\N
33	2013-03-01 15:00:00	\N	4031328	completed	\N	4031328	event	884	\N	\N
33	2013-03-01 15:00:00	\N	4031328	completed	\N	4031328	event	906	\N	\N
33	2013-03-01 16:00:00	\N	4036795	completed	\N	4036795	event	909	\N	\N
33	2013-03-01 15:30:00	\N	4059945	completed	\N	4059945	event	886	\N	\N
33	2013-03-01 15:30:00	\N	1002037384	completed	\N	1002037384	event	880	\N	\N
34	2013-03-30 15:00:00	\N	4011931	completed	\N	4011931	event	937	\N	\N
34	2013-03-30 14:30:00	\N	4059945	completed	\N	4059945	event	928	\N	\N
34	2013-03-30 15:00:00	\N	1002005079	completed	\N	1002005079	event	931	\N	\N
34	2013-03-30 14:30:00	\N	1002037384	completed	\N	1002037384	event	921	\N	\N
35	2013-01-04 17:30:00	\N	4008573	completed	\N	4008573	event	968	\N	\N
35	2013-01-04 17:10:00	\N	4105172	completed	\N	4105172	event	961	\N	\N
35	2013-01-04 17:10:00	\N	1002043696	completed	\N	1002043696	event	964	\N	\N
36	2013-02-02 17:30:00	\N	4031328	completed	\N	4031328	event	979	\N	\N
36	2013-02-02 17:30:00	\N	4031328	completed	\N	4031328	event	981	\N	\N
36	2013-02-02 17:30:00	\N	4031328	completed	\N	4031328	event	986	\N	\N
36	2013-02-02 17:30:00	\N	4031328	completed	\N	4031328	event	988	\N	\N
36	2013-02-02 17:30:00	\N	4031328	completed	\N	4031328	event	998	\N	\N
37	2013-03-26 16:00:00	\N	79740	completed	\N	79740	event	1033	\N	\N
37	2013-03-26 16:00:00	\N	79740	completed	\N	79740	event	1027	\N	\N
37	2013-03-26 16:00:00	\N	79740	completed	\N	79740	event	1017	\N	\N
37	2013-03-26 16:00:00	\N	4116087	completed	\N	4116087	event	1031	\N	\N
37	2013-03-26 16:00:00	\N	4116087	completed	\N	4116087	event	1020	\N	\N
38	2013-03-01 17:05:00	\N	133419	completed	\N	133419	event	1061	\N	\N
38	2013-03-01 17:05:00	\N	4004279	completed	\N	4004279	event	1055	\N	\N
38	2013-07-01 14:00:00	\N	4028741	completed	\N	4028741	event	1059	\N	\N
38	2013-07-01 14:00:00	\N	4028741	completed	\N	4028741	event	1067	\N	\N
39	2013-03-01 16:30:00	\N	4008081	completed	\N	4008081	event	1088	\N	\N
\.


--
-- Data for Name: generic_hqmf_event; Type: TABLE DATA; Schema: hqmf_cypress_ep; Owner: -
--

COPY generic_hqmf_event (event_id, patient_id, start_dt, end_dt, code, status, negation, value, event_type, status_code, template_ids, value_codesystem, value_code, discharge_status, route_concept_id, target_site_concept_id, priority_concept_id, audit_key_type, audit_key_value) FROM stdin;
4	0	2012-10-01 16:00:00	2012-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	4
3	0	2013-06-17 16:00:00	2013-06-17 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	3
2	0	2012-10-01 16:00:00	2012-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	2
1	0	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	1
33	0	2013-06-17 16:00:00	2013-06-17 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	33
32	0	2012-10-01 16:00:00	2012-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	32
31	0	2013-06-17 16:00:00	2013-06-17 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	31
30	0	2012-10-01 16:00:00	2012-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	30
29	0	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	29
28	0	2012-10-01 16:30:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	28
27	0	2013-06-17 16:00:00	2013-06-17 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	27
26	0	2012-10-01 16:00:00	2012-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	26
25	0	2013-06-17 16:00:00	2013-06-17 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	25
24	0	2012-10-01 16:00:00	2012-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	24
23	0	2013-06-17 16:00:00	2013-06-17 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	23
22	0	2012-10-01 16:00:00	2012-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	22
21	0	2013-06-17 16:00:00	2013-06-17 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	21
20	0	2012-10-01 16:00:00	2012-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	20
19	0	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	19
18	0	2012-10-01 16:30:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	18
17	0	2012-10-01 16:00:00	2012-10-01 16:00:00	40224915	completed	\N	\N	supply	completed	{2.16.840.1.113883.10.20.24.3.45,2.16.840.1.113883.10.20.22.4.18}	\N	\N	\N	\N	\N	\N	event	17
16	0	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	16
15	0	2012-10-01 16:30:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	15
14	0	2013-06-17 16:00:00	2013-06-17 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	14
13	0	2012-10-01 16:00:00	2012-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	13
12	0	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	12
11	0	2012-10-01 16:30:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	11
10	0	2012-10-01 16:30:00	2012-10-01 16:30:00	3044486	completed	\N	10	observation	completed	{2.16.840.1.113883.10.20.22.4.69,2.16.840.1.113883.10.20.24.3.69}	\N	\N	\N	\N	\N	\N	event	10
9	0	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	9
8	0	2012-10-01 16:30:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	8
7	0	2013-06-17 16:00:00	2013-06-17 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	7
6	0	2012-10-01 16:00:00	2012-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	6
5	0	2013-06-17 16:00:00	2013-06-17 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	5
347	1	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	347
346	1	2013-09-01 15:00:00	2013-09-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	346
345	1	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	345
344	1	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	344
343	1	2013-09-01 15:00:00	2013-09-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	343
342	1	2013-07-01 15:00:00	2013-07-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	342
341	1	2013-03-01 16:00:00	2013-03-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	341
340	1	2013-09-01 15:00:00	2013-09-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	340
339	1	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	339
338	1	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	338
337	1	2013-09-01 15:00:00	2013-09-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	337
335	1	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	335
336	1	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	336
351	1	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	351
352	1	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	352
353	1	2013-09-01 15:00:00	2013-09-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	353
354	1	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	354
355	1	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	355
356	1	2013-09-01 15:00:00	2013-09-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	356
357	1	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	357
358	1	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	358
359	1	2013-09-01 15:00:00	2013-09-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	359
360	1	2013-07-01 15:00:00	2013-07-01 15:00:00	3028167	completed	\N	150	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	360
361	1	2013-09-01 15:00:00	2013-09-01 15:00:00	1836449	new	\N	\N	substanceAdministration	new	{2.16.840.1.113883.10.20.22.4.42,2.16.840.1.113883.10.20.24.3.47}	\N	\N	\N	\N	\N	\N	event	361
362	1	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	362
363	1	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	363
364	1	2013-09-01 15:00:00	2013-09-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	364
320	1	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	320
321	1	2013-03-01 16:00:00	2013-03-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	321
322	1	2013-07-01 15:00:00	2013-07-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	322
323	1	2013-09-01 15:00:00	2013-09-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	323
324	1	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	324
325	1	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	325
326	1	2013-09-01 15:00:00	2013-09-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	326
327	1	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	327
328	1	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	328
329	1	2013-09-01 15:00:00	2013-09-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	329
330	1	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	330
331	1	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	331
332	1	2013-09-01 15:00:00	2013-09-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	332
333	1	2013-03-01 17:00:00	\N	4107185	completed	\N	4008081	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	111880001	\N	\N	\N	\N	event	333
334	1	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	334
350	1	2013-07-01 15:00:00	2013-07-01 15:00:00	3013180	completed	\N	150	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	350
349	1	2013-09-01 15:00:00	2013-09-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	349
348	1	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	348
794	2	2013-10-20 15:00:00	2013-10-20 16:00:00	4107185	completed	\N	4128030	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	236973005	\N	\N	\N	\N	event	794
801	2	2013-10-20 15:00:00	2013-10-20 16:00:00	4128030	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	801
802	2	\N	\N	3016404	new	\N	\N	observation	new	{2.16.840.1.113883.10.20.22.4.44,2.16.840.1.113883.10.20.24.3.17}	\N	\N	\N	\N	\N	\N	event	802
803	2	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	803
804	2	2013-10-20 15:00:00	2013-10-20 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	804
805	2	2013-03-01 15:00:00	2013-10-20 16:00:00	4107185	completed	\N	4034087	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	237244005	\N	\N	\N	\N	event	805
806	2	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	806
807	2	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	807
808	2	2013-10-20 15:00:00	2013-10-20 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	808
809	2	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	809
810	2	2013-10-20 15:00:00	2013-10-20 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	810
811	2	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	811
812	2	2013-10-20 15:00:00	2013-10-20 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	812
813	2	2013-03-01 15:00:00	2013-10-20 16:00:00	4107185	completed	\N	4034087	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	237244005	\N	\N	\N	\N	event	813
814	2	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	814
815	2	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	815
816	2	2013-10-20 15:00:00	2013-10-20 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	816
817	2	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	817
818	2	2013-10-20 15:00:00	2013-10-20 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	818
819	2	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	819
820	2	2013-10-20 15:00:00	2013-10-20 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	820
786	2	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	786
787	2	2013-10-20 15:00:00	2013-10-20 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	787
788	2	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	788
789	2	2013-10-20 15:00:00	2013-10-20 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	789
790	2	2013-03-01 15:00:00	2013-10-20 16:00:00	4107185	completed	\N	4034087	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	237244005	\N	\N	\N	\N	event	790
791	2	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	791
792	2	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	792
793	2	2013-10-20 15:00:00	2013-10-20 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	793
795	2	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	795
796	2	2013-10-20 15:00:00	2013-10-20 16:00:00	4128030	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	796
797	2	2013-03-01 16:00:00	2013-03-01 16:00:00	3027898	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.38}	\N	\N	\N	\N	\N	\N	event	797
798	2	2013-03-01 15:00:00	2013-10-20 16:00:00	4107185	completed	\N	4034087	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	237244005	\N	\N	\N	\N	event	798
799	2	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	799
800	2	\N	\N	3018171	new	\N	\N	observation	new	{2.16.840.1.113883.10.20.22.4.44,2.16.840.1.113883.10.20.24.3.37}	\N	\N	\N	\N	\N	\N	event	800
785	2	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	785
1124	3	2012-11-01 16:00:00	2012-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1124
1125	3	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1125
1126	3	2013-11-01 16:00:00	2013-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1126
1127	3	2013-10-01 17:00:00	2013-10-01 17:00:00	40224915	new	\N	\N	substanceAdministration	new	{2.16.840.1.113883.10.20.22.4.42,2.16.840.1.113883.10.20.24.3.47}	\N	\N	\N	\N	\N	\N	event	1127
1150	3	2013-11-01 16:00:00	\N	4107185	completed	\N	433753	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	15167005	\N	\N	\N	\N	event	1150
1149	3	2013-10-01 17:00:00	2013-10-01 17:00:00	40224915	new	\N	\N	substanceAdministration	new	{2.16.840.1.113883.10.20.22.4.42,2.16.840.1.113883.10.20.24.3.47}	\N	\N	\N	\N	\N	\N	event	1149
1148	3	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1148
1147	3	2013-10-01 16:05:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	1147
1146	3	2013-11-01 16:00:00	2013-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1146
1145	3	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1145
1136	3	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1136
1137	3	2013-11-01 16:00:00	2013-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1137
1138	3	2012-11-01 16:00:00	2012-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1138
1139	3	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1139
1140	3	2013-11-01 16:00:00	2013-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1140
1141	3	2012-11-01 16:00:00	2012-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1141
1142	3	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1142
1143	3	2013-11-01 16:00:00	2013-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1143
1144	3	2012-11-01 16:00:00	2012-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1144
1128	3	2013-10-01 16:05:00	2013-10-01 16:05:00	4022517	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	1128
1129	3	2013-10-01 16:05:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	1129
1130	3	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1130
1131	3	2013-11-01 16:00:00	\N	4107185	completed	\N	433753	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	15167005	\N	\N	\N	\N	event	1131
1132	3	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1132
1133	3	2013-10-01 16:05:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	1133
1134	3	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1134
1135	3	2012-11-01 16:00:00	2012-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1135
1151	3	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1151
1152	3	2013-11-01 16:45:00	2013-11-01 17:00:00	4062627	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1152
1153	3	2012-11-01 16:00:00	2012-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1153
1154	3	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1154
1155	3	2013-11-01 16:00:00	2013-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1155
1156	3	2012-11-01 16:00:00	2012-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1156
1157	3	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1157
1158	3	2013-11-01 16:00:00	2013-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1158
1110	3	2012-11-01 16:00:00	2012-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1110
1109	3	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	1109
1111	3	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1111
1112	3	2013-11-01 16:00:00	2013-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1112
1113	3	2012-11-01 16:00:00	2012-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1113
1114	3	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1114
1115	3	2013-11-01 16:00:00	2013-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1115
1116	3	2012-11-01 16:00:00	2012-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1116
1117	3	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1117
1118	3	2013-11-01 16:00:00	2013-11-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1118
1119	3	2013-10-01 16:05:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	1119
1120	3	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1120
1121	3	2013-11-01 16:30:00	2013-11-01 16:30:00	3044486	completed	\N	3044486	observation	completed	{2.16.840.1.113883.10.20.22.4.69,2.16.840.1.113883.10.20.24.3.69}	2.16.840.1.113883.6.1	44249-1	\N	\N	\N	\N	event	1121
1122	3	2013-10-01 16:05:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	1122
1123	3	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1123
1160	4	2013-01-04 17:00:00	2013-01-04 18:00:00	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1160
1159	4	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	1159
1161	4	2013-02-02 17:00:00	2013-02-02 18:00:00	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1161
1162	4	2013-01-04 17:00:00	\N	4107185	completed	\N	4105172	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	193349004	\N	\N	\N	\N	event	1162
1163	4	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1163
1164	4	2013-01-04 17:05:00	2013-01-04 17:05:00	3033643	completed	\N	1002011642	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.20}	2.16.840.1.113883.6.96	428341000124108	\N	\N	\N	\N	event	1164
1165	4	2013-01-04 17:05:00	2013-01-04 17:05:00	3033643	completed	\N	378743	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.20}	2.16.840.1.113883.6.96	312903003	\N	\N	\N	\N	event	1165
1166	4	2013-01-04 17:45:00	2013-01-04 18:00:00	378743	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.4}	\N	\N	\N	\N	\N	\N	event	1166
1167	4	2013-01-04 17:45:00	2013-01-04 18:00:00	1002011642	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.4}	\N	\N	\N	\N	\N	\N	event	1167
1168	4	2013-01-04 17:00:00	\N	4107185	completed	\N	1002043696	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.103	362.01	\N	\N	\N	\N	event	1168
1169	4	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1169
1170	4	2013-01-04 17:00:00	2013-01-04 18:00:00	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1170
1171	4	2013-02-02 17:00:00	2013-02-02 18:00:00	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1171
1172	4	2013-01-04 17:00:00	\N	4107185	completed	\N	4008573	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	111513000	\N	\N	\N	\N	event	1172
1173	4	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1173
1174	4	2013-01-04 17:00:00	2013-01-04 17:00:00	42870423	completed	\N	0.8	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.20}	\N	\N	\N	\N	\N	\N	event	1174
1175	4	2013-01-04 17:00:00	2013-01-04 17:00:00	42870425	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.20}	2.16.840.1.113883.5.4	Unmapped text result	\N	\N	\N	\N	event	1175
1176	4	2013-01-04 17:00:00	2013-01-04 18:00:00	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1176
1177	4	2013-02-02 17:00:00	2013-02-02 18:00:00	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1177
1183	5	2013-05-01 07:38:15	\N	4107185	completed	\N	4143828	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	426979002	\N	\N	\N	\N	event	1183
1182	5	2013-05-01 07:33:15	2013-05-01 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1182
1181	5	2013-01-31 07:33:15	2013-01-31 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1181
1180	5	2013-05-01 07:33:15	2013-05-01 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1180
1179	5	2013-01-31 07:33:15	2013-01-31 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1179
1178	5	2008-01-01 20:33:15	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	1178
1188	5	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1188
1189	5	\N	\N	3025378	new	\N	\N	observation	new	{2.16.840.1.113883.10.20.22.4.44,2.16.840.1.113883.10.20.24.3.37}	\N	\N	\N	\N	\N	\N	event	1189
1190	5	2013-01-31 07:33:15	2013-01-31 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1190
1191	5	2013-05-01 07:33:15	2013-05-01 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1191
1192	5	2013-01-31 07:33:15	2013-01-31 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1192
1193	5	2013-05-01 07:33:15	2013-05-01 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1193
1194	5	2013-01-31 07:33:15	2013-01-31 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1194
1195	5	2013-05-01 07:33:15	2013-05-01 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1195
1198	5	2013-01-31 07:33:15	2013-01-31 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1198
1196	5	2013-01-31 07:33:15	2013-01-31 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1196
1197	5	2013-05-01 07:33:15	2013-05-01 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1197
1203	5	2013-05-01 07:33:15	2013-05-01 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1203
1202	5	2013-01-31 07:33:15	2013-01-31 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1202
1201	5	2013-05-01 07:33:15	2013-05-01 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1201
1200	5	2013-01-31 07:33:15	2013-01-31 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1200
1199	5	2013-05-01 07:33:15	2013-05-01 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1199
1184	5	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1184
1185	5	2013-01-31 07:33:15	2013-01-31 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1185
1186	5	2013-05-01 07:33:15	2013-05-01 08:33:15	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1186
1187	5	2013-05-01 07:38:15	\N	4107185	completed	\N	4143828	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	426979002	\N	\N	\N	\N	event	1187
1218	6	2013-02-01 16:00:00	2013-02-01 16:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	1218
1266	6	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1266
1265	6	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1265
1264	6	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1264
1263	6	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1263
1262	6	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1262
1261	6	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1261
1260	6	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1260
1259	6	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1259
1258	6	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1258
1257	6	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1257
1256	6	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1256
1255	6	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1255
1254	6	2013-02-01 16:00:00	2013-02-01 16:00:00	1002033938	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	1254
1253	6	2013-02-01 16:00:00	2013-02-01 16:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	1253
1252	6	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1252
1251	6	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1251
1250	6	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1250
1249	6	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1249
1248	6	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1248
1247	6	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1247
1246	6	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1246
1245	6	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1245
1244	6	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1244
1243	6	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1243
1242	6	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1242
1241	6	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1241
1240	6	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1240
1239	6	2013-02-01 16:00:00	\N	4107185	completed	\N	4277444	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	6475002	\N	\N	\N	\N	event	1239
1238	6	2013-02-01 15:15:00	2013-02-01 15:30:00	42869857	completed	\N	80	observation	completed	{2.16.840.1.113883.10.20.22.4.67,2.16.840.1.113883.10.20.24.3.28}	\N	\N	\N	\N	\N	\N	event	1238
1237	6	2012-08-01 14:00:00	2012-08-01 15:00:00	42869857	completed	\N	40	observation	completed	{2.16.840.1.113883.10.20.22.4.67,2.16.840.1.113883.10.20.24.3.28}	\N	\N	\N	\N	\N	\N	event	1237
1236	6	2012-11-01 15:00:00	2012-11-01 16:00:00	4079266	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	1236
1235	6	2013-02-01 15:00:00	2013-02-01 15:15:00	42869852	completed	\N	80	observation	completed	{2.16.840.1.113883.10.20.22.4.67,2.16.840.1.113883.10.20.24.3.28}	\N	\N	\N	\N	\N	\N	event	1235
1234	6	2012-08-01 14:00:00	2012-08-01 15:00:00	42869852	completed	\N	35	observation	completed	{2.16.840.1.113883.10.20.22.4.67,2.16.840.1.113883.10.20.24.3.28}	\N	\N	\N	\N	\N	\N	event	1234
1233	6	2012-09-01 14:00:00	2012-09-01 15:00:00	4035487	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	1233
1232	6	2013-06-01 14:00:00	2013-06-01 14:00:00	42869695	completed	\N	35	observation	completed	{2.16.840.1.113883.10.20.22.4.67,2.16.840.1.113883.10.20.24.3.28}	\N	\N	\N	\N	\N	\N	event	1232
1231	6	2013-02-01 15:00:00	2013-02-01 15:00:00	42869695	completed	\N	30	observation	completed	{2.16.840.1.113883.10.20.22.4.67,2.16.840.1.113883.10.20.24.3.28}	\N	\N	\N	\N	\N	\N	event	1231
1230	6	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1230
1229	6	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1229
1228	6	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1228
1227	6	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1227
1226	6	2013-06-01 15:00:00	2013-06-01 15:00:00	40232448	new	\N	\N	substanceAdministration	new	{2.16.840.1.113883.10.20.22.4.42,2.16.840.1.113883.10.20.24.3.47}	\N	\N	\N	\N	\N	\N	event	1226
1225	6	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1225
1224	6	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1224
1223	6	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1223
1222	6	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1222
1221	6	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1221
1220	6	2013-02-01 15:00:00	\N	4107185	completed	\N	4004279	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	10091002	\N	\N	\N	\N	event	1220
1219	6	2013-02-01 16:00:00	2013-02-01 16:00:00	1002033938	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	1219
1217	6	2012-08-01 14:00:00	2012-08-01 15:00:00	40480729	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	1217
1216	6	2013-06-01 14:00:00	2013-06-01 15:00:00	40760373	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.22.4.69,2.16.840.1.113883.10.20.24.3.69}	\N	\N	\N	\N	\N	\N	event	1216
1215	6	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1215
1214	6	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1214
1213	6	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1213
1212	6	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1212
1211	6	2013-02-01 15:30:00	2013-02-01 15:30:00	40761252	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.22.4.69,2.16.840.1.113883.10.20.24.3.69}	2.16.840.1.113883.5.4	Unmapped text result	\N	\N	\N	\N	event	1211
1210	6	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1210
1209	6	2013-02-01 16:00:00	\N	4107185	completed	\N	4277444	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	6475002	\N	\N	\N	\N	event	1209
1208	6	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1208
1207	6	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1207
1206	6	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1206
1205	6	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1205
1204	6	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	1204
1267	7	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	1267
1268	7	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1268
1269	7	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1269
1270	7	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1270
1271	7	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1271
1272	7	2013-03-26 16:00:00	2013-03-26 16:30:00	4022145	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.22.4.14,2.16.840.1.113883.10.20.24.3.66}	\N	\N	\N	\N	\N	\N	event	1272
1273	7	2013-03-26 16:00:00	2013-03-26 16:00:00	4022145	completed	\N	1002012575	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.87}	2.16.840.1.113883.6.96	433581000124101	\N	\N	\N	\N	event	1273
1274	7	2013-03-26 16:00:00	2013-03-26 16:30:00	4022145	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.22.4.14,2.16.840.1.113883.10.20.24.3.66}	\N	\N	\N	\N	\N	\N	event	1274
1275	7	2013-03-26 16:00:00	2013-03-26 16:00:00	4022145	completed	\N	1002013539	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.87}	2.16.840.1.113883.6.96	433491000124102	\N	\N	\N	\N	event	1275
1276	7	2013-03-26 16:00:00	2013-03-26 16:30:00	4022145	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.22.4.14,2.16.840.1.113883.10.20.24.3.66}	\N	\N	\N	\N	\N	\N	event	1276
1277	7	2013-03-26 16:00:00	2013-03-26 16:00:00	4022145	completed	\N	1002026051	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.87}	2.16.840.1.113883.6.96	433571000124104	\N	\N	\N	\N	event	1277
1278	7	2013-03-26 16:00:00	2013-03-26 16:30:00	4022145	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.22.4.14,2.16.840.1.113883.10.20.24.3.66}	\N	\N	\N	\N	\N	\N	event	1278
1279	7	2013-03-26 16:00:00	2013-03-26 16:00:00	4022145	completed	\N	1002014003	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.87}	2.16.840.1.113883.6.96	433361000124104	\N	\N	\N	\N	event	1279
1280	7	2013-03-26 16:00:00	\N	4107185	completed	\N	79740	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	109838007	\N	\N	\N	\N	event	1280
1281	7	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1281
1282	7	2013-03-26 16:30:00	2013-03-26 16:30:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	1282
1283	7	2013-03-26 16:30:00	2013-03-26 16:30:00	19023529	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	1283
1284	7	2013-04-23 16:45:00	2013-04-23 17:00:00	4223087	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	1284
1285	7	2013-03-26 16:00:00	\N	4107185	completed	\N	4116087	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	254900004	\N	\N	\N	\N	event	1285
1286	7	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1286
1287	7	2013-04-23 16:30:00	2013-04-23 17:00:00	4020571	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	1287
1288	7	2013-04-23 16:45:00	2013-04-23 17:00:00	4223087	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	1288
1289	7	2013-03-26 16:00:00	2013-03-26 16:00:00	3032943	completed	\N	4	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	1289
1290	7	2013-03-26 15:30:00	2013-03-26 15:30:00	3007273	completed	\N	6	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	1290
1291	7	2013-03-26 16:00:00	\N	4107185	completed	\N	79740	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	109838007	\N	\N	\N	\N	event	1291
1292	7	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1292
1293	7	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1293
1294	7	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1294
1295	7	2013-03-26 16:00:00	\N	4107185	completed	\N	79740	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	109838007	\N	\N	\N	\N	event	1295
1296	7	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1296
1297	7	2013-03-26 16:00:00	\N	4107185	completed	\N	4116087	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	254900004	\N	\N	\N	\N	event	1297
1298	7	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1298
1299	7	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1299
1300	7	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1300
1301	7	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1301
1302	7	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1302
1303	7	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1303
1304	7	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1304
1305	7	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1305
1306	7	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1306
1307	7	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1307
1308	7	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1308
1309	7	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1309
1310	7	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1310
1311	7	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1311
1312	7	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1312
1313	8	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	1313
1314	8	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1314
1315	8	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1315
1316	8	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1316
1317	8	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1317
1318	8	2013-03-01 17:05:00	\N	1112892	active	\N	\N	substanceAdministration	active	{2.16.840.1.113883.10.20.22.4.16,2.16.840.1.113883.10.20.24.3.41}	\N	\N	\N	\N	\N	\N	event	1318
1319	8	2013-03-01 17:05:00	\N	4107185	completed	\N	4119613	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	233970002	\N	\N	\N	\N	event	1319
1320	8	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1320
1321	8	2013-03-01 17:05:00	\N	4107185	completed	\N	4155962	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	371804009	\N	\N	\N	\N	event	1321
1322	8	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1322
1323	8	2013-03-01 17:00:00	\N	4107185	completed	\N	4004279	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	10091002	\N	\N	\N	\N	event	1323
1324	8	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1324
1325	8	2013-03-01 17:05:00	\N	4107185	completed	\N	1002042273	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	981000124106	\N	\N	\N	\N	event	1325
1326	8	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1326
1327	8	2013-03-01 17:05:00	2013-03-01 17:05:00	1308251	new	\N	\N	substanceAdministration	new	{2.16.840.1.113883.10.20.22.4.42,2.16.840.1.113883.10.20.24.3.47}	\N	\N	\N	\N	\N	\N	event	1327
1328	8	2013-03-01 17:05:00	2013-03-01 17:05:00	19022749	new	\N	\N	substanceAdministration	new	{2.16.840.1.113883.10.20.22.4.42,2.16.840.1.113883.10.20.24.3.47}	\N	\N	\N	\N	\N	\N	event	1328
1329	8	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1329
1330	8	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1330
1331	8	2013-03-01 17:05:00	2013-03-01 17:05:00	3004249	completed	\N	150	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.57}	\N	\N	\N	\N	\N	\N	event	1331
1332	8	2013-12-20 17:05:00	2013-12-20 17:05:00	3004249	completed	\N	130	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.57}	\N	\N	\N	\N	\N	\N	event	1332
1333	8	2013-03-01 17:30:00	\N	4107185	completed	\N	4028741	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	10725009	\N	\N	\N	\N	event	1333
1334	8	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1334
1335	8	2013-03-01 17:05:00	\N	4107185	completed	\N	4119613	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	233970002	\N	\N	\N	\N	event	1335
1336	8	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1336
1337	8	2013-03-01 17:05:00	\N	4107185	completed	\N	4155962	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	371804009	\N	\N	\N	\N	event	1337
1338	8	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1338
1339	8	2013-03-01 17:05:00	2013-03-01 17:05:00	19022749	new	\N	\N	substanceAdministration	new	{2.16.840.1.113883.10.20.22.4.42,2.16.840.1.113883.10.20.24.3.47}	\N	\N	\N	\N	\N	\N	event	1339
1340	8	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1340
1341	8	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1341
1342	8	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1342
1343	8	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1343
1344	8	2013-03-01 17:05:00	\N	4107185	completed	\N	4119613	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	233970002	\N	\N	\N	\N	event	1344
1345	8	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1345
1346	8	2013-03-01 17:05:00	\N	4107185	completed	\N	4155962	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	371804009	\N	\N	\N	\N	event	1346
1347	8	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1347
1348	8	2013-03-01 17:05:00	2013-03-01 17:05:00	3028288	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.38}	\N	\N	\N	\N	\N	\N	event	1348
1349	8	2013-03-01 17:05:00	2013-03-01 17:05:00	3027114	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.38}	\N	\N	\N	\N	\N	\N	event	1349
1350	8	2013-03-01 17:05:00	2013-03-01 17:05:00	3007070	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.38}	\N	\N	\N	\N	\N	\N	event	1350
1351	8	2013-03-01 17:05:00	2013-03-01 17:05:00	3007943	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.38}	\N	\N	\N	\N	\N	\N	event	1351
1352	8	2013-03-01 17:05:00	2013-03-01 17:05:00	3007070	completed	\N	50	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	1352
1353	8	2013-03-01 17:30:00	\N	4107185	completed	\N	4028741	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	10725009	\N	\N	\N	\N	event	1353
1354	8	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1354
1355	8	2013-03-01 17:05:00	2013-03-01 17:05:00	3028288	completed	\N	80	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	1355
1356	8	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1356
1357	8	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1357
1358	8	2013-03-01 17:05:00	2013-03-01 17:05:00	3012888	completed	\N	60	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.57}	\N	\N	\N	\N	\N	\N	event	1358
1359	8	2013-12-20 17:05:00	2013-12-20 17:05:00	3012888	completed	\N	60	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.57}	\N	\N	\N	\N	\N	\N	event	1359
1360	8	2013-03-01 17:05:00	2013-03-01 17:05:00	1308251	new	\N	\N	substanceAdministration	new	{2.16.840.1.113883.10.20.22.4.42,2.16.840.1.113883.10.20.24.3.47}	\N	\N	\N	\N	\N	\N	event	1360
1361	8	2013-03-01 17:05:00	2013-03-01 17:05:00	19022749	new	\N	\N	substanceAdministration	new	{2.16.840.1.113883.10.20.22.4.42,2.16.840.1.113883.10.20.24.3.47}	\N	\N	\N	\N	\N	\N	event	1361
1362	8	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1362
1363	8	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1363
1364	8	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1364
1365	8	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1365
1366	8	2013-03-01 17:05:00	2013-03-01 17:05:00	3028288	completed	\N	80	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	1366
1367	8	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1367
1368	8	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1368
1369	8	2013-03-01 17:05:00	2013-03-01 17:05:00	3027114	completed	\N	157	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	1369
1370	8	2013-03-01 17:05:00	2013-03-01 17:05:00	3007070	completed	\N	50	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	1370
1371	8	2013-03-01 17:05:00	2013-03-01 17:05:00	3007943	completed	\N	90	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	1371
1372	8	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1372
1373	8	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1373
1430	9	2013-04-30 15:00:00	2013-04-30 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1430
1374	9	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	1374
1375	9	2012-12-05 17:00:00	2012-12-05 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1375
1376	9	2013-02-04 16:00:00	2013-02-04 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1376
1377	9	2013-04-15 16:00:00	2013-04-15 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1377
1378	9	2013-04-30 15:00:00	2013-04-30 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1378
1379	9	2012-12-05 17:00:00	2012-12-05 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1379
1380	9	2013-02-04 16:00:00	2013-02-04 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1380
1381	9	2013-04-15 16:00:00	2013-04-15 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1381
1382	9	2013-04-30 15:00:00	2013-04-30 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1382
1383	9	2013-04-30 15:30:00	\N	4107185	completed	\N	4129023	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	237240001	\N	\N	\N	\N	event	1383
1384	9	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1384
1385	9	2013-04-30 15:30:00	\N	4107185	completed	\N	4145356	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	426656000	\N	\N	\N	\N	event	1385
1386	9	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1386
1387	9	2012-12-05 17:00:00	2012-12-05 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1387
1388	9	2013-02-04 16:00:00	2013-02-04 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1388
1389	9	2013-04-15 16:00:00	2013-04-15 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1389
1390	9	2013-04-30 15:00:00	2013-04-30 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1390
1391	9	2013-04-30 15:30:00	\N	4107185	completed	\N	4145356	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	426656000	\N	\N	\N	\N	event	1391
1392	9	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1392
1393	9	2013-04-30 16:00:00	\N	4107185	completed	\N	441267	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	190905008	\N	\N	\N	\N	event	1393
1394	9	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1394
1395	9	2013-04-30 15:30:00	\N	4107185	completed	\N	4129023	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	237240001	\N	\N	\N	\N	event	1395
1396	9	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1396
1397	9	2012-12-05 17:00:00	2012-12-05 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1397
1398	9	2013-02-04 16:00:00	2013-02-04 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1398
1399	9	2013-04-15 16:00:00	2013-04-15 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1399
1400	9	2013-04-30 15:00:00	2013-04-30 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1400
1401	9	2013-02-04 17:00:00	2013-02-04 17:00:00	40224110	completed	\N	\N	supply	completed	{2.16.840.1.113883.10.20.24.3.45,2.16.840.1.113883.10.20.22.4.18}	\N	\N	\N	\N	\N	\N	event	1401
1402	9	2012-12-05 17:00:00	\N	40224110	active	\N	\N	substanceAdministration	active	{2.16.840.1.113883.10.20.22.4.16,2.16.840.1.113883.10.20.24.3.41}	\N	\N	\N	\N	\N	\N	event	1402
1403	9	2013-04-30 15:30:00	\N	4107185	completed	\N	4129023	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	237240001	\N	\N	\N	\N	event	1403
1404	9	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1404
1405	9	2012-12-05 17:00:00	2012-12-05 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1405
1406	9	2013-02-04 16:00:00	2013-02-04 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1406
1407	9	2013-04-15 16:00:00	2013-04-15 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1407
1408	9	2013-04-30 15:00:00	2013-04-30 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1408
1409	9	2012-12-05 17:00:00	2012-12-05 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1409
1410	9	2013-02-04 16:00:00	2013-02-04 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1410
1411	9	2013-04-15 16:00:00	2013-04-15 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1411
1412	9	2013-04-30 15:00:00	2013-04-30 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1412
1413	9	2012-12-05 17:00:00	2012-12-05 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1413
1414	9	2013-02-04 16:00:00	2013-02-04 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1414
1415	9	2013-04-15 16:00:00	2013-04-15 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1415
1416	9	2013-04-30 15:00:00	2013-04-30 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1416
1417	9	2013-04-30 15:30:00	\N	4107185	completed	\N	4129023	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	237240001	\N	\N	\N	\N	event	1417
1418	9	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1418
1419	9	2012-12-05 17:00:00	2012-12-05 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1419
1420	9	2013-02-04 16:00:00	2013-02-04 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1420
1421	9	2013-04-15 16:00:00	2013-04-15 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1421
1422	9	2013-04-30 15:00:00	2013-04-30 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1422
1423	9	2012-12-05 17:00:00	2012-12-05 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1423
1424	9	2013-02-04 16:00:00	2013-02-04 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1424
1425	9	2013-04-15 16:00:00	2013-04-15 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1425
1426	9	2013-04-30 15:00:00	2013-04-30 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1426
1427	9	2012-12-05 17:00:00	2012-12-05 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1427
1428	9	2013-02-04 16:00:00	2013-02-04 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1428
1429	9	2013-04-15 16:00:00	2013-04-15 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1429
34	10	2008-01-02 09:48:14	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	34
35	10	2013-01-05 21:48:14	2013-01-05 22:48:14	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	35
36	10	2013-02-03 21:48:14	2013-02-03 22:48:14	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	36
37	10	2013-01-05 21:48:14	\N	4107185	completed	\N	4105172	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	193349004	\N	\N	\N	\N	event	37
38	10	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	38
39	10	2013-01-05 21:53:14	2013-01-05 21:53:14	3033643	completed	\N	1002011642	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.20}	2.16.840.1.113883.6.96	428341000124108	\N	\N	\N	\N	event	39
40	10	2013-01-05 21:53:14	2013-01-05 21:53:14	3033643	completed	\N	378743	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.20}	2.16.840.1.113883.6.96	312903003	\N	\N	\N	\N	event	40
41	10	2013-01-05 22:33:14	2013-01-05 22:48:14	378743	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.4}	\N	\N	\N	\N	\N	\N	event	41
42	10	2013-01-05 22:33:14	2013-01-05 22:48:14	1002011642	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.4}	\N	\N	\N	\N	\N	\N	event	42
43	10	2013-01-05 21:48:14	\N	4107185	completed	\N	1002043696	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.103	362.01	\N	\N	\N	\N	event	43
44	10	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	44
45	10	2013-01-05 21:48:14	2013-01-05 22:48:14	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	45
46	10	2013-02-03 21:48:14	2013-02-03 22:48:14	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	46
47	10	2013-01-05 21:48:14	\N	4107185	completed	\N	4008573	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	111513000	\N	\N	\N	\N	event	47
48	10	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	48
49	10	2013-01-05 21:48:14	2013-01-05 21:48:14	42870423	completed	\N	0.8	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.20}	\N	\N	\N	\N	\N	\N	event	49
50	10	2013-01-05 21:48:14	2013-01-05 21:48:14	42870425	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.20}	2.16.840.1.113883.5.4	Unmapped text result	\N	\N	\N	\N	event	50
51	10	2013-01-05 21:48:14	2013-01-05 22:48:14	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	51
52	10	2013-02-03 21:48:14	2013-02-03 22:48:14	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	52
80	11	2013-02-15 16:00:00	2013-02-15 16:30:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	80
98	11	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	98
97	11	2013-02-15 16:00:00	2013-02-15 16:30:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	97
96	11	2012-02-01 17:00:00	2012-02-01 18:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	96
95	11	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	95
94	11	2013-02-15 16:00:00	2013-02-15 16:30:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	94
93	11	2012-02-01 17:00:00	2012-02-01 18:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	93
92	11	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	92
91	11	2013-02-15 16:00:00	2013-02-15 16:30:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	91
90	11	2012-02-01 17:00:00	2012-02-01 18:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	90
89	11	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	89
88	11	2013-02-15 16:00:00	2013-02-15 16:30:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	88
87	11	2012-02-01 17:00:00	2012-02-01 18:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	87
86	11	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	86
85	11	2013-02-15 16:00:00	2013-02-15 16:30:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	85
84	11	2012-02-01 17:00:00	2012-02-01 18:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	84
83	11	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	83
82	11	2012-02-01 17:00:00	\N	4107185	completed	\N	201254	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	46635009	\N	\N	\N	\N	event	82
81	11	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	81
79	11	2012-02-01 17:00:00	2012-02-01 18:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	79
78	11	2013-10-10 16:00:00	2013-10-10 16:15:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	78
77	11	2013-02-15 16:00:00	2013-02-15 16:30:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	77
76	11	2012-02-01 17:00:00	2012-02-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	76
75	11	2013-02-01 17:00:00	2013-02-01 17:00:00	3005673	completed	\N	7	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	75
74	11	2013-02-01 17:00:00	2013-02-01 17:00:00	3005673	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.38}	\N	\N	\N	\N	\N	\N	event	74
73	11	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	73
72	11	2013-02-15 16:00:00	2013-02-15 16:30:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	72
71	11	2012-02-01 17:00:00	2012-02-01 18:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	71
70	11	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	70
69	11	2013-02-15 16:00:00	2013-02-15 16:30:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	69
68	11	2012-02-01 17:00:00	2012-02-01 18:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	68
67	11	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	67
66	11	2012-02-01 17:00:00	\N	4107185	completed	\N	201254	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	46635009	\N	\N	\N	\N	event	66
65	11	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	65
64	11	2013-02-15 16:00:00	2013-02-15 16:30:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	64
63	11	2012-02-01 17:00:00	2012-02-01 18:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	63
62	11	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	62
61	11	2013-02-15 16:00:00	2013-02-15 16:30:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	61
60	11	2012-02-01 17:00:00	2012-02-01 18:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	60
59	11	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	59
58	11	2013-02-15 16:00:00	2013-02-15 16:30:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	58
57	11	2012-02-01 17:00:00	2012-02-01 18:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	57
56	11	2013-10-10 16:00:00	2013-10-10 16:15:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	56
55	11	2013-02-15 16:00:00	2013-02-15 16:30:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	55
54	11	2012-02-01 17:00:00	2012-02-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	54
53	11	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	53
101	12	2013-04-01 14:00:00	2013-04-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	101
100	12	2013-04-01 14:00:00	2013-04-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	100
99	12	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	99
109	12	2013-04-01 14:00:00	2013-04-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	109
108	12	2013-04-01 14:00:00	2013-04-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	108
107	12	2013-04-01 14:00:00	2013-04-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	107
106	12	2013-04-01 14:00:00	2013-04-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	106
105	12	2013-04-01 14:00:00	2013-04-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	105
104	12	2013-04-01 14:00:00	2013-04-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	104
103	12	2013-04-01 14:00:00	2013-04-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	103
102	12	2013-04-01 14:00:00	2013-04-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	102
135	13	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	135
134	13	2013-01-30 17:30:00	2013-03-30 16:30:00	4107185	completed	\N	4049623	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	15639000	\N	\N	\N	\N	event	134
133	13	2013-01-25 16:15:00	2013-01-25 16:30:00	2314198	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	133
132	13	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	132
131	13	2013-01-30 17:30:00	2013-03-30 16:30:00	4107185	completed	\N	1002008953	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.103	296.22	\N	\N	\N	\N	event	131
130	13	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	130
129	13	2013-01-30 17:00:00	2013-01-30 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	129
128	13	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	128
127	13	2013-01-30 17:30:00	2013-03-30 16:30:00	4107185	completed	\N	4049623	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	15639000	\N	\N	\N	\N	event	127
126	13	2013-04-30 16:05:00	2013-04-30 16:05:00	3017094	completed	\N	3017094	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	2.16.840.1.113883.6.1	14463-4	\N	\N	\N	\N	event	126
125	13	\N	\N	3025378	new	\N	\N	observation	new	{2.16.840.1.113883.10.20.22.4.44,2.16.840.1.113883.10.20.24.3.37}	\N	\N	\N	\N	\N	\N	event	125
124	13	2013-04-30 16:05:00	2013-04-30 16:05:00	40233207	completed	\N	\N	supply	completed	{2.16.840.1.113883.10.20.24.3.45,2.16.840.1.113883.10.20.22.4.18}	\N	\N	\N	\N	\N	\N	event	124
123	13	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	123
122	13	2013-04-30 16:05:00	\N	4107185	completed	\N	4143828	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	426979002	\N	\N	\N	\N	event	122
121	13	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	121
120	13	2013-01-30 17:30:00	2013-03-30 16:30:00	4107185	completed	\N	4049623	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	15639000	\N	\N	\N	\N	event	120
119	13	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	119
118	13	2013-01-30 17:00:00	2013-01-30 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	118
117	13	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	117
116	13	2013-04-30 16:05:00	\N	4107185	completed	\N	4143828	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	426979002	\N	\N	\N	\N	event	116
115	13	2013-04-30 16:30:00	2013-04-30 16:45:00	4041982	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.22.4.12,2.16.840.1.113883.10.20.24.3.32}	\N	\N	\N	\N	\N	\N	event	115
114	13	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	114
113	13	2013-01-30 17:00:00	2013-01-30 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	113
112	13	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	112
111	13	2013-01-30 17:00:00	2013-01-30 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	111
110	13	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	110
146	13	2013-01-30 17:30:00	2013-03-30 16:30:00	4107185	completed	\N	4049623	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	15639000	\N	\N	\N	\N	event	146
147	13	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	147
148	13	2013-01-25 16:15:00	2013-01-25 16:30:00	43533854	completed	\N	1002018506	observation	completed	{2.16.840.1.113883.10.20.22.4.69,2.16.840.1.113883.10.20.24.3.69}	2.16.840.1.113883.6.96	428171000124102	\N	\N	\N	\N	event	148
149	13	2013-01-25 16:15:00	2013-01-25 16:30:00	2314198	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	149
150	13	2013-01-30 17:00:00	2013-01-30 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	150
151	13	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	151
152	13	2013-01-30 17:00:00	2013-01-30 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	152
154	13	2013-01-30 17:00:00	2013-01-30 17:00:00	40483091	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	154
153	13	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	153
137	13	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	137
138	13	2013-01-30 17:00:00	2013-01-30 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	138
139	13	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	139
140	13	2013-01-25 16:15:00	2013-01-25 16:30:00	4009095	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	140
141	13	2013-01-30 17:00:00	2013-01-30 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	141
142	13	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	142
143	13	2013-01-25 16:15:00	2013-01-25 16:30:00	4009095	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	143
144	13	2013-01-30 17:00:00	2013-01-30 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	144
145	13	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	145
136	13	2013-01-30 17:00:00	2013-01-30 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	136
157	14	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	157
155	14	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	155
156	14	2013-01-30 16:00:00	2013-01-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	156
158	14	2013-01-30 16:00:00	2013-01-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	158
159	14	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	159
160	14	2013-04-30 16:05:00	\N	4107185	completed	\N	4143828	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	426979002	\N	\N	\N	\N	event	160
161	14	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	161
162	14	2013-01-30 16:00:00	2013-01-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	162
163	14	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	163
164	14	2013-04-30 16:05:00	\N	4107185	completed	\N	4143828	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	426979002	\N	\N	\N	\N	event	164
165	14	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	165
166	14	\N	\N	3025378	new	\N	\N	observation	new	{2.16.840.1.113883.10.20.22.4.44,2.16.840.1.113883.10.20.24.3.37}	\N	\N	\N	\N	\N	\N	event	166
167	14	2013-01-30 16:00:00	2013-01-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	167
168	14	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	168
169	14	2013-01-30 16:00:00	2013-01-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	169
170	14	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	170
171	14	2013-01-30 16:00:00	2013-01-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	171
172	14	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	172
173	14	2013-01-30 16:00:00	2013-01-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	173
174	14	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	174
175	14	2013-01-30 16:00:00	2013-01-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	175
176	14	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	176
177	14	2013-01-30 16:00:00	2013-01-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	177
178	14	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	178
179	14	2013-01-30 16:00:00	2013-01-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	179
180	14	2013-04-30 16:00:00	2013-04-30 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	180
197	15	2013-04-01 14:00:00	\N	4107185	completed	\N	192279	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	127013003	\N	\N	\N	\N	event	197
210	15	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	210
209	15	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	209
202	15	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	202
208	15	2013-04-01 14:00:00	2013-04-01 14:00:00	3028288	completed	\N	88	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	208
207	15	2013-04-01 13:30:00	2013-04-01 13:30:00	4099248	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.22.4.13,2.16.840.1.113883.10.20.24.3.59}	\N	\N	\N	\N	\N	\N	event	207
201	15	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	201
200	15	2013-04-01 14:00:00	2013-04-01 14:00:00	3028288	completed	\N	88	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	200
199	15	2013-04-01 14:00:00	2013-04-01 14:00:00	3028288	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.38}	\N	\N	\N	\N	\N	\N	event	199
198	15	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	198
193	15	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	193
192	15	2013-04-01 14:00:00	2013-04-01 14:00:00	3005673	completed	\N	10	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	192
191	15	2013-04-01 14:00:00	2013-04-01 14:00:00	3005673	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.38}	\N	\N	\N	\N	\N	\N	event	191
190	15	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	190
189	15	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	189
188	15	2013-04-01 14:00:00	\N	4107185	completed	\N	192279	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	127013003	\N	\N	\N	\N	event	188
187	15	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	187
186	15	2013-04-01 14:00:00	\N	4107185	completed	\N	1002019733	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.103	250.42	\N	\N	\N	\N	event	186
185	15	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	185
184	15	2011-04-01 14:00:00	\N	4107185	completed	\N	201254	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	46635009	\N	\N	\N	\N	event	184
183	15	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	183
182	15	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	182
181	15	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	181
206	15	2013-04-01 13:30:00	2013-04-01 13:30:00	4239090	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.22.4.13,2.16.840.1.113883.10.20.24.3.59}	\N	\N	\N	\N	\N	\N	event	206
205	15	2013-04-01 13:30:00	2013-04-01 13:30:00	4047085	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.22.4.13,2.16.840.1.113883.10.20.24.3.59}	\N	\N	\N	\N	\N	\N	event	205
204	15	2013-04-01 13:30:00	2013-04-01 13:30:00	4295036	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.22.4.13,2.16.840.1.113883.10.20.24.3.59}	\N	\N	\N	\N	\N	\N	event	204
203	15	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	203
196	15	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	196
195	15	2011-04-01 14:00:00	\N	4107185	completed	\N	201254	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	46635009	\N	\N	\N	\N	event	195
194	15	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	194
211	16	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	211
215	16	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	215
214	16	2013-02-26 15:00:00	\N	4107185	completed	\N	201254	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	46635009	\N	\N	\N	\N	event	214
213	16	2013-02-26 14:00:00	2013-02-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	213
212	16	2013-02-26 14:00:00	2013-02-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	212
227	16	2013-02-26 14:00:00	2013-02-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	227
226	16	2013-02-26 14:00:00	2013-02-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	226
225	16	2013-02-26 14:00:00	2013-02-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	225
224	16	2013-02-26 14:00:00	2013-02-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	224
223	16	2013-02-26 14:00:00	2013-02-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	223
222	16	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	222
221	16	2013-02-26 15:00:00	\N	4107185	completed	\N	201254	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	46635009	\N	\N	\N	\N	event	221
220	16	2013-02-26 14:00:00	2013-02-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	220
219	16	2013-02-26 14:00:00	2013-02-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	219
218	16	2013-07-22 08:00:00	2013-07-22 08:00:00	3005673	completed	\N	8	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	218
217	16	2013-07-22 08:00:00	2013-07-22 08:00:00	3005673	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.38}	\N	\N	\N	\N	\N	\N	event	217
216	16	2013-02-26 14:00:00	2013-02-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	216
248	17	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	248
231	17	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	231
230	17	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	230
229	17	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	229
228	17	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	228
232	17	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	232
233	17	2013-03-02 14:30:00	2013-03-02 14:30:00	4022145	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.22.4.14,2.16.840.1.113883.10.20.24.3.66}	\N	\N	\N	\N	\N	\N	event	233
234	17	2013-03-02 14:30:00	2013-03-02 14:30:00	4022145	completed	\N	1002043086	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.87}	2.16.840.1.113883.6.96	433431000124101	\N	\N	\N	\N	event	234
235	17	2013-03-02 14:30:00	2013-03-02 14:30:00	4022145	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.22.4.14,2.16.840.1.113883.10.20.24.3.66}	\N	\N	\N	\N	\N	\N	event	235
236	17	2013-03-02 14:30:00	2013-03-02 14:30:00	4022145	completed	\N	1002003602	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.87}	2.16.840.1.113883.6.96	433411000124107	\N	\N	\N	\N	event	236
237	17	2013-03-02 14:30:00	\N	4107185	completed	\N	4091464	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	188147009	\N	\N	\N	\N	event	237
238	17	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	238
239	17	2013-03-02 14:45:00	\N	4107185	completed	\N	4167696	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	416053008	\N	\N	\N	\N	event	239
240	17	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	240
241	17	2013-03-02 15:00:00	2013-03-02 15:00:00	40238618	new	\N	\N	substanceAdministration	new	{2.16.840.1.113883.10.20.22.4.42,2.16.840.1.113883.10.20.24.3.47}	\N	\N	\N	\N	\N	\N	event	241
242	17	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	242
243	17	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	243
244	17	2013-03-02 14:30:00	\N	4107185	completed	\N	4091464	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	188147009	\N	\N	\N	\N	event	244
245	17	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	245
246	17	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	246
247	17	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	247
249	17	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	249
250	17	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	250
251	17	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	251
252	17	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	252
253	17	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	253
254	17	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	254
255	17	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	255
256	17	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	256
257	17	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	257
258	17	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	258
259	17	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	259
289	18	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	289
260	18	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	260
261	18	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	261
262	18	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	262
263	18	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	263
264	18	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	264
265	18	2013-03-02 14:30:00	2013-03-02 14:30:00	4022145	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.22.4.14,2.16.840.1.113883.10.20.24.3.66}	\N	\N	\N	\N	\N	\N	event	265
266	18	2013-03-02 14:30:00	2013-03-02 14:30:00	4022145	completed	\N	1002043086	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.87}	2.16.840.1.113883.6.96	433431000124101	\N	\N	\N	\N	event	266
267	18	2013-03-02 14:30:00	2013-03-02 14:30:00	4022145	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.22.4.14,2.16.840.1.113883.10.20.24.3.66}	\N	\N	\N	\N	\N	\N	event	267
268	18	2013-03-02 14:30:00	2013-03-02 14:30:00	4022145	completed	\N	1002003602	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.87}	2.16.840.1.113883.6.96	433411000124107	\N	\N	\N	\N	event	268
269	18	2013-03-02 14:30:00	\N	4107185	completed	\N	4091464	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	188147009	\N	\N	\N	\N	event	269
270	18	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	270
271	18	2013-03-02 14:45:00	\N	4107185	completed	\N	4167696	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	416053008	\N	\N	\N	\N	event	271
272	18	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	272
273	18	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	273
274	18	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	274
275	18	2013-03-02 14:30:00	\N	4107185	completed	\N	4091464	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	188147009	\N	\N	\N	\N	event	275
276	18	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	276
277	18	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	277
278	18	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	278
290	18	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	290
279	18	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	279
280	18	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	280
281	18	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	281
282	18	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	282
283	18	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	283
284	18	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	284
285	18	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	285
286	18	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	286
287	18	2013-03-02 14:00:00	2013-03-02 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	287
288	18	2013-05-05 13:00:00	2013-05-05 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	288
309	19	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	309
299	19	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	299
298	19	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	298
297	19	2013-10-01 16:05:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	297
296	19	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	296
295	19	2013-10-01 16:05:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	295
294	19	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	294
293	19	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	293
292	19	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	292
291	19	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	291
319	19	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	319
318	19	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	318
317	19	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	317
316	19	2013-10-01 16:05:00	\N	4107185	completed	\N	433753	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	15167005	\N	\N	\N	\N	event	316
315	19	2013-10-01 16:00:00	2013-10-01 16:00:00	40224915	new	\N	\N	substanceAdministration	new	{2.16.840.1.113883.10.20.22.4.42,2.16.840.1.113883.10.20.24.3.47}	\N	\N	\N	\N	\N	\N	event	315
314	19	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	314
313	19	2013-10-01 16:05:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	313
312	19	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	312
311	19	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	311
310	19	2013-10-01 16:00:00	2013-10-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	310
308	19	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	308
307	19	2013-10-01 16:05:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	307
306	19	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	306
305	19	2013-10-01 16:05:00	\N	4107185	completed	\N	433753	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	15167005	\N	\N	\N	\N	event	305
304	19	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	304
303	19	2013-10-01 16:05:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	303
302	19	2013-11-01 16:00:00	2013-11-01 17:00:00	4028920	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	302
301	19	2013-10-01 16:00:00	2013-10-01 16:00:00	40224915	new	\N	\N	substanceAdministration	new	{2.16.840.1.113883.10.20.22.4.42,2.16.840.1.113883.10.20.24.3.47}	\N	\N	\N	\N	\N	\N	event	301
300	19	2013-11-01 16:00:00	2013-11-01 17:00:00	4028920	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	300
384	20	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	384
370	20	2013-03-26 14:00:00	\N	4107185	completed	\N	1002037384	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.90	M43.27	\N	\N	\N	\N	event	370
369	20	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	369
368	20	2013-03-26 14:00:00	2013-03-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	368
367	20	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	367
366	20	2013-03-26 14:00:00	2013-03-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	366
365	20	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	365
381	20	2013-03-26 14:00:00	2013-03-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	381
382	20	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	382
383	20	2013-03-26 14:00:00	\N	4107185	completed	\N	4011931	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	10326007	\N	\N	\N	\N	event	383
371	20	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	371
386	20	2013-03-26 14:00:00	2013-03-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	386
387	20	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	387
388	20	2013-03-26 14:00:00	2013-03-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	388
389	20	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	389
390	20	2013-03-26 14:00:00	2013-03-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	390
391	20	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	391
393	20	2013-03-26 14:00:00	2013-03-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	393
499	22	2012-03-01 15:00:00	2012-03-01 15:00:00	1002021758	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	499
394	20	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	394
395	20	2013-03-26 14:00:00	2013-03-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	395
396	20	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	396
380	20	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	380
379	20	2013-03-26 14:00:00	2013-03-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	379
378	20	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	378
377	20	2013-03-26 14:00:00	\N	4107185	completed	\N	1002005079	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.103	093.0	\N	\N	\N	\N	event	377
376	20	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	376
375	20	2013-03-26 14:00:00	\N	4107185	completed	\N	4059945	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	161894002	\N	\N	\N	\N	event	375
374	20	2013-03-26 14:00:00	2013-03-26 14:15:00	4304200	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.22.4.12,2.16.840.1.113883.10.20.24.3.32}	\N	\N	\N	\N	\N	\N	event	374
373	20	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	373
372	20	2013-03-26 14:00:00	2013-03-26 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	372
411	21	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	411
412	21	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	412
403	21	2013-02-01 15:00:00	2013-02-01 16:00:00	4071507	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	403
404	21	2013-02-01 15:00:00	2013-02-01 16:00:00	4071507	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	404
405	21	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	405
406	21	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	406
407	21	2013-02-01 15:00:00	2013-02-01 15:00:00	40768539	completed	\N	9	observation	completed	{2.16.840.1.113883.10.20.22.4.69,2.16.840.1.113883.10.20.24.3.69}	\N	\N	\N	\N	\N	\N	event	407
397	21	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	397
398	21	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	398
399	21	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	399
400	21	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	400
401	21	2013-02-01 15:00:00	2013-02-01 16:00:00	4107185	completed	\N	4128030	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	236973005	\N	\N	\N	\N	event	401
402	21	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	402
408	21	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	408
409	21	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	409
410	21	2013-02-01 15:00:00	2013-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	410
488	22	2013-04-01 14:00:00	2013-04-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	488
489	22	2013-04-01 14:00:00	2013-04-01 14:00:00	1002012675	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	489
490	22	2011-09-01 14:00:00	2011-09-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	490
491	22	2011-09-01 14:00:00	2011-09-01 14:00:00	1002033789	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	491
492	22	2012-03-01 15:00:00	2012-03-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	492
493	22	2012-03-01 15:00:00	2012-03-01 15:00:00	1002033789	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	493
494	22	2012-12-01 15:00:00	2012-12-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	494
495	22	2012-12-01 15:00:00	2012-12-01 15:00:00	1002033789	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	495
496	22	2013-04-01 14:00:00	2013-04-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	496
413	22	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	2	\N	\N	\N	\N	event	413
414	22	2011-09-01 13:00:00	2011-09-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	414
415	22	2012-03-01 14:00:00	2012-03-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	415
416	22	2012-12-01 14:00:00	2012-12-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	416
417	22	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	417
418	22	2011-09-01 13:00:00	2011-09-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	418
419	22	2012-03-01 14:00:00	2012-03-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	419
420	22	2012-12-01 14:00:00	2012-12-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	420
421	22	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	421
422	22	2011-09-01 13:00:00	2011-09-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	422
423	22	2012-03-01 14:00:00	2012-03-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	423
424	22	2012-12-01 14:00:00	2012-12-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	424
425	22	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	425
426	22	2011-09-01 13:00:00	2011-09-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	426
427	22	2012-03-01 14:00:00	2012-03-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	427
428	22	2012-12-01 14:00:00	2012-12-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	428
429	22	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	429
430	22	2011-09-01 13:00:00	2011-09-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	430
431	22	2012-03-01 14:00:00	2012-03-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	431
432	22	2012-12-01 14:00:00	2012-12-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	432
433	22	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	433
434	22	2011-09-01 13:00:00	2011-09-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	434
435	22	2012-03-01 14:00:00	2012-03-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	435
436	22	2012-12-01 14:00:00	2012-12-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	436
437	22	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	437
438	22	2011-09-01 13:00:00	2011-09-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	438
506	22	2013-04-01 14:00:00	2013-04-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	506
505	22	2013-04-01 14:00:00	2013-04-01 14:00:00	1002024516	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	505
504	22	2013-04-01 14:00:00	2013-04-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	504
503	22	2013-04-01 14:00:00	2013-04-01 14:00:00	1002021758	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	503
502	22	2013-04-01 14:00:00	2013-04-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	502
501	22	2012-12-01 15:00:00	2012-12-01 15:00:00	1002021758	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	501
515	22	2012-03-01 14:00:00	2012-03-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	515
514	22	2011-09-01 13:00:00	2011-09-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	514
513	22	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	513
512	22	2012-12-01 14:00:00	2012-12-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	512
511	22	2012-03-01 14:00:00	2012-03-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	511
510	22	2011-09-01 13:00:00	2011-09-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	510
509	22	2013-04-01 14:00:00	2013-04-01 14:00:00	1002023707	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	509
508	22	2013-04-01 14:00:00	2013-04-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	508
507	22	2013-04-01 14:00:00	2013-04-01 14:00:00	1002011337	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	507
500	22	2012-12-01 15:00:00	2012-12-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	500
498	22	2012-03-01 15:00:00	2012-03-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	498
473	22	2013-04-01 14:00:00	2013-04-01 14:00:00	1002034096	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	473
439	22	2012-03-01 14:00:00	2012-03-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	439
474	22	2013-04-01 14:00:00	2013-04-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	474
475	22	2013-04-01 14:00:00	2013-04-01 14:00:00	1002024516	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	475
476	22	2011-09-01 14:00:00	2011-09-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	476
477	22	2011-09-01 14:00:00	2011-09-01 14:00:00	1002032089	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	477
516	22	2012-12-01 14:00:00	2012-12-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	516
517	22	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	517
518	22	2011-09-01 13:00:00	2011-09-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	518
519	22	2012-03-01 14:00:00	2012-03-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	519
520	22	2012-12-01 14:00:00	2012-12-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	520
521	22	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	521
522	22	2012-03-01 15:00:00	2012-03-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	522
523	22	2012-03-01 15:00:00	2012-03-01 15:00:00	1002012675	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	523
524	22	2012-12-01 15:00:00	2012-12-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	524
526	22	2013-04-01 14:00:00	2013-04-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	526
525	22	2012-12-01 15:00:00	2012-12-01 15:00:00	1002012675	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	525
527	22	2013-04-01 14:00:00	2013-04-01 14:00:00	1002012675	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	527
440	22	2012-12-01 14:00:00	2012-12-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	440
441	22	2013-04-01 13:00:00	2013-04-01 14:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	441
442	22	2011-09-01 14:00:00	2011-09-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	442
443	22	2011-09-01 14:00:00	2011-09-01 14:00:00	1002033952	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	443
444	22	2011-09-01 14:00:00	2011-09-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	444
445	22	2011-09-01 14:00:00	2011-09-01 14:00:00	1002010349	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	445
446	22	2012-03-01 15:00:00	2012-03-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	446
447	22	2012-03-01 15:00:00	2012-03-01 15:00:00	1002033952	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	447
448	22	2012-03-01 15:00:00	2012-03-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	448
449	22	2012-03-01 15:00:00	2012-03-01 15:00:00	1002010349	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	449
450	22	2012-12-01 15:00:00	2012-12-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	450
451	22	2012-12-01 15:00:00	2012-12-01 15:00:00	1002010349	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	451
452	22	2012-12-01 15:00:00	2012-12-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	452
453	22	2012-12-01 15:00:00	2012-12-01 15:00:00	1002033952	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	453
454	22	2013-04-01 14:00:00	2013-04-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	454
455	22	2013-04-01 14:00:00	2013-04-01 14:00:00	1002033952	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	455
456	22	2013-04-01 14:00:00	2013-04-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	456
457	22	2013-04-01 14:00:00	2013-04-01 14:00:00	1002010349	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	457
458	22	2011-09-01 14:00:00	2011-09-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	458
459	22	2011-09-01 14:00:00	2011-09-01 14:00:00	1002033952	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	459
460	22	2012-03-01 15:00:00	2012-03-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	460
461	22	2012-03-01 15:00:00	2012-03-01 15:00:00	1002033952	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	461
462	22	2012-12-01 15:00:00	2012-12-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	462
463	22	2012-12-01 15:00:00	2012-12-01 15:00:00	1002033952	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	463
464	22	2013-04-01 14:00:00	2013-04-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	464
465	22	2013-04-01 14:00:00	2013-04-01 14:00:00	1002033952	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	465
466	22	2011-09-01 14:00:00	2011-09-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	466
467	22	2011-09-01 14:00:00	2011-09-01 14:00:00	1002034096	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	467
468	22	2012-03-01 15:00:00	2012-03-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	468
469	22	2012-03-01 15:00:00	2012-03-01 15:00:00	1002034096	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	469
470	22	2012-12-01 15:00:00	2012-12-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	470
471	22	2012-12-01 15:00:00	2012-12-01 15:00:00	1002034096	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	471
472	22	2013-04-01 14:00:00	2013-04-01 14:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	472
478	22	2012-03-01 15:00:00	2012-03-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	478
479	22	2012-03-01 15:00:00	2012-03-01 15:00:00	1002032089	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	479
480	22	2012-12-01 15:00:00	2012-12-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	480
481	22	2012-12-01 15:00:00	2012-12-01 15:00:00	1002032089	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	481
482	22	2013-03-01 15:00:00	2013-03-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	482
483	22	2013-03-01 15:00:00	2013-03-01 15:00:00	1002032089	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	483
484	22	2012-03-01 15:00:00	2012-03-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	484
485	22	2012-03-01 15:00:00	2012-03-01 15:00:00	1002012675	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	485
486	22	2012-12-01 15:00:00	2012-12-01 15:00:00	4166266	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.42}	\N	\N	\N	\N	\N	\N	event	486
487	22	2012-12-01 15:00:00	2012-12-01 15:00:00	1002012675	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	487
497	22	2013-04-01 14:00:00	2013-04-01 14:00:00	1002033789	completed	\N	\N	substanceAdministration	completed	{2.16.840.1.113883.10.20.22.4.16}	\N	\N	\N	\N	\N	\N	event	497
562	24	2013-07-01 16:00:00	2013-07-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	562
528	24	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	528
529	24	2012-05-10 14:00:00	2012-05-10 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	529
530	24	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	530
531	24	2013-07-01 16:00:00	2013-07-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	531
532	24	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	532
533	24	2012-05-10 14:00:00	2012-05-10 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	533
534	24	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	534
535	24	2013-07-01 16:00:00	2013-07-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	535
536	24	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	536
537	24	2013-03-01 17:05:00	\N	4107185	completed	\N	4119613	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	233970002	\N	\N	\N	\N	event	537
538	24	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	538
539	24	2013-03-01 17:05:00	\N	4107185	completed	\N	4155962	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	371804009	\N	\N	\N	\N	event	539
540	24	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	540
541	24	2013-03-01 17:00:00	\N	4107185	completed	\N	4004279	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	10091002	\N	\N	\N	\N	event	541
542	24	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	542
543	24	2013-03-01 17:05:00	\N	4107185	completed	\N	1002042273	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	981000124106	\N	\N	\N	\N	event	543
544	24	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	544
545	24	2012-05-10 14:00:00	2012-05-10 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	545
546	24	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	546
547	24	2013-07-01 16:00:00	2013-07-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	547
548	24	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	548
549	24	2013-03-01 17:05:00	2013-03-01 17:05:00	3004249	completed	\N	150	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.57}	\N	\N	\N	\N	\N	\N	event	549
550	24	2013-03-01 17:05:00	\N	4107185	completed	\N	4028741	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	10725009	\N	\N	\N	\N	event	550
551	24	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	551
552	24	2013-03-01 17:05:00	\N	4107185	completed	\N	4119613	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	233970002	\N	\N	\N	\N	event	552
553	24	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	553
554	24	2013-03-01 17:05:00	\N	4107185	completed	\N	4155962	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	371804009	\N	\N	\N	\N	event	554
555	24	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	555
556	24	2012-05-10 14:00:00	2012-05-10 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	556
557	24	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	557
558	24	2013-07-01 16:00:00	2013-07-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	558
559	24	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	559
560	24	2012-05-10 14:00:00	2012-05-10 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	560
561	24	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	561
563	24	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	563
564	24	2013-03-01 17:05:00	\N	4107185	completed	\N	4119613	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	233970002	\N	\N	\N	\N	event	564
565	24	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	565
566	24	2013-03-01 17:05:00	\N	4107185	completed	\N	4155962	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	371804009	\N	\N	\N	\N	event	566
567	24	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	567
568	24	2013-03-01 17:05:00	2013-03-01 17:05:00	3035009	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.38}	\N	\N	\N	\N	\N	\N	event	568
569	24	2013-03-01 17:05:00	2013-03-01 17:05:00	3007070	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.38}	\N	\N	\N	\N	\N	\N	event	569
570	24	2013-03-01 17:05:00	2013-03-01 17:05:00	3007070	completed	\N	37	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	570
571	24	2013-03-01 17:05:00	\N	4107185	completed	\N	4028741	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	10725009	\N	\N	\N	\N	event	571
572	24	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	572
573	24	2013-03-01 17:05:00	2013-03-01 17:05:00	3035009	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	573
574	24	2012-05-10 14:00:00	2012-05-10 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	574
575	24	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	575
576	24	2013-07-01 16:00:00	2013-07-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	576
577	24	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	577
578	24	2013-03-01 17:05:00	2013-03-01 17:05:00	3012888	completed	\N	90	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.57}	\N	\N	\N	\N	\N	\N	event	578
579	24	2012-05-10 14:00:00	2012-05-10 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	579
580	24	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	580
581	24	2013-07-01 16:00:00	2013-07-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	581
582	24	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	582
583	24	2012-05-10 14:00:00	2012-05-10 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	583
584	24	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	584
585	24	2013-07-01 16:00:00	2013-07-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	585
586	24	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	586
587	24	2012-05-10 14:00:00	2012-05-10 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	587
588	24	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	588
589	24	2013-07-01 16:00:00	2013-07-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	589
590	24	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	590
591	24	2013-03-01 17:05:00	2013-03-01 17:05:00	3007070	completed	\N	37	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	591
592	24	2012-05-10 14:00:00	2012-05-10 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	592
593	24	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	593
594	24	2013-07-01 16:00:00	2013-07-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	594
595	24	2013-12-20 17:00:00	2013-12-20 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	595
611	25	2013-05-03 15:00:00	2013-05-03 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	611
596	25	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	596
597	25	2013-05-03 15:00:00	2013-05-03 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	597
598	25	2013-05-03 15:00:00	2013-05-03 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	598
599	25	2002-02-03 14:00:00	\N	4107185	completed	\N	4008081	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	111880001	\N	\N	\N	\N	event	599
600	25	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	600
601	25	2013-05-03 15:00:00	2013-05-03 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	601
602	25	2013-05-03 15:00:00	2013-05-03 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	602
603	25	2013-05-03 15:00:00	2013-05-03 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	603
604	25	2013-05-03 15:00:00	2013-05-03 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	604
605	25	2013-05-03 15:00:00	2013-05-03 16:00:00	4126591	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	605
606	25	2013-05-03 15:00:00	2013-05-03 16:00:00	4107185	completed	\N	4033969	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	109564008	\N	\N	\N	\N	event	606
607	25	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	607
608	25	2013-05-03 15:00:00	2013-05-03 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	608
609	25	2013-05-03 15:00:00	2013-05-03 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	609
610	25	2013-05-03 15:00:00	2013-05-03 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	610
621	26	2013-01-29 15:00:00	2013-01-29 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	621
612	26	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	612
613	26	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	613
614	26	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	614
615	26	2013-01-29 15:00:00	2013-01-29 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	615
616	26	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	616
617	26	2013-01-29 16:00:00	\N	4107185	completed	\N	4277444	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	6475002	\N	\N	\N	\N	event	617
618	26	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	618
619	26	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	619
620	26	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	620
622	26	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	622
623	26	2013-01-29 15:00:00	\N	4107185	completed	\N	4004279	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	10091002	\N	\N	\N	\N	event	623
624	26	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	624
625	26	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	625
626	26	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	626
627	26	2013-01-29 15:00:00	2013-01-29 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	627
628	26	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	628
629	26	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	629
630	26	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	630
631	26	2013-01-29 15:00:00	2013-01-29 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	631
632	26	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	632
633	26	2012-09-01 14:00:00	2012-09-01 15:00:00	4035487	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	633
634	26	2012-11-01 14:00:00	2012-11-01 15:00:00	4079266	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	634
635	26	2013-01-29 16:00:00	\N	4107185	completed	\N	4277444	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	6475002	\N	\N	\N	\N	event	635
636	26	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	636
637	26	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	637
638	26	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	638
639	26	2013-01-29 15:00:00	2013-01-29 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	639
640	26	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	640
641	26	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	641
642	26	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	642
643	26	2013-01-29 15:00:00	2013-01-29 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	643
644	26	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	644
645	26	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	645
646	26	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	646
647	26	2013-01-29 15:00:00	2013-01-29 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	647
648	26	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	648
649	26	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	649
650	26	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	650
651	26	2013-01-29 15:00:00	2013-01-29 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	651
652	26	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	652
653	26	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	653
654	26	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	654
655	26	2013-01-29 15:00:00	2013-01-29 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	655
656	26	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	656
657	26	2012-08-01 14:00:00	2012-08-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	657
658	26	2012-10-01 14:00:00	2012-10-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	658
659	26	2013-01-29 15:00:00	2013-01-29 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	659
660	26	2013-06-01 14:00:00	2013-06-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	660
703	27	2013-01-05 08:00:00	2013-01-05 08:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	703
661	27	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	661
662	27	2012-02-01 15:00:00	2012-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	662
663	27	2013-01-05 08:00:00	2013-01-05 08:15:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	663
664	27	2013-10-10 16:00:00	2013-10-10 16:15:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	664
704	27	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	704
665	27	2012-02-01 15:00:00	2012-02-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	665
666	27	2013-01-05 08:00:00	2013-01-05 08:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	666
667	27	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	667
668	27	2012-02-01 15:00:00	2012-02-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	668
669	27	2013-01-05 08:00:00	2013-01-05 08:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	669
670	27	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	670
671	27	2012-02-01 15:00:00	2012-02-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	671
672	27	2013-01-05 08:00:00	2013-01-05 08:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	672
673	27	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	673
674	27	2012-02-01 15:00:00	\N	4107185	completed	\N	201254	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	46635009	\N	\N	\N	\N	event	674
675	27	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	675
676	27	2012-02-01 15:00:00	2012-02-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	676
677	27	2013-01-05 08:00:00	2013-01-05 08:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	677
678	27	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	678
679	27	2012-02-01 15:00:00	2012-02-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	679
680	27	2013-01-05 08:00:00	2013-01-05 08:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	680
681	27	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	681
682	27	2012-02-01 15:00:00	2012-02-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	682
683	27	2013-01-05 08:00:00	2013-01-05 08:15:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	683
684	27	2013-10-10 16:00:00	2013-10-10 16:15:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	684
685	27	2012-02-01 15:00:00	2012-02-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	685
686	27	2013-01-05 08:00:00	2013-01-05 08:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	686
687	27	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	687
688	27	2012-02-01 15:00:00	\N	4107185	completed	\N	201254	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	46635009	\N	\N	\N	\N	event	688
689	27	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	689
690	27	2012-02-01 15:00:00	2012-02-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	690
691	27	2013-01-05 08:00:00	2013-01-05 08:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	691
692	27	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	692
693	27	2012-02-01 15:00:00	2012-02-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	693
694	27	2013-01-05 08:00:00	2013-01-05 08:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	694
695	27	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	695
696	27	2012-02-01 15:00:00	2012-02-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	696
697	27	2013-01-05 08:00:00	2013-01-05 08:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	697
698	27	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	698
699	27	2012-02-01 15:00:00	2012-02-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	699
700	27	2013-01-05 08:00:00	2013-01-05 08:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	700
701	27	2013-10-10 16:00:00	2013-10-10 16:15:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	701
702	27	2012-02-01 15:00:00	2012-02-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	702
738	28	2013-01-04 00:28:46	2013-01-04 00:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	738
705	28	2007-12-30 21:28:46	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	705
706	28	2012-01-31 07:28:46	2012-01-31 08:28:46	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	706
707	28	2013-01-04 00:28:46	2013-01-04 00:43:46	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	707
708	28	2013-10-09 08:28:46	2013-10-09 08:43:46	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	708
709	28	2012-01-31 07:28:46	2012-01-31 08:28:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	709
710	28	2013-01-04 00:28:46	2013-01-04 00:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	710
711	28	2013-10-09 08:28:46	2013-10-09 08:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	711
712	28	2012-01-31 07:28:46	2012-01-31 08:28:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	712
713	28	2013-01-04 00:28:46	2013-01-04 00:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	713
714	28	2013-10-09 08:28:46	2013-10-09 08:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	714
715	28	2012-01-31 07:28:46	2012-01-31 08:28:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	715
716	28	2013-01-04 00:28:46	2013-01-04 00:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	716
717	28	2013-10-09 08:28:46	2013-10-09 08:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	717
718	28	2012-01-31 07:28:46	\N	4107185	completed	\N	201254	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	46635009	\N	\N	\N	\N	event	718
719	28	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	719
720	28	2012-01-31 07:28:46	2012-01-31 08:28:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	720
721	28	2013-01-04 00:28:46	2013-01-04 00:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	721
722	28	2013-10-09 08:28:46	2013-10-09 08:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	722
723	28	2012-01-31 07:28:46	2012-01-31 08:28:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	723
724	28	2013-01-04 00:28:46	2013-01-04 00:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	724
725	28	2013-10-09 08:28:46	2013-10-09 08:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	725
726	28	2012-01-31 07:28:46	2012-01-31 08:28:46	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	726
727	28	2013-01-04 00:28:46	2013-01-04 00:43:46	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	727
728	28	2013-10-09 08:28:46	2013-10-09 08:43:46	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	728
729	28	2012-01-31 07:28:46	2012-01-31 08:28:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	729
730	28	2013-01-04 00:28:46	2013-01-04 00:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	730
731	28	2013-10-09 08:28:46	2013-10-09 08:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	731
732	28	2012-01-31 07:28:46	\N	4107185	completed	\N	201254	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	46635009	\N	\N	\N	\N	event	732
733	28	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	733
734	28	2012-01-31 07:28:46	2012-01-31 08:28:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	734
735	28	2013-01-04 00:28:46	2013-01-04 00:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	735
736	28	2013-10-09 08:28:46	2013-10-09 08:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	736
737	28	2012-01-31 07:28:46	2012-01-31 08:28:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	737
739	28	2013-10-09 08:28:46	2013-10-09 08:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	739
740	28	2012-01-31 07:28:46	2012-01-31 08:28:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	740
741	28	2013-01-04 00:28:46	2013-01-04 00:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	741
742	28	2013-10-09 08:28:46	2013-10-09 08:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	742
743	28	2012-01-31 07:28:46	2012-01-31 08:28:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	743
744	28	2013-01-04 00:28:46	2013-01-04 00:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	744
745	28	2013-10-09 08:28:46	2013-10-09 08:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	745
746	28	2012-01-31 07:28:46	2012-01-31 08:28:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	746
747	28	2013-01-04 00:28:46	2013-01-04 00:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	747
748	28	2013-10-09 08:28:46	2013-10-09 08:43:46	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	748
784	29	2013-10-20 03:49:50	2013-10-20 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	784
749	29	2007-12-31 17:49:50	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	749
750	29	2013-03-01 03:49:50	2013-03-01 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	750
751	29	2013-10-20 03:49:50	2013-10-20 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	751
752	29	2013-03-01 03:49:50	2013-03-01 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	752
753	29	2013-10-20 03:49:50	2013-10-20 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	753
754	29	2013-03-01 03:49:50	2013-10-20 04:49:50	4107185	completed	\N	4034087	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	237244005	\N	\N	\N	\N	event	754
755	29	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	755
756	29	2013-03-01 03:49:50	2013-03-01 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	756
757	29	2013-10-20 03:49:50	2013-10-20 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	757
758	29	2013-10-20 03:49:50	2013-10-20 04:49:50	4107185	completed	\N	4128030	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	236973005	\N	\N	\N	\N	event	758
759	29	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	759
760	29	2013-10-20 03:49:50	2013-10-20 04:49:50	4128030	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	760
761	29	2013-03-01 04:49:50	2013-03-01 04:49:50	3027898	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.38}	\N	\N	\N	\N	\N	\N	event	761
762	29	2013-03-01 03:49:50	2013-10-20 04:49:50	4107185	completed	\N	4034087	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	237244005	\N	\N	\N	\N	event	762
763	29	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	763
764	29	\N	\N	3018171	new	\N	\N	observation	new	{2.16.840.1.113883.10.20.22.4.44,2.16.840.1.113883.10.20.24.3.37}	\N	\N	\N	\N	\N	\N	event	764
765	29	2013-10-20 03:49:50	2013-10-20 04:49:50	4128030	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	765
766	29	\N	\N	3016404	new	\N	\N	observation	new	{2.16.840.1.113883.10.20.22.4.44,2.16.840.1.113883.10.20.24.3.17}	\N	\N	\N	\N	\N	\N	event	766
767	29	2013-03-01 03:49:50	2013-03-01 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	767
768	29	2013-10-20 03:49:50	2013-10-20 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	768
769	29	2013-03-01 03:49:50	2013-10-20 04:49:50	4107185	completed	\N	4034087	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	237244005	\N	\N	\N	\N	event	769
770	29	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	770
771	29	2013-03-01 03:49:50	2013-03-01 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	771
772	29	2013-10-20 03:49:50	2013-10-20 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	772
773	29	2013-03-01 03:49:50	2013-03-01 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	773
774	29	2013-10-20 03:49:50	2013-10-20 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	774
775	29	2013-03-01 03:49:50	2013-03-01 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	775
776	29	2013-10-20 03:49:50	2013-10-20 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	776
777	29	2013-03-01 03:49:50	2013-10-20 04:49:50	4107185	completed	\N	4034087	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	237244005	\N	\N	\N	\N	event	777
778	29	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	778
779	29	2013-03-01 03:49:50	2013-03-01 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	779
780	29	2013-10-20 03:49:50	2013-10-20 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	780
781	29	2013-03-01 03:49:50	2013-03-01 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	781
782	29	2013-10-20 03:49:50	2013-10-20 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	782
783	29	2013-03-01 03:49:50	2013-03-01 04:49:50	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	783
832	30	2013-03-09 22:04:18	\N	4107185	completed	\N	4167696	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	416053008	\N	\N	\N	\N	event	832
821	30	2008-01-08 12:19:18	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	821
822	30	2013-03-09 21:19:18	2013-03-09 22:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	822
823	30	2013-05-12 20:19:18	2013-05-12 21:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	823
824	30	2013-03-09 21:19:18	2013-03-09 22:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	824
825	30	2013-05-12 20:19:18	2013-05-12 21:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	825
826	30	2013-03-09 21:49:18	2013-03-09 21:49:18	4022145	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.22.4.14,2.16.840.1.113883.10.20.24.3.66}	\N	\N	\N	\N	\N	\N	event	826
827	30	2013-03-09 21:49:18	2013-03-09 21:49:18	4022145	completed	\N	1002043086	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.87}	2.16.840.1.113883.6.96	433431000124101	\N	\N	\N	\N	event	827
828	30	2013-03-09 21:49:18	2013-03-09 21:49:18	4022145	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.22.4.14,2.16.840.1.113883.10.20.24.3.66}	\N	\N	\N	\N	\N	\N	event	828
829	30	2013-03-09 21:49:18	2013-03-09 21:49:18	4022145	completed	\N	1002003602	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.87}	2.16.840.1.113883.6.96	433411000124107	\N	\N	\N	\N	event	829
830	30	2013-03-09 21:49:18	\N	4107185	completed	\N	4091464	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	188147009	\N	\N	\N	\N	event	830
831	30	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	831
841	30	2013-05-12 20:19:18	2013-05-12 21:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	841
842	30	2013-03-09 21:19:18	2013-03-09 22:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	842
843	30	2013-05-12 20:19:18	2013-05-12 21:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	843
844	30	2013-03-09 21:19:18	2013-03-09 22:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	844
845	30	2013-05-12 20:19:18	2013-05-12 21:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	845
846	30	2013-03-09 21:19:18	2013-03-09 22:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	846
847	30	2013-05-12 20:19:18	2013-05-12 21:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	847
848	30	2013-03-09 21:19:18	2013-03-09 22:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	848
849	30	2013-05-12 20:19:18	2013-05-12 21:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	849
850	30	2013-03-09 21:19:18	2013-03-09 22:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	850
851	30	2013-05-12 20:19:18	2013-05-12 21:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	851
833	30	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	833
834	30	2013-03-09 21:19:18	2013-03-09 22:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	834
835	30	2013-05-12 20:19:18	2013-05-12 21:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	835
836	30	2013-03-09 21:49:18	\N	4107185	completed	\N	4091464	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	188147009	\N	\N	\N	\N	event	836
837	30	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	837
838	30	2013-03-09 21:19:18	2013-03-09 22:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	838
839	30	2013-05-12 20:19:18	2013-05-12 21:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	839
840	30	2013-03-09 21:19:18	2013-03-09 22:19:18	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	840
861	31	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	861
852	31	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	852
853	31	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	853
854	31	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	854
855	31	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	855
856	31	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	856
857	31	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	857
858	31	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	858
859	31	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	859
860	31	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	860
862	31	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	862
869	32	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	869
874	32	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	874
873	32	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	873
872	32	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	872
871	32	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	871
870	32	2013-02-01 14:30:00	2013-02-01 14:30:00	1002041688	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.22.4.12,2.16.840.1.113883.10.20.24.3.32}	\N	\N	\N	\N	\N	\N	event	870
868	32	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	868
867	32	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	867
866	32	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	866
865	32	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	865
864	32	2013-02-01 14:00:00	2013-02-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	864
863	32	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	863
914	33	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	914
875	33	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	875
876	33	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	876
877	33	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	877
878	33	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	878
879	33	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	879
880	33	2013-03-01 15:30:00	\N	4107185	completed	\N	1002037384	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.90	M43.27	\N	\N	\N	\N	event	880
881	33	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	881
882	33	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	882
883	33	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	883
884	33	2013-03-01 15:00:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	884
885	33	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	885
886	33	2013-03-01 15:30:00	\N	4107185	completed	\N	4059945	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	161894002	\N	\N	\N	\N	event	886
887	33	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	887
888	33	2013-03-01 16:00:00	\N	4107185	completed	\N	133419	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	109267002	\N	\N	\N	\N	event	888
889	33	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	889
890	33	2013-03-01 15:00:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	890
891	33	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	891
892	33	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	892
893	33	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	893
894	33	2013-03-01 15:00:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	894
895	33	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	895
896	33	2013-03-01 15:00:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	896
897	33	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	897
898	33	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	898
899	33	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	899
900	33	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	900
901	33	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	901
902	33	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	902
903	33	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	903
904	33	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	904
905	33	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	905
906	33	2013-03-01 15:00:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	906
907	33	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	907
908	33	2013-07-01 14:00:00	2013-07-01 14:15:00	43533855	completed	\N	1002018506	observation	completed	{2.16.840.1.113883.10.20.22.4.69,2.16.840.1.113883.10.20.24.3.69}	2.16.840.1.113883.6.96	428171000124102	\N	\N	\N	\N	event	908
909	33	2013-03-01 16:00:00	\N	4107185	completed	\N	4036795	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	162607003	\N	\N	\N	\N	event	909
910	33	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	910
911	33	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	911
912	33	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	912
913	33	2013-03-01 15:00:00	2013-03-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	913
932	34	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	932
915	34	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	915
916	34	2013-03-30 14:00:00	2013-03-30 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	916
917	34	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	917
918	34	2013-06-25 15:00:00	2013-06-25 15:00:00	3016169	completed	\N	3016169	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.20}	2.16.840.1.113883.6.1	24604-1	\N	\N	\N	\N	event	918
919	34	2013-03-30 14:00:00	2013-03-30 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	919
920	34	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	920
921	34	2013-03-30 14:30:00	\N	4107185	completed	\N	1002037384	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.90	M43.27	\N	\N	\N	\N	event	921
922	34	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	922
923	34	2013-03-30 14:00:00	2013-03-30 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	923
924	34	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	924
925	34	2013-06-25 14:00:00	2013-06-25 14:00:00	3004249	completed	\N	110	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.57}	\N	\N	\N	\N	\N	\N	event	925
926	34	2013-03-30 15:00:00	2013-03-30 15:00:00	4161183	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.24.3.4}	\N	\N	\N	\N	\N	\N	event	926
927	34	2013-03-30 14:30:00	2013-03-30 14:30:00	4304200	completed	\N	\N	act	completed	{2.16.840.1.113883.10.20.22.4.12,2.16.840.1.113883.10.20.24.3.32}	\N	\N	\N	\N	\N	\N	event	927
928	34	2013-03-30 14:30:00	\N	4107185	completed	\N	4059945	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	161894002	\N	\N	\N	\N	event	928
929	34	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	929
930	34	2013-03-31 15:00:00	2013-03-31 15:00:00	3033471	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.22.4.13,2.16.840.1.113883.10.20.24.3.18}	\N	\N	\N	\N	\N	\N	event	930
931	34	2013-03-30 15:00:00	\N	4107185	completed	\N	1002005079	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.103	093.0	\N	\N	\N	\N	event	931
957	34	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	957
933	34	2013-03-30 14:00:00	2013-03-30 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	933
934	34	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	934
935	34	2013-03-30 14:00:00	2013-03-30 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	935
936	34	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	936
937	34	2013-03-30 15:00:00	\N	4107185	completed	\N	4011931	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	10326007	\N	\N	\N	\N	event	937
938	34	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	938
939	34	2013-06-25 14:00:00	2013-06-25 14:00:00	3035009	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.38}	\N	\N	\N	\N	\N	\N	event	939
941	34	2013-06-25 14:00:00	2013-06-25 14:00:00	3035009	completed	\N	90	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	941
942	34	2013-03-30 14:00:00	2013-03-30 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	942
943	34	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	943
944	34	2013-06-25 14:00:00	2013-06-25 14:00:00	3012888	completed	\N	75	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.57}	\N	\N	\N	\N	\N	\N	event	944
945	34	2013-03-30 14:00:00	2013-03-30 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	945
946	34	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	946
947	34	2013-06-25 14:00:00	2013-06-25 14:00:00	3038553	completed	\N	22	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.57}	\N	\N	\N	\N	\N	\N	event	947
948	34	2013-03-30 14:00:00	2013-03-30 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	948
949	34	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	949
950	34	2013-06-25 14:30:00	2013-06-25 14:30:00	3025378	completed	\N	3025378	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	2.16.840.1.113883.6.1	10524-7	\N	\N	\N	\N	event	950
952	34	2013-06-25 14:30:00	\N	3022110	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.22.4.69,2.16.840.1.113883.10.20.24.3.69}	\N	\N	\N	\N	\N	\N	event	952
953	34	2013-06-25 15:00:00	2013-06-25 15:00:00	718669	new	\N	\N	substanceAdministration	new	{2.16.840.1.113883.10.20.22.4.42,2.16.840.1.113883.10.20.24.3.47}	\N	\N	\N	\N	\N	\N	event	953
954	34	2013-03-30 14:00:00	2013-03-30 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	954
955	34	2013-06-25 14:00:00	2013-06-25 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	955
956	34	2013-03-30 14:00:00	2013-03-30 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	956
959	35	2013-01-04 17:00:00	2013-01-04 18:00:00	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	959
960	35	2013-02-02 17:00:00	2013-02-02 18:00:00	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	960
961	35	2013-01-04 17:10:00	\N	4107185	completed	\N	4105172	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	193349004	\N	\N	\N	\N	event	961
962	35	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	962
971	35	2013-02-02 17:00:00	2013-02-02 18:00:00	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	971
963	35	2013-01-04 17:30:00	2013-01-04 17:30:00	3033643	completed	\N	4105173	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.20}	2.16.840.1.113883.6.96	193350004	\N	\N	\N	\N	event	963
964	35	2013-01-04 17:10:00	\N	4107185	completed	\N	1002043696	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.103	362.01	\N	\N	\N	\N	event	964
965	35	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	965
966	35	2013-01-04 17:00:00	2013-01-04 18:00:00	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	966
967	35	2013-02-02 17:00:00	2013-02-02 18:00:00	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	967
968	35	2013-01-04 17:30:00	\N	4107185	completed	\N	4008573	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	111513000	\N	\N	\N	\N	event	968
969	35	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	969
970	35	2013-01-04 17:00:00	2013-01-04 18:00:00	2313633	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	970
958	35	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	958
986	36	2013-02-02 17:30:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	986
1003	36	2013-02-14 17:00:00	2013-02-14 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1003
1002	36	2013-02-02 17:00:00	2013-02-02 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1002
1001	36	2013-02-14 17:00:00	2013-02-14 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1001
1000	36	2013-02-02 17:00:00	2013-02-02 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1000
999	36	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	999
998	36	2013-02-02 17:30:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	998
997	36	2013-02-14 17:00:00	2013-02-14 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	997
996	36	2013-02-02 17:00:00	2013-02-02 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	996
995	36	2013-02-14 17:00:00	2013-02-14 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	995
994	36	2013-02-02 17:00:00	2013-02-02 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	994
993	36	2013-02-14 17:00:00	2013-02-14 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	993
992	36	2013-02-02 17:00:00	2013-02-02 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	992
991	36	2013-02-14 17:00:00	2013-02-14 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	991
990	36	2013-02-02 17:00:00	2013-02-02 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	990
989	36	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	989
988	36	2013-02-02 17:30:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	988
987	36	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	987
985	36	2013-02-02 18:00:00	2013-02-02 18:00:00	40171526	completed	\N	\N	supply	completed	{2.16.840.1.113883.10.20.24.3.45,2.16.840.1.113883.10.20.22.4.18}	\N	\N	\N	\N	\N	\N	event	985
984	36	2013-02-14 17:00:00	2013-02-14 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	984
983	36	2013-02-02 17:00:00	2013-02-02 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	983
982	36	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	982
981	36	2013-02-02 17:30:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	981
980	36	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	980
979	36	2013-02-02 17:30:00	\N	4107185	completed	\N	4031328	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	14183003	\N	\N	\N	\N	event	979
978	36	2013-02-14 17:00:00	2013-02-14 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	978
977	36	2013-02-02 17:00:00	2013-02-02 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	977
976	36	2013-02-14 17:00:00	2013-02-14 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	976
975	36	2013-02-02 17:00:00	2013-02-02 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	975
974	36	2013-02-14 17:00:00	2013-02-14 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	974
973	36	2013-02-02 17:00:00	2013-02-02 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	973
972	36	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	972
1035	37	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1035
1048	37	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1048
1047	37	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1047
1046	37	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1046
1045	37	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1045
1044	37	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1044
1043	37	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1043
1042	37	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1042
1041	37	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1041
1040	37	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1040
1039	37	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1039
1038	37	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1038
1037	37	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1037
1036	37	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1036
1034	37	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1034
1033	37	2013-03-26 16:00:00	\N	4107185	completed	\N	79740	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	109838007	\N	\N	\N	\N	event	1033
1032	37	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1032
1031	37	2013-03-26 16:00:00	\N	4107185	completed	\N	4116087	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	254900004	\N	\N	\N	\N	event	1031
1030	37	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1030
1029	37	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1029
1028	37	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1028
1027	37	2013-03-26 16:00:00	\N	4107185	completed	\N	79740	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	109838007	\N	\N	\N	\N	event	1027
1026	37	2013-04-23 16:00:00	2013-04-23 16:30:00	3016766	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.22.4.13,2.16.840.1.113883.10.20.24.3.18}	\N	\N	\N	\N	\N	\N	event	1026
1025	37	2013-03-26 15:30:00	2013-03-26 15:30:00	3007273	completed	\N	6	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	1025
1024	37	2013-03-26 16:00:00	2013-03-26 16:00:00	3032943	completed	\N	4	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	1024
1023	37	2013-04-23 16:45:00	2013-04-23 17:00:00	4223087	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	1023
1022	37	2013-04-23 16:30:00	2013-04-23 17:00:00	4020571	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	1022
1021	37	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1021
1020	37	2013-03-26 16:00:00	\N	4107185	completed	\N	4116087	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	254900004	\N	\N	\N	\N	event	1020
1019	37	2013-04-23 16:45:00	2013-04-23 17:00:00	4223087	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	1019
1018	37	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1018
1017	37	2013-03-26 16:00:00	\N	4107185	completed	\N	79740	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	109838007	\N	\N	\N	\N	event	1017
1016	37	2013-03-26 16:00:00	2013-03-26 16:00:00	4022145	completed	\N	1002014003	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.87}	2.16.840.1.113883.6.96	433361000124104	\N	\N	\N	\N	event	1016
1015	37	2013-03-26 16:00:00	2013-03-26 16:30:00	4022145	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.22.4.14,2.16.840.1.113883.10.20.24.3.66}	\N	\N	\N	\N	\N	\N	event	1015
1014	37	2013-03-26 16:00:00	2013-03-26 16:00:00	4022145	completed	\N	1002013539	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.87}	2.16.840.1.113883.6.96	433491000124102	\N	\N	\N	\N	event	1014
1013	37	2013-03-26 16:00:00	2013-03-26 16:30:00	4022145	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.22.4.14,2.16.840.1.113883.10.20.24.3.66}	\N	\N	\N	\N	\N	\N	event	1013
1012	37	2013-03-26 16:00:00	2013-03-26 16:00:00	4022145	completed	\N	1002026051	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.87}	2.16.840.1.113883.6.96	433571000124104	\N	\N	\N	\N	event	1012
1011	37	2013-03-26 16:00:00	2013-03-26 16:30:00	4022145	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.22.4.14,2.16.840.1.113883.10.20.24.3.66}	\N	\N	\N	\N	\N	\N	event	1011
1010	37	2013-03-26 16:00:00	2013-03-26 16:00:00	4022145	completed	\N	1002012575	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.87}	2.16.840.1.113883.6.96	433581000124101	\N	\N	\N	\N	event	1010
1009	37	2013-03-26 16:00:00	2013-03-26 16:30:00	4022145	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.22.4.14,2.16.840.1.113883.10.20.24.3.66}	\N	\N	\N	\N	\N	\N	event	1009
1008	37	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1008
1007	37	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1007
1006	37	2013-04-23 16:00:00	2013-04-23 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1006
1005	37	2013-03-26 15:30:00	2013-03-26 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1005
1004	37	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	1004
1068	38	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1068
1067	38	2013-07-01 14:00:00	\N	4107185	completed	\N	4028741	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	10725009	\N	\N	\N	\N	event	1067
1066	38	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1066
1065	38	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1065
1064	38	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1064
1063	38	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1063
1062	38	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1062
1073	38	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1073
1072	38	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1072
1071	38	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1071
1060	38	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1060
1061	38	2013-03-01 17:05:00	\N	4107185	completed	\N	133419	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	109267002	\N	\N	\N	\N	event	1061
1059	38	2013-07-01 14:00:00	\N	4107185	completed	\N	4028741	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	10725009	\N	\N	\N	\N	event	1059
1058	38	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1058
1057	38	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1057
1056	38	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1056
1055	38	2013-03-01 17:05:00	\N	4107185	completed	\N	4004279	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	10091002	\N	\N	\N	\N	event	1055
1054	38	2013-07-01 14:00:00	2013-07-01 17:00:00	4032243	completed	\N	\N	procedure	completed	{2.16.840.1.113883.10.20.24.3.64,2.16.840.1.113883.10.20.22.4.14}	\N	\N	\N	\N	\N	\N	event	1054
1053	38	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1053
1052	38	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1052
1051	38	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1051
1050	38	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1050
1074	38	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1074
1049	38	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	1049
1070	38	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1070
1069	38	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1069
1078	38	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1078
1077	38	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1077
1076	38	2013-07-01 14:00:00	2013-07-01 15:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1076
1075	38	2013-03-01 17:00:00	2013-03-01 18:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1075
1082	39	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1082
1094	39	2013-03-01 16:00:00	2013-03-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1094
1093	39	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1093
1095	39	2013-07-01 15:00:00	2013-07-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1095
1096	39	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1096
1097	39	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1097
1098	39	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1098
1099	39	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1099
1100	39	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1100
1101	39	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1101
1102	39	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1102
1103	39	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1103
1104	39	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1104
1105	39	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1105
1106	39	2013-07-01 15:00:00	2013-07-01 15:00:00	3028167	completed	\N	150	observation	completed	{2.16.840.1.113883.10.20.22.4.2,2.16.840.1.113883.10.20.24.3.40}	\N	\N	\N	\N	\N	\N	event	1106
1107	39	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1107
1108	39	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1108
1092	39	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1092
1091	39	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1091
1090	39	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1090
1089	39	\N	\N	3030068	completed	\N	9181	observation	completed	{2.16.840.1.113883.10.20.22.4.6,2.16.840.1.113883.10.20.24.3.94}	2.16.840.1.113883.6.96	55561003	\N	\N	\N	\N	event	1089
1088	39	2013-03-01 16:30:00	\N	4107185	completed	\N	4008081	observation	completed	{2.16.840.1.113883.10.20.22.4.4,2.16.840.1.113883.10.20.24.3.11}	2.16.840.1.113883.6.96	111880001	\N	\N	\N	\N	event	1088
1087	39	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1087
1086	39	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1086
1085	39	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1085
1084	39	2013-03-01 16:00:00	2013-03-01 17:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1084
1083	39	2013-07-01 15:00:00	2013-07-01 16:00:00	4085799	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1083
1081	39	2013-07-01 15:00:00	2013-07-01 16:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1081
1080	39	2013-03-01 16:00:00	2013-03-01 17:00:00	2414390	completed	\N	\N	encounter	completed	{2.16.840.1.113883.10.20.22.4.49,2.16.840.1.113883.10.20.24.3.23}	\N	\N	\N	\N	\N	\N	event	1080
1079	39	2008-01-01 05:00:00	\N	3048872	completed	\N	\N	observation	completed	{2.16.840.1.113883.10.20.24.3.55}	2.16.840.1.113883.3.221.5	349	\N	\N	\N	\N	event	1079
\.


--
-- Data for Name: individual_characteristic; Type: TABLE DATA; Schema: hqmf_cypress_ep; Owner: -
--

COPY individual_characteristic (patient_id, start_dt, end_dt, code, status, negation, value, audit_key_type, audit_key_value) FROM stdin;
0	1992-02-01 10:30:00	\N	8507	\N	\N	M	patient_data	0
0	1992-02-01 10:30:00	\N	3022007	\N	\N	\N	patient_data	0
0	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	1
0	1992-02-01 10:30:00	\N	4083591	\N	\N	01730	patient_data	0
1	1998-10-31 17:00:00	\N	8532	\N	\N	F	patient_data	1
1	1998-10-31 17:00:00	\N	3022007	\N	\N	\N	patient_data	1
1	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	320
1	1998-10-31 17:00:00	\N	4083591	\N	\N	01730	patient_data	1
2	1989-12-01 15:00:00	\N	8532	\N	\N	F	patient_data	2
2	1989-12-01 15:00:00	\N	3022007	\N	\N	\N	patient_data	2
2	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	785
2	1989-12-01 15:00:00	\N	4083591	\N	\N	01730	patient_data	2
3	1992-02-01 15:00:00	\N	8507	\N	\N	M	patient_data	3
3	1992-02-01 15:00:00	\N	3022007	\N	\N	\N	patient_data	3
3	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	1109
3	1992-02-01 15:00:00	\N	4083591	\N	\N	01730	patient_data	3
4	1942-02-01 15:00:00	\N	8507	\N	\N	M	patient_data	4
4	1942-02-01 15:00:00	\N	3022007	\N	\N	\N	patient_data	4
4	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	1159
4	1942-02-01 15:00:00	\N	4083591	\N	\N	01730	patient_data	4
5	1996-02-02 06:33:15	\N	8532	\N	\N	F	patient_data	5
5	1996-02-02 06:33:15	\N	3022007	\N	\N	\N	patient_data	5
5	2008-01-01 20:33:15	\N	3048872	completed	\N	349	event	1178
5	1996-02-02 06:33:15	\N	4083591	\N	\N	01730	patient_data	5
6	1946-01-03 14:00:00	\N	8507	\N	\N	M	patient_data	6
6	1946-01-03 14:00:00	\N	3022007	\N	\N	\N	patient_data	6
6	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	1204
6	1946-01-03 14:00:00	\N	4083591	\N	\N	01730	patient_data	6
7	1988-08-01 14:00:00	\N	8507	\N	\N	M	patient_data	7
7	1988-08-01 14:00:00	\N	3022007	\N	\N	\N	patient_data	7
7	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	1267
7	1988-08-01 14:00:00	\N	4083591	\N	\N	01730	patient_data	7
8	1943-02-01 15:00:00	\N	8507	\N	\N	M	patient_data	8
8	1943-02-01 15:00:00	\N	3022007	\N	\N	\N	patient_data	8
8	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	1313
8	1943-02-01 15:00:00	\N	4083591	\N	\N	01730	patient_data	8
9	2001-02-01 15:00:00	\N	8532	\N	\N	F	patient_data	9
9	2001-02-01 15:00:00	\N	3022007	\N	\N	\N	patient_data	9
9	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	1374
9	2001-02-01 15:00:00	\N	4083591	\N	\N	01730	patient_data	9
10	1942-02-02 19:48:14	\N	8507	\N	\N	M	patient_data	10
10	1942-02-02 19:48:14	\N	3022007	\N	\N	\N	patient_data	10
10	2008-01-02 09:48:14	\N	3048872	completed	\N	349	event	34
10	1942-02-02 19:48:14	\N	4083591	\N	\N	01730	patient_data	10
11	2003-02-01 15:00:00	\N	8532	\N	\N	F	patient_data	11
11	2003-02-01 15:00:00	\N	3022007	\N	\N	\N	patient_data	11
11	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	53
11	2003-02-01 15:00:00	\N	4083591	\N	\N	01730	patient_data	11
12	2011-06-18 14:00:00	\N	8507	\N	\N	M	patient_data	12
12	2011-06-18 14:00:00	\N	3022007	\N	\N	\N	patient_data	12
12	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	99
12	2011-06-18 14:00:00	\N	4083591	\N	\N	01730	patient_data	12
13	1996-02-01 15:00:00	\N	8532	\N	\N	F	patient_data	13
13	1996-02-01 15:00:00	\N	3022007	\N	\N	\N	patient_data	13
13	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	110
13	1996-02-01 15:00:00	\N	4083591	\N	\N	01730	patient_data	13
14	1996-02-01 15:00:00	\N	8532	\N	\N	F	patient_data	14
14	1996-02-01 15:00:00	\N	3022007	\N	\N	\N	patient_data	14
14	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	155
14	1996-02-01 15:00:00	\N	4083591	\N	\N	01730	patient_data	14
15	1983-02-01 09:30:00	\N	8532	\N	\N	F	patient_data	15
15	1983-02-01 09:30:00	\N	3022007	\N	\N	\N	patient_data	15
15	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	181
15	1983-02-01 09:30:00	\N	4083591	\N	\N	01730	patient_data	15
16	1983-02-01 15:00:00	\N	8532	\N	\N	F	patient_data	16
16	1983-02-01 15:00:00	\N	3022007	\N	\N	\N	patient_data	16
16	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	211
16	1983-02-01 15:00:00	\N	4083591	\N	\N	01730	patient_data	16
17	1963-09-01 14:00:00	\N	8532	\N	\N	F	patient_data	17
17	1963-09-01 14:00:00	\N	3022007	\N	\N	\N	patient_data	17
17	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	228
17	1963-09-01 14:00:00	\N	4083591	\N	\N	01730	patient_data	17
18	1963-09-01 14:00:00	\N	8532	\N	\N	F	patient_data	18
18	1963-09-01 14:00:00	\N	3022007	\N	\N	\N	patient_data	18
18	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	260
18	1963-09-01 14:00:00	\N	4083591	\N	\N	01730	patient_data	18
19	1971-01-01 13:30:00	\N	8507	\N	\N	M	patient_data	19
19	1971-01-01 13:30:00	\N	3022007	\N	\N	\N	patient_data	19
19	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	291
19	1971-01-01 13:30:00	\N	4083591	\N	\N	01730	patient_data	19
20	1968-02-01 15:00:00	\N	8532	\N	\N	F	patient_data	20
20	1968-02-01 15:00:00	\N	3022007	\N	\N	\N	patient_data	20
20	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	365
20	1968-02-01 15:00:00	\N	4083591	\N	\N	01730	patient_data	20
21	1989-12-01 15:00:00	\N	8532	\N	\N	F	patient_data	21
21	1989-12-01 15:00:00	\N	3022007	\N	\N	\N	patient_data	21
21	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	397
21	1989-12-01 15:00:00	\N	4083591	\N	\N	01730	patient_data	21
22	2011-06-18 14:00:00	\N	8507	\N	\N	M	patient_data	22
22	2011-06-18 14:00:00	\N	3022007	\N	\N	\N	patient_data	22
22	2008-01-01 05:00:00	\N	3048872	completed	\N	2	event	413
22	2011-06-18 14:00:00	\N	4083591	\N	\N	01730	patient_data	22
24	1943-02-01 11:30:00	\N	8507	\N	\N	M	patient_data	24
24	1943-02-01 11:30:00	\N	3022007	\N	\N	\N	patient_data	24
24	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	528
24	1943-02-01 11:30:00	\N	4083591	\N	\N	01730	patient_data	24
25	2002-02-01 15:00:00	\N	8507	\N	\N	M	patient_data	25
25	2002-02-01 15:00:00	\N	3022007	\N	\N	\N	patient_data	25
25	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	596
25	2002-02-01 15:00:00	\N	4083591	\N	\N	01730	patient_data	25
26	1946-01-03 16:00:00	\N	8507	\N	\N	M	patient_data	26
26	1946-01-03 16:00:00	\N	3022007	\N	\N	\N	patient_data	26
26	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	612
26	1946-01-03 16:00:00	\N	4083591	\N	\N	01730	patient_data	26
27	2003-01-04 15:00:00	\N	8532	\N	\N	F	patient_data	27
27	2003-01-04 15:00:00	\N	3022007	\N	\N	\N	patient_data	27
27	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	661
27	2003-01-04 15:00:00	\N	4083591	\N	\N	01730	patient_data	27
28	2003-01-03 07:28:46	\N	8532	\N	\N	F	patient_data	28
28	2003-01-03 07:28:46	\N	3022007	\N	\N	\N	patient_data	28
28	2007-12-30 21:28:46	\N	3048872	completed	\N	349	event	705
28	2003-01-03 07:28:46	\N	4083591	\N	\N	01730	patient_data	28
29	1989-12-01 03:49:50	\N	8532	\N	\N	F	patient_data	29
29	1989-12-01 03:49:50	\N	3022007	\N	\N	\N	patient_data	29
29	2007-12-31 17:49:50	\N	3048872	completed	\N	349	event	749
29	1989-12-01 03:49:50	\N	4083591	\N	\N	01730	patient_data	29
30	1963-09-08 21:19:18	\N	8532	\N	\N	F	patient_data	30
30	1963-09-08 21:19:18	\N	3022007	\N	\N	\N	patient_data	30
30	2008-01-08 12:19:18	\N	3048872	completed	\N	349	event	821
30	1963-09-08 21:19:18	\N	4083591	\N	\N	01730	patient_data	30
31	2012-11-01 14:00:00	\N	8532	\N	\N	F	patient_data	31
31	2012-11-01 14:00:00	\N	3022007	\N	\N	\N	patient_data	31
31	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	852
31	2012-11-01 14:00:00	\N	4083591	\N	\N	01730	patient_data	31
32	2012-11-01 14:00:00	\N	8532	\N	\N	F	patient_data	32
32	2012-11-01 14:00:00	\N	3022007	\N	\N	\N	patient_data	32
32	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	863
32	2012-11-01 14:00:00	\N	4083591	\N	\N	01730	patient_data	32
33	1973-02-01 15:00:00	\N	8507	\N	\N	M	patient_data	33
33	1973-02-01 15:00:00	\N	3022007	\N	\N	\N	patient_data	33
33	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	875
33	1973-02-01 15:00:00	\N	4083591	\N	\N	01730	patient_data	33
34	1968-02-01 15:00:00	\N	8532	\N	\N	F	patient_data	34
34	1968-02-01 15:00:00	\N	3022007	\N	\N	\N	patient_data	34
34	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	915
34	1968-02-01 15:00:00	\N	4083591	\N	\N	01730	patient_data	34
35	1942-02-01 15:00:00	\N	8507	\N	\N	M	patient_data	35
35	1942-02-01 15:00:00	\N	3022007	\N	\N	\N	patient_data	35
35	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	958
35	1942-02-01 15:00:00	\N	4083591	\N	\N	01730	patient_data	35
36	2002-02-01 15:00:00	\N	8507	\N	\N	M	patient_data	36
36	2002-02-01 15:00:00	\N	3022007	\N	\N	\N	patient_data	36
36	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	972
36	2002-02-01 15:00:00	\N	4083591	\N	\N	01730	patient_data	36
37	1988-08-01 14:00:00	\N	8507	\N	\N	M	patient_data	37
37	1988-08-01 14:00:00	\N	3022007	\N	\N	\N	patient_data	37
37	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	1004
37	1988-08-01 14:00:00	\N	4083591	\N	\N	01730	patient_data	37
38	1938-01-02 15:30:00	\N	8532	\N	\N	F	patient_data	38
38	1938-01-02 15:30:00	\N	3022007	\N	\N	\N	patient_data	38
38	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	1049
38	1938-01-02 15:30:00	\N	4083591	\N	\N	01730	patient_data	38
39	1998-10-31 17:00:00	\N	8532	\N	\N	F	patient_data	39
39	1998-10-31 17:00:00	\N	3022007	\N	\N	\N	patient_data	39
39	2008-01-01 05:00:00	\N	3048872	completed	\N	349	event	1079
39	1998-10-31 17:00:00	\N	4083591	\N	\N	01730	patient_data	39
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: hqmf_cypress_ep; Owner: -
--

COPY patients (patient_id, start_dt, end_dt, code, status, negation, value, audit_key_type, audit_key_value) FROM stdin;
0	\N	\N	\N	\N	\N	\N	patient_data	0
1	\N	\N	\N	\N	\N	\N	patient_data	1
2	\N	\N	\N	\N	\N	\N	patient_data	2
3	\N	\N	\N	\N	\N	\N	patient_data	3
4	\N	\N	\N	\N	\N	\N	patient_data	4
5	\N	\N	\N	\N	\N	\N	patient_data	5
6	\N	\N	\N	\N	\N	\N	patient_data	6
7	\N	\N	\N	\N	\N	\N	patient_data	7
8	\N	\N	\N	\N	\N	\N	patient_data	8
9	\N	\N	\N	\N	\N	\N	patient_data	9
10	\N	\N	\N	\N	\N	\N	patient_data	10
11	\N	\N	\N	\N	\N	\N	patient_data	11
12	\N	\N	\N	\N	\N	\N	patient_data	12
13	\N	\N	\N	\N	\N	\N	patient_data	13
14	\N	\N	\N	\N	\N	\N	patient_data	14
15	\N	\N	\N	\N	\N	\N	patient_data	15
16	\N	\N	\N	\N	\N	\N	patient_data	16
17	\N	\N	\N	\N	\N	\N	patient_data	17
18	\N	\N	\N	\N	\N	\N	patient_data	18
19	\N	\N	\N	\N	\N	\N	patient_data	19
20	\N	\N	\N	\N	\N	\N	patient_data	20
21	\N	\N	\N	\N	\N	\N	patient_data	21
22	\N	\N	\N	\N	\N	\N	patient_data	22
24	\N	\N	\N	\N	\N	\N	patient_data	24
25	\N	\N	\N	\N	\N	\N	patient_data	25
26	\N	\N	\N	\N	\N	\N	patient_data	26
27	\N	\N	\N	\N	\N	\N	patient_data	27
28	\N	\N	\N	\N	\N	\N	patient_data	28
29	\N	\N	\N	\N	\N	\N	patient_data	29
30	\N	\N	\N	\N	\N	\N	patient_data	30
31	\N	\N	\N	\N	\N	\N	patient_data	31
32	\N	\N	\N	\N	\N	\N	patient_data	32
33	\N	\N	\N	\N	\N	\N	patient_data	33
34	\N	\N	\N	\N	\N	\N	patient_data	34
35	\N	\N	\N	\N	\N	\N	patient_data	35
36	\N	\N	\N	\N	\N	\N	patient_data	36
37	\N	\N	\N	\N	\N	\N	patient_data	37
38	\N	\N	\N	\N	\N	\N	patient_data	38
39	\N	\N	\N	\N	\N	\N	patient_data	39
\.


SET search_path = valuesets, pg_catalog;

--
-- Data for Name: arrayed_vocabulary_map; Type: TABLE DATA; Schema: valuesets; Owner: -
--

COPY arrayed_vocabulary_map (hqmf_code_system_oid, overflow_vocabulary_id, vocabulary_ids) FROM stdin;
2.16.840.1.113883.6.285	40125	{40125,5}
2.16.840.1.113883.6.104	40115	{2,40115,3}
2.16.840.1.113883.6.103	40124	{40124,2,3}
2.16.840.1.113883.6.96	40114	{1,40114}
2.16.840.1.113883.12.112	40121	{40121}
2.16.840.1.113883.6.88	40123	{40123,8}
2.16.840.1.113883.5.4	40116	{40113,40116}
2.16.840.1.113883.6.4	40120	{40120,35}
2.16.840.1.113883.12.292	40127	{40127}
2.16.840.1.113883.6.259	40119	{40119}
2.16.840.1.113883.6.90	40126	{34,40126}
2.16.840.1.113883.18.2	40122	{12,40122}
2.16.840.1.113883.6.12	40117	{40117,4}
2.16.840.1.113883.6.1	40118	{6,40118}
\.


--
-- Data for Name: code_lists_value_set_reverse_map; Type: TABLE DATA; Schema: valuesets; Owner: -
--

COPY code_lists_value_set_reverse_map (value_set_oid, value_set_name, code_system, code_system_name, concept_id, concept_code, concept_name, vocabulary_id, vocabulary_name, in_original_value_set) FROM stdin;
\.


--
-- Data for Name: hl7_template_xref; Type: TABLE DATA; Schema: valuesets; Owner: -
--

COPY hl7_template_xref (template_id, template_name) FROM stdin;
\.


--
-- Data for Name: hqmf_code_lists; Type: TABLE DATA; Schema: valuesets; Owner: -
--

COPY hqmf_code_lists (code, code_list_id) FROM stdin;
\.


--
-- Data for Name: med_status_map; Type: TABLE DATA; Schema: valuesets; Owner: -
--

COPY med_status_map (omop_concept_id, hqmf_status) FROM stdin;
\.


--
-- Data for Name: omop_level_2_concept_code_lists; Type: TABLE DATA; Schema: valuesets; Owner: -
--

COPY omop_level_2_concept_code_lists (code, code_list_id) FROM stdin;
\.


--
-- Data for Name: overflow_vocabulary_map; Type: TABLE DATA; Schema: valuesets; Owner: -
--

COPY overflow_vocabulary_map (overflow_vocabulary_name, hqmf_code_system_oid, hqmf_code_system_name, hqmf_code_system_versions) FROM stdin;
\.


--
-- Name: overflow_vocabulary_sequence; Type: SEQUENCE SET; Schema: valuesets; Owner: -
--

SELECT pg_catalog.setval('overflow_vocabulary_sequence', 1, false);


--
-- Data for Name: unified_vocabulary_map; Type: TABLE DATA; Schema: valuesets; Owner: -
--

COPY unified_vocabulary_map (hqmf_code_system_oid, hqmf_code_system_name, hqmf_code_system_versions, omop_vocabulary_id, vocabulary_name, is_overflow_vocabulary) FROM stdin;
2.16.840.1.113883.18.2	AdministrativeSex	{NULL}	40122	hqmf_overflow_AdministrativeSex__3	t
2.16.840.1.113883.6.12	CPT	{NULL}	4	CPT-4	f
2.16.840.1.113883.6.285	HCPCS	{NULL}	5	HCPCS	f
2.16.840.1.113883.12.112	DischargeDisposition	{NULL}	40121	hqmf_overflow_DischargeDisposition__1	t
2.16.840.1.113883.18.2	AdministrativeSex	{NULL}	12	HL7 Administrative Sex	f
2.16.840.1.113883.6.103	ICD-9-CM	{NULL}	3	ICD-9-Procedure	f
2.16.840.1.113883.5.4	HQMF miscellaneous concepts	{NULL}	40116	hqmf_overflow_HQMF miscellaneous concepts__4	t
2.16.840.1.113883.6.259	HL7 Healthcare Service Location	{NULL}	40119	hqmf_overflow_HL7 Healthcare Service Location__9	t
2.16.840.1.113883.6.96	SNOMED-CT	{NULL}	40114	hqmf_overflow_SNOMED-CT__14	t
2.16.840.1.113883.6.104	ICD-9-CM	{NULL}	3	ICD-9-Procedure	f
2.16.840.1.113883.6.104	ICD-9-CM	{NULL,NULL}	40115	hqmf_overflow_ICD-9-CM__7	t
2.16.840.1.113883.6.1	LOINC	{NULL,NULL,NULL}	40118	hqmf_overflow_LOINC__5	t
2.16.840.1.113883.12.292	CVX	{NULL}	40127	hqmf_overflow_CVX__2	t
2.16.840.1.113883.5.4	HQMF miscellaneous concepts	{NULL}	40113	HQMF miscellaneous concepts	f
2.16.840.1.113883.6.90	ICD-10-CM	{NULL}	40126	hqmf_overflow_ICD-10-CM__13	t
2.16.840.1.113883.6.12	CPT	{NULL,NULL,NULL}	40117	hqmf_overflow_CPT__8	t
2.16.840.1.113883.6.103	ICD-9-CM	{NULL}	2	ICD-9-CM	f
2.16.840.1.113883.6.103	ICD-9-CM	{NULL,NULL}	40124	hqmf_overflow_ICD-9-CM__6	t
2.16.840.1.113883.6.1	LOINC	{NULL}	6	LOINC	f
2.16.840.1.113883.6.90	ICD-10-CM	{NULL}	34	ICD-10	f
2.16.840.1.113883.6.88	RxNorm	{NULL}	8	RxNorm	f
2.16.840.1.113883.6.96	SNOMED-CT	{NULL}	1	SNOMED-CT	f
2.16.840.1.113883.6.4	ICD-10-PCS	{NULL}	35	ICD-10-PCS	f
2.16.840.1.113883.6.104	ICD-9-CM	{NULL}	2	ICD-9-CM	f
2.16.840.1.113883.6.285	HCPCS	{NULL}	40125	hqmf_overflow_HCPCS__10	t
2.16.840.1.113883.6.4	ICD-10-PCS	{NULL}	40120	hqmf_overflow_ICD-10-PCS__11	t
2.16.840.1.113883.6.88	RxNorm	{NULL,NULL}	40123	hqmf_overflow_RxNorm__12	t
\.


--
-- Data for Name: value_code_xref; Type: TABLE DATA; Schema: valuesets; Owner: -
--

COPY value_code_xref (code, code_system, code_system_name, display_name, concept_id, concept_name) FROM stdin;
\.


--
-- Data for Name: value_set_code_systems; Type: TABLE DATA; Schema: valuesets; Owner: -
--

COPY value_set_code_systems (value_set_oid, code_system, code_system_name) FROM stdin;
\.


--
-- Data for Name: value_set_code_xref; Type: TABLE DATA; Schema: valuesets; Owner: -
--

COPY value_set_code_xref (value_set_name, value_set_oid, code_system, code, code_system_name, display_name, concept_id, concept_name) FROM stdin;
\.


--
-- Data for Name: value_set_entries; Type: TABLE DATA; Schema: valuesets; Owner: -
--

COPY value_set_entries (value_set_entry_id, value_set_oid, code, code_system, code_system_name, code_system_version, display_name, black_list, white_list) FROM stdin;
\.


--
-- Name: value_set_entries_value_set_entry_id_seq; Type: SEQUENCE SET; Schema: valuesets; Owner: -
--

SELECT pg_catalog.setval('value_set_entries_value_set_entry_id_seq', 1, false);


--
-- Data for Name: value_set_sanity_checks; Type: TABLE DATA; Schema: valuesets; Owner: -
--

COPY value_set_sanity_checks (test_name, passed) FROM stdin;
\.


--
-- Data for Name: value_sets; Type: TABLE DATA; Schema: valuesets; Owner: -
--

COPY value_sets (value_set_oid, value_set_name, value_set_version) FROM stdin;
\.


--
-- Data for Name: vocabulary_map; Type: TABLE DATA; Schema: valuesets; Owner: -
--

COPY vocabulary_map (hqmf_code_system_oid, hqmf_code_system_name, hqmf_code_system_version, omop_vocabulary_id) FROM stdin;
\.


SET search_path = hqmf_cypress_ep, pg_catalog;

--
-- Name: generic_hqmf_event_pkey; Type: CONSTRAINT; Schema: hqmf_cypress_ep; Owner: -; Tablespace: 
--

ALTER TABLE ONLY generic_hqmf_event
    ADD CONSTRAINT generic_hqmf_event_pkey PRIMARY KEY (event_id);


--
-- Name: patients_pkey; Type: CONSTRAINT; Schema: hqmf_cypress_ep; Owner: -; Tablespace: 
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (patient_id);

ALTER TABLE patients CLUSTER ON patients_pkey;


SET search_path = valuesets, pg_catalog;

--
-- Name: overflow_vocabulary_map_hqmf_code_system_oid_key; Type: CONSTRAINT; Schema: valuesets; Owner: -; Tablespace: 
--

ALTER TABLE ONLY overflow_vocabulary_map
    ADD CONSTRAINT overflow_vocabulary_map_hqmf_code_system_oid_key UNIQUE (hqmf_code_system_oid);


--
-- Name: overflow_vocabulary_map_pkey; Type: CONSTRAINT; Schema: valuesets; Owner: -; Tablespace: 
--

ALTER TABLE ONLY overflow_vocabulary_map
    ADD CONSTRAINT overflow_vocabulary_map_pkey PRIMARY KEY (overflow_vocabulary_name);


--
-- Name: value_set_code_systems_pkey; Type: CONSTRAINT; Schema: valuesets; Owner: -; Tablespace: 
--

ALTER TABLE ONLY value_set_code_systems
    ADD CONSTRAINT value_set_code_systems_pkey PRIMARY KEY (value_set_oid, code_system);

ALTER TABLE value_set_code_systems CLUSTER ON value_set_code_systems_pkey;


--
-- Name: value_set_entries_pkey; Type: CONSTRAINT; Schema: valuesets; Owner: -; Tablespace: 
--

ALTER TABLE ONLY value_set_entries
    ADD CONSTRAINT value_set_entries_pkey PRIMARY KEY (value_set_entry_id);


--
-- Name: value_set_entries_value_set_oid_code_system_code_key; Type: CONSTRAINT; Schema: valuesets; Owner: -; Tablespace: 
--

ALTER TABLE ONLY value_set_entries
    ADD CONSTRAINT value_set_entries_value_set_oid_code_system_code_key UNIQUE (value_set_oid, code_system, code);


--
-- Name: value_sets_pkey; Type: CONSTRAINT; Schema: valuesets; Owner: -; Tablespace: 
--

ALTER TABLE ONLY value_sets
    ADD CONSTRAINT value_sets_pkey PRIMARY KEY (value_set_oid);


SET search_path = hqmf_cypress_ep, pg_catalog;

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


--
-- Name: individual_characteristic_patient_id_code; Type: INDEX; Schema: hqmf_cypress_ep; Owner: -; Tablespace: 
--

CREATE INDEX individual_characteristic_patient_id_code ON individual_characteristic USING btree (patient_id, code);

ALTER TABLE individual_characteristic CLUSTER ON individual_characteristic_patient_id_code;


SET search_path = valuesets, pg_catalog;

--
-- Name: code_lists_value_set_reverse_map_code_system_value_set_oid_idx; Type: INDEX; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE INDEX code_lists_value_set_reverse_map_code_system_value_set_oid_idx ON code_lists_value_set_reverse_map USING btree (code_system, value_set_oid);

ALTER TABLE code_lists_value_set_reverse_map CLUSTER ON code_lists_value_set_reverse_map_code_system_value_set_oid_idx;


--
-- Name: code_lists_value_set_reverse_map_in_original_value_set_idx; Type: INDEX; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE INDEX code_lists_value_set_reverse_map_in_original_value_set_idx ON code_lists_value_set_reverse_map USING btree (in_original_value_set);


--
-- Name: hqmf_code_lists_code_idx; Type: INDEX; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE INDEX hqmf_code_lists_code_idx ON hqmf_code_lists USING btree (code);

ALTER TABLE hqmf_code_lists CLUSTER ON hqmf_code_lists_code_idx;


--
-- Name: hqmf_code_lists_code_list_id_idx; Type: INDEX; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE INDEX hqmf_code_lists_code_list_id_idx ON hqmf_code_lists USING btree (code_list_id);


--
-- Name: value_code_xref_code_system_code_idx; Type: INDEX; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE INDEX value_code_xref_code_system_code_idx ON value_code_xref USING btree (code_system, code);

ALTER TABLE value_code_xref CLUSTER ON value_code_xref_code_system_code_idx;


--
-- Name: value_set_entries_code; Type: INDEX; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE INDEX value_set_entries_code ON value_set_entries USING btree (code);


--
-- Name: value_set_entries_code_system_name_version_code; Type: INDEX; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE INDEX value_set_entries_code_system_name_version_code ON value_set_entries USING btree (code_system_name, code_system_version, code);


--
-- Name: value_set_entries_code_system_value_set_code; Type: INDEX; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE INDEX value_set_entries_code_system_value_set_code ON value_set_entries USING btree (code_system, value_set_oid, code);

ALTER TABLE value_set_entries CLUSTER ON value_set_entries_code_system_value_set_code;


--
-- Name: value_set_entries_code_system_version_code; Type: INDEX; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE INDEX value_set_entries_code_system_version_code ON value_set_entries USING btree (code_system, code_system_version, code);


--
-- Name: value_set_entries_value_set_oid; Type: INDEX; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE INDEX value_set_entries_value_set_oid ON value_set_entries USING btree (value_set_oid);


--
-- Name: vocabulary_map_hqmf_idx; Type: INDEX; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE INDEX vocabulary_map_hqmf_idx ON vocabulary_map USING btree (hqmf_code_system_oid, hqmf_code_system_version);


--
-- Name: value_set_entries_value_set_oid_fkey; Type: FK CONSTRAINT; Schema: valuesets; Owner: -
--

ALTER TABLE ONLY value_set_entries
    ADD CONSTRAINT value_set_entries_value_set_oid_fkey FOREIGN KEY (value_set_oid) REFERENCES value_sets(value_set_oid);


--
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

