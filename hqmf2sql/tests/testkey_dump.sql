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
-- Name: answer_key; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA answer_key;


SET search_path = answer_key, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: measure_117_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_117_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: patient_xref; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE patient_xref (
    patient_id integer,
    lastname text,
    firstname text
);


--
-- Name: measure_117_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_117_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_117_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_122_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_122_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_122_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_122_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_122_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_123_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_123_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_123_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_123_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_123_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_124_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_124_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_124_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_124_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_124_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_125_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_125_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_125_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_125_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_125_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_126_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_126_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_126_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_126_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_126_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_126_1; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_126_1 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_126_1_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_126_1_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_126_1 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_126_2; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_126_2 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_126_2_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_126_2_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_126_2 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_126_3; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_126_3 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_126_3_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_126_3_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_126_3 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_126_4; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_126_4 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_126_4_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_126_4_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_126_4 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_127_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_127_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_127_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_127_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_127_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_128_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_128_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_128_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_128_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_128_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_128_1; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_128_1 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_128_1_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_128_1_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_128_1 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_129_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_129_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_129_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_129_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_129_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_130_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_130_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_130_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_130_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_130_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_131_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_131_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_131_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_131_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_131_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_132_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_132_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_132_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_132_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_132_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_133_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_133_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_133_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_133_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_133_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_134_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_134_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_134_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_134_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_134_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_135_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_135_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_135_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_135_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_135_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_136_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_136_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_136_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_136_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_136_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_136_1; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_136_1 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_136_1_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_136_1_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_136_1 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_137_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_137_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_137_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_137_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_137_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_137_1; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_137_1 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_137_1_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_137_1_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_137_1 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_137_2; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_137_2 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_137_2_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_137_2_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_137_2 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_137_3; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_137_3 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_137_3_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_137_3_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_137_3 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_137_4; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_137_4 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_137_4_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_137_4_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_137_4 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_137_5; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_137_5 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_137_5_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_137_5_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_137_5 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_138_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_138_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_138_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_138_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_138_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_139_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_139_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_139_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_139_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_139_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_140_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_140_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_140_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_140_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_140_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_141_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_141_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_141_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_141_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_141_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_142_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_142_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_142_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_142_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_142_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_143_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_143_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_143_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_143_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_143_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_144_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_144_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_144_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_144_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_144_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_145_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_145_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_145_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_145_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_145_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_145_1; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_145_1 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_145_1_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_145_1_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_145_1 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_146_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_146_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_146_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_146_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_146_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_147_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_147_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_147_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_147_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_147_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_148_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_148_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_148_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_148_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_148_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_149_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_149_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_149_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_149_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_149_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_153_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_153_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_153_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_153_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_153_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_153_1; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_153_1 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_153_1_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_153_1_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_153_1 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_153_2; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_153_2 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_153_2_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_153_2_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_153_2 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_154_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_154_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_154_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_154_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_154_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_155_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_155_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_155_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_155_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_155_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_155_1; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_155_1 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_155_1_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_155_1_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_155_1 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_155_2; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_155_2 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_155_2_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_155_2_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_155_2 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_155_3; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_155_3 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_155_3_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_155_3_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_155_3 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_155_4; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_155_4 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_155_4_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_155_4_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_155_4 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_155_5; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_155_5 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_155_5_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_155_5_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_155_5 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_155_6; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_155_6 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_155_6_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_155_6_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_155_6 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_155_7; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_155_7 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_155_7_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_155_7_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_155_7 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_155_8; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_155_8 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_155_8_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_155_8_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_155_8 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_156_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_156_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_156_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_156_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_156_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_156_1; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_156_1 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_156_1_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_156_1_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_156_1 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_157_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_157_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_157_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_157_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_157_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_158_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_158_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_158_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_158_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_158_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_159_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_159_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_159_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_159_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_159_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_160_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_160_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_160_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_160_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_160_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_160_1; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_160_1 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_160_1_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_160_1_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_160_1 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_160_2; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_160_2 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_160_2_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_160_2_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_160_2 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_161_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_161_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_161_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_161_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_161_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_163_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_163_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_163_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_163_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_163_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_164_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_164_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_164_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_164_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_164_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_165_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_165_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_165_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_165_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_165_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_166_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_166_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_166_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_166_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_166_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_167_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_167_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_167_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_167_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_167_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_169_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_169_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_169_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_169_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_169_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_177_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_177_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_177_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_177_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_177_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_182_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_182_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_182_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_182_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_182_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_182_1; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_182_1 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_182_1_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_182_1_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_182_1 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_22_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_22_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_22_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_22_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_22_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_2_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_2_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_2_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_2_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_2_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_50_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_50_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_50_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_50_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_50_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_52_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_52_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_52_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_52_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_52_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_52_1; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_52_1 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_52_1_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_52_1_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_52_1 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_52_2; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_52_2 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_52_2_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_52_2_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_52_2 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_56_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_56_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_56_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_56_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_56_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_61_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_61_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_61_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_61_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_61_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_61_1; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_61_1 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_61_1_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_61_1_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_61_1 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_61_2; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_61_2 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_61_2_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_61_2_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_61_2 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_62_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_62_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_62_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_62_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_62_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_64_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_64_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_64_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_64_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_64_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_64_1; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_64_1 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_64_1_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_64_1_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_64_1 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_64_2; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_64_2 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_64_2_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_64_2_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_64_2 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_65_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_65_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_65_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_65_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_65_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_66_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_66_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_66_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_66_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_66_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_68_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_68_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_68_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_68_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_68_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_69_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_69_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_69_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_69_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_69_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_69_1; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_69_1 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_69_1_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_69_1_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_69_1 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_74_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_74_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_74_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_74_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_74_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_74_1; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_74_1 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_74_1_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_74_1_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_74_1 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_74_2; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_74_2 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_74_2_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_74_2_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_74_2 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_74_3; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_74_3 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_74_3_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_74_3_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_74_3 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_75_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_75_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_75_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_75_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_75_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_77_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_77_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_77_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_77_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_77_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_82_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_82_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_82_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_82_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_82_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: measure_90_0; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE measure_90_0 (
    ipp boolean,
    denom boolean,
    denex boolean,
    numer boolean,
    denexcep boolean,
    "out" boolean,
    lastname text,
    firstname text,
    dob date,
    gender text,
    patient_url text
);


--
-- Name: measure_90_0_patient_summary; Type: VIEW; Schema: answer_key; Owner: -
--

CREATE VIEW measure_90_0_patient_summary AS
 SELECT m.patient_id,
    k.ipp AS effective_ipp,
    k.denom AS effective_denom,
    k.denex AS effective_denex,
    k.numer AS effective_numer,
    k.denexcep AS effective_denexcep
   FROM (measure_90_0 k
     JOIN patient_xref m ON (((k.lastname = m.lastname) AND (k.firstname = m.firstname))));


--
-- Name: totals_key; Type: TABLE; Schema: answer_key; Owner: -; Tablespace: 
--

CREATE TABLE totals_key (
    cms_name text,
    total_ipp integer,
    total_denom integer,
    total_denex integer,
    total_numer integer,
    total_denexcep integer,
    long_name text,
    relative_url text,
    measure_name text
);


--
-- Data for Name: measure_117_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_117_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Hart	Marcus	2012-06-18	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00030e
t	t	f	t	f	f	Mcdaniel	Theodore	2012-06-18	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00034c
\.


--
-- Data for Name: measure_122_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_122_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Campbell	Darlene	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00038c
t	t	f	f	f	t	Massey	Jacqueline	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000063
t	t	f	t	f	f	Potter	Gail	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00018b
\.


--
-- Data for Name: measure_123_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_123_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Campbell	Darlene	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00038c
t	t	f	f	f	t	Massey	Jacqueline	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000063
t	t	f	t	f	f	Potter	Gail	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00018b
\.


--
-- Data for Name: measure_124_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_124_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Allen	Georgia	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000148
t	t	f	f	f	t	Campbell	Darlene	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00038c
t	t	f	f	f	t	Crawford	Velma	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00008e
t	t	f	f	f	t	Griffith	Katherine	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00002c
t	t	f	f	f	t	Harrington	Pamela	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000107
t	t	f	t	f	f	Hill	Ana	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001e5
t	t	f	f	f	t	Massey	Jacqueline	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000063
t	t	f	f	f	t	Mccarthy	Catherine	1990-11-28	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003de
t	t	f	f	f	t	Potter	Gail	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00018b
t	t	f	f	f	t	Richardson	Juanita	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000296
\.


--
-- Data for Name: measure_125_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_125_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Allen	Georgia	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000148
t	t	f	f	f	t	Crawford	Velma	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00008e
t	t	f	f	f	t	Griffith	Katherine	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00002c
t	t	f	t	f	f	Hill	Ana	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001e5
t	t	f	f	f	t	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
\.


--
-- Data for Name: measure_126_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_126_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	t	f	f	f	Barnes	Janet	2003-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002de
t	t	f	f	f	t	Jordan	Sherri	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000b8
t	t	f	t	f	f	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
\.


--
-- Data for Name: measure_126_1; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_126_1 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	t	f	f	f	Barnes	Janet	2003-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002de
\.


--
-- Data for Name: measure_126_2; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_126_2 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Jordan	Sherri	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000b8
t	t	f	t	f	f	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
\.


--
-- Data for Name: measure_126_3; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_126_3 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
\.


--
-- Data for Name: measure_126_4; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_126_4 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
\.


--
-- Data for Name: measure_127_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_127_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	f	f	f	t	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	t	f	f	f	t	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	f	f	t	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	t	f	t	f	f	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
\.


--
-- Data for Name: measure_128_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_128_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Goodman	Philip	1992-01-07	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000308
t	t	f	f	f	t	Ramirez	Eugene	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002a5
\.


--
-- Data for Name: measure_128_1; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_128_1 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Goodman	Philip	1992-01-07	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000308
t	t	f	f	f	t	Ramirez	Eugene	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002a5
\.


--
-- Data for Name: measure_129_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_129_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Lee	John	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000173
t	t	f	f	f	t	Singleton	Jimmy	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00004c
t	t	f	f	f	t	Stephens	Miguel	1989-08-04	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00036c
\.


--
-- Data for Name: measure_130_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_130_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	f	f	f	t	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	t	f	f	f	t	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	f	f	t	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	t	f	t	f	f	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
\.


--
-- Data for Name: measure_131_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_131_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Campbell	Darlene	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00038c
t	t	f	f	f	t	Massey	Jacqueline	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000063
t	t	f	t	f	f	Potter	Gail	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00018b
\.


--
-- Data for Name: measure_132_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_132_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Mullins	Howard	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001b9
t	t	f	f	f	t	Zimmerman	Glen	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000080
\.


--
-- Data for Name: measure_133_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_133_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Mullins	Howard	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001b9
t	t	f	f	f	t	Zimmerman	Glen	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000080
\.


--
-- Data for Name: measure_134_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_134_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Campbell	Darlene	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00038c
t	t	f	f	f	t	Massey	Jacqueline	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000063
t	t	f	t	f	f	Potter	Gail	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00018b
\.


--
-- Data for Name: measure_135_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_135_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	f	f	f	f	f	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	t	f	t	f	f	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	f	f	f	f	f	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	f	f	f	f	f	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
\.


--
-- Data for Name: measure_136_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_136_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	t	f	f	f	Barnes	Janet	2003-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002de
t	t	f	t	f	f	Collins	Andy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000136
\.


--
-- Data for Name: measure_136_1; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_136_1 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
\.


--
-- Data for Name: measure_137_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_137_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	t	f	f	f	t	Singleton	Clinton	1972-01-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000016
\.


--
-- Data for Name: measure_137_1; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_137_1 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	t	f	f	f	t	Singleton	Clinton	1972-01-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000016
\.


--
-- Data for Name: measure_137_2; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_137_2 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
\.


--
-- Data for Name: measure_137_3; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_137_3 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	t	f	f	f	t	Singleton	Clinton	1972-01-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000016
\.


--
-- Data for Name: measure_137_4; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_137_4 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
\.


--
-- Data for Name: measure_137_5; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_137_5 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	t	f	f	f	t	Singleton	Clinton	1972-01-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000016
\.


--
-- Data for Name: measure_138_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_138_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Allen	Georgia	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000148
t	t	f	f	f	t	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	f	f	f	t	Crawford	Velma	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00008e
t	t	f	f	f	t	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	t	f	f	f	t	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	t	f	f	f	t	Griffith	Katherine	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00002c
t	t	f	f	t	t	Hampton	Johnnie	1974-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002f2
t	t	f	f	f	t	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	t	f	f	Hill	Ana	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001e5
t	t	f	f	f	t	Lee	John	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000173
t	t	f	f	f	t	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	f	f	t	Mccarthy	Catherine	1990-11-28	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003de
t	t	f	f	f	t	Mullins	Howard	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001b9
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	t	f	f	f	t	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
t	t	f	f	f	t	Richardson	Juanita	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000296
t	t	f	f	f	t	Singleton	Jimmy	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00004c
t	t	f	f	f	t	Stephens	Miguel	1989-08-04	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00036c
t	t	f	f	f	t	Zimmerman	Glen	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000080
\.


--
-- Data for Name: measure_139_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_139_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	f	f	f	t	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	t	f	f	f	t	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	f	f	t	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	f	f	t	Mullins	Howard	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001b9
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	t	f	t	f	f	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
t	t	f	f	f	t	Zimmerman	Glen	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000080
\.


--
-- Data for Name: measure_140_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_140_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Allen	Georgia	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000148
t	t	f	f	f	t	Griffith	Katherine	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00002c
\.


--
-- Data for Name: measure_141_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_141_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Lee	John	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000173
t	t	f	f	f	t	Singleton	Jimmy	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00004c
t	t	f	f	f	t	Stephens	Miguel	1989-08-04	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00036c
\.


--
-- Data for Name: measure_142_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_142_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Mullins	Howard	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001b9
t	t	f	f	f	t	Zimmerman	Glen	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000080
\.


--
-- Data for Name: measure_143_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_143_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Mullins	Howard	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001b9
t	t	f	f	f	t	Zimmerman	Glen	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000080
\.


--
-- Data for Name: measure_144_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_144_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	f	f	f	f	f	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	t	f	t	f	f	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	f	f	f	f	f	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	f	f	f	f	f	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
\.


--
-- Data for Name: measure_145_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_145_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	f	t	f	f	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
\.


--
-- Data for Name: measure_145_1; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_145_1 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	f	f	f	f	f	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	f	f	f	f	f	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	f	f	f	f	f	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
\.


--
-- Data for Name: measure_146_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_146_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	t	f	f	f	Barnes	Janet	2003-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002de
t	t	f	f	f	t	Jordan	Sherri	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000b8
t	t	f	t	f	f	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
\.


--
-- Data for Name: measure_147_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_147_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Allen	Georgia	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000148
t	t	f	f	f	t	Arnold	Terri	2004-02-05	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e000399
t	t	f	f	f	t	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	f	f	f	t	Barnes	Janet	2003-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002de
t	t	f	f	f	t	Buchanan	Lori	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000fa
t	t	f	f	f	t	Collins	Andy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000136
t	t	f	f	f	t	Crawford	Velma	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00008e
t	t	f	f	f	t	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	t	f	f	f	t	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	t	f	f	f	t	Griffith	Katherine	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00002c
t	t	f	f	f	t	Hampton	Johnnie	1974-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002f2
t	t	f	f	f	t	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	f	f	t	Henderson	Peggy	2004-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000198
t	t	f	f	f	t	Hill	Ana	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001e5
t	t	f	f	f	t	Jordan	Sherri	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000b8
t	t	f	f	f	t	Lee	John	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000173
t	t	f	f	f	t	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	f	f	t	Mccarthy	Catherine	1990-11-28	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003de
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	t	f	f	f	t	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
t	t	f	f	f	t	Richardson	Juanita	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000296
t	t	f	f	f	t	Robinson	Renee	2004-01-04	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00006f
t	t	f	f	f	t	Ruiz	Rose	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000284
t	t	f	f	f	t	Singleton	Jimmy	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00004c
t	t	f	t	f	f	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
t	t	f	f	f	t	Stephens	Miguel	1989-08-04	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00036c
\.


--
-- Data for Name: measure_148_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_148_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Arnold	Terri	2004-02-05	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e000399
t	t	f	t	f	f	Henderson	Peggy	2004-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000198
t	t	f	f	f	t	Robinson	Renee	2004-01-04	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00006f
\.


--
-- Data for Name: measure_149_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_149_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	t	f	f	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
\.


--
-- Data for Name: measure_153_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_153_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Harrington	Pamela	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000107
t	t	t	f	f	f	Jordan	Sherri	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000b8
t	t	f	f	f	t	Mccarthy	Catherine	1990-11-28	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003de
t	t	f	f	f	t	Richardson	Juanita	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000296
t	t	f	t	f	f	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
\.


--
-- Data for Name: measure_153_1; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_153_1 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	t	f	f	f	Jordan	Sherri	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000b8
t	t	f	t	f	f	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
\.


--
-- Data for Name: measure_153_2; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_153_2 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Harrington	Pamela	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000107
t	t	f	f	f	t	Mccarthy	Catherine	1990-11-28	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003de
t	t	f	f	f	t	Richardson	Juanita	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000296
\.


--
-- Data for Name: measure_154_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_154_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	t	f	f	f	Barnes	Janet	2003-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002de
t	t	f	f	f	t	Jordan	Sherri	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000b8
t	t	f	t	f	f	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
\.


--
-- Data for Name: measure_155_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_155_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Arnold	Terri	2004-02-05	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e000399
t	t	t	f	f	f	Barnes	Janet	2003-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002de
t	t	f	f	f	t	Buchanan	Lori	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000fa
t	t	f	f	f	t	Collins	Andy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000136
t	t	f	f	f	t	Henderson	Peggy	2004-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000198
t	t	f	f	f	t	Jordan	Sherri	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000b8
t	t	f	f	f	t	Lee	Guy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000058
t	t	f	f	f	t	Robinson	Renee	2004-01-04	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00006f
t	t	f	f	f	t	Ruiz	Rose	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000284
t	t	f	f	f	t	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
\.


--
-- Data for Name: measure_155_1; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_155_1 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Arnold	Terri	2004-02-05	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e000399
t	t	t	f	f	f	Barnes	Janet	2003-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002de
t	t	f	f	f	t	Buchanan	Lori	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000fa
t	t	f	f	f	t	Collins	Andy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000136
t	t	f	f	f	t	Henderson	Peggy	2004-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000198
t	t	f	f	f	t	Jordan	Sherri	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000b8
t	t	f	f	f	t	Lee	Guy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000058
t	t	f	f	f	t	Robinson	Renee	2004-01-04	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00006f
t	t	f	f	f	t	Ruiz	Rose	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000284
t	t	f	t	f	f	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
\.


--
-- Data for Name: measure_155_2; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_155_2 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Arnold	Terri	2004-02-05	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e000399
t	t	t	f	f	f	Barnes	Janet	2003-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002de
t	t	f	f	f	t	Buchanan	Lori	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000fa
t	t	f	f	f	t	Collins	Andy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000136
t	t	f	f	f	t	Henderson	Peggy	2004-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000198
t	t	f	f	f	t	Jordan	Sherri	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000b8
t	t	f	f	f	t	Lee	Guy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000058
t	t	f	f	f	t	Robinson	Renee	2004-01-04	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00006f
t	t	f	f	f	t	Ruiz	Rose	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000284
t	t	f	f	f	t	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
\.


--
-- Data for Name: measure_155_3; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_155_3 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Arnold	Terri	2004-02-05	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e000399
t	t	t	f	f	f	Barnes	Janet	2003-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002de
t	t	f	f	f	t	Collins	Andy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000136
t	t	f	f	f	t	Henderson	Peggy	2004-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000198
t	t	f	f	f	t	Lee	Guy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000058
t	t	f	f	f	t	Robinson	Renee	2004-01-04	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00006f
\.


--
-- Data for Name: measure_155_4; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_155_4 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Buchanan	Lori	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000fa
t	t	f	f	f	t	Jordan	Sherri	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000b8
t	t	f	f	f	t	Ruiz	Rose	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000284
t	t	f	f	f	t	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
\.


--
-- Data for Name: measure_155_5; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_155_5 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Arnold	Terri	2004-02-05	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e000399
t	t	t	f	f	f	Barnes	Janet	2003-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002de
t	t	f	f	f	t	Collins	Andy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000136
t	t	f	f	f	t	Henderson	Peggy	2004-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000198
t	t	f	f	f	t	Lee	Guy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000058
t	t	f	f	f	t	Robinson	Renee	2004-01-04	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00006f
\.


--
-- Data for Name: measure_155_6; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_155_6 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Buchanan	Lori	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000fa
t	t	f	f	f	t	Jordan	Sherri	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000b8
t	t	f	f	f	t	Ruiz	Rose	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000284
t	t	f	t	f	f	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
\.


--
-- Data for Name: measure_155_7; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_155_7 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Arnold	Terri	2004-02-05	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e000399
t	t	t	f	f	f	Barnes	Janet	2003-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002de
t	t	f	f	f	t	Collins	Andy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000136
t	t	f	f	f	t	Henderson	Peggy	2004-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000198
t	t	f	f	f	t	Lee	Guy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000058
t	t	f	f	f	t	Robinson	Renee	2004-01-04	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00006f
\.


--
-- Data for Name: measure_155_8; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_155_8 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Buchanan	Lori	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000fa
t	t	f	f	f	t	Jordan	Sherri	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000b8
t	t	f	f	f	t	Ruiz	Rose	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000284
t	t	f	f	f	t	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
\.


--
-- Data for Name: measure_156_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_156_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	f	f	f	t	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	t	f	f	f	t	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	f	f	t	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	t	f	t	f	f	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
\.


--
-- Data for Name: measure_156_1; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_156_1 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	f	f	f	t	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	t	f	f	f	t	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	f	f	t	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	t	f	f	f	t	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
\.


--
-- Data for Name: measure_157_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_157_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Lee	John	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000173
t	t	f	f	f	t	Singleton	Jimmy	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00004c
t	t	f	f	f	t	Stephens	Miguel	1989-08-04	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00036c
\.


--
-- Data for Name: measure_158_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_158_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Harrington	Pamela	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000107
t	t	f	t	f	f	Mccarthy	Catherine	1990-11-28	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003de
t	t	f	t	f	f	Richardson	Juanita	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000296
\.


--
-- Data for Name: measure_159_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_159_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Goodman	Philip	1992-01-07	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000308
t	t	f	f	f	t	Ramirez	Eugene	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002a5
\.


--
-- Data for Name: measure_160_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_160_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	t	f	t	f	f	Goodman	Philip	1992-01-07	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000308
t	t	f	f	f	t	Singleton	Clinton	1972-01-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000016
\.


--
-- Data for Name: measure_160_1; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_160_1 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Hampton	Johnnie	1974-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002f2
t	t	f	f	f	t	Ramirez	Eugene	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002a5
\.


--
-- Data for Name: measure_160_2; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_160_2 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Hampton	Johnnie	1974-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002f2
\.


--
-- Data for Name: measure_161_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_161_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	t	f	f	f	t	Hampton	Johnnie	1974-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002f2
t	t	f	f	f	t	Singleton	Clinton	1972-01-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000016
\.


--
-- Data for Name: measure_163_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_163_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Campbell	Darlene	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00038c
t	t	f	f	f	t	Massey	Jacqueline	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000063
t	t	f	t	f	f	Potter	Gail	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00018b
\.


--
-- Data for Name: measure_164_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_164_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	f	t	f	f	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
\.


--
-- Data for Name: measure_165_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_165_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	t	f	f	f	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	t	f	t	f	f	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
\.


--
-- Data for Name: measure_166_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_166_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Crawford	Velma	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00008e
t	t	t	f	f	f	Hampton	Johnnie	1974-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002f2
t	t	f	f	f	t	Hill	Ana	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001e5
\.


--
-- Data for Name: measure_167_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_167_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Mullins	Howard	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001b9
t	t	f	f	f	t	Zimmerman	Glen	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000080
\.


--
-- Data for Name: measure_169_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_169_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	t	f	f	f	t	Singleton	Clinton	1972-01-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000016
\.


--
-- Data for Name: measure_177_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_177_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	t	Collins	Andy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000136
t	t	f	f	f	t	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
\.


--
-- Data for Name: measure_182_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_182_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	f	t	f	f	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
\.


--
-- Data for Name: measure_182_1; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_182_1 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	f	t	f	f	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
\.


--
-- Data for Name: measure_22_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_22_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Allen	Georgia	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000148
t	t	t	f	f	f	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	f	f	f	t	Campbell	Darlene	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00038c
t	t	f	f	f	t	Crawford	Velma	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00008e
t	t	f	f	f	t	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	t	t	f	f	f	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	t	f	f	f	t	Goodman	Philip	1992-01-07	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000308
t	t	f	f	f	t	Griffith	Katherine	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00002c
t	t	f	f	f	t	Hampton	Johnnie	1974-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002f2
t	t	f	f	f	t	Harrington	Pamela	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000107
t	t	t	f	f	f	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	t	f	f	Hill	Ana	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001e5
t	t	f	f	f	t	Lee	John	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000173
t	t	f	f	f	t	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	f	f	t	Massey	Jacqueline	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000063
t	t	f	f	f	t	Mccarthy	Catherine	1990-11-28	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003de
t	t	f	f	f	t	Mullins	Howard	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001b9
t	t	t	f	f	f	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	t	f	f	f	t	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
t	t	f	f	f	t	Potter	Gail	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00018b
t	t	f	f	f	t	Ramirez	Eugene	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002a5
t	t	f	f	f	t	Richardson	Juanita	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000296
t	t	f	f	f	t	Singleton	Clinton	1972-01-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000016
t	t	f	f	f	t	Singleton	Jimmy	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00004c
t	t	f	f	f	t	Stephens	Miguel	1989-08-04	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00036c
t	t	f	f	f	t	Zimmerman	Glen	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000080
\.


--
-- Data for Name: measure_2_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_2_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Allen	Georgia	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000148
t	t	f	f	f	t	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	f	f	f	t	Buchanan	Lori	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000fa
t	t	f	f	f	t	Campbell	Darlene	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00038c
t	t	f	f	f	t	Crawford	Velma	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00008e
t	t	t	f	f	f	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	t	f	f	f	t	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	t	t	f	f	f	Goodman	Philip	1992-01-07	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000308
t	t	f	f	f	t	Griffith	Katherine	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00002c
t	t	t	f	f	f	Hampton	Johnnie	1974-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002f2
t	t	f	f	f	t	Harrington	Pamela	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000107
t	t	f	f	f	t	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	f	f	t	Hill	Ana	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001e5
t	t	f	f	f	t	Jordan	Sherri	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000b8
t	t	f	f	f	t	Lee	John	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000173
t	t	f	f	f	t	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	f	f	t	Massey	Jacqueline	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000063
t	t	f	f	f	t	Mccarthy	Catherine	1990-11-28	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003de
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	t	f	f	f	t	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
t	t	f	f	f	t	Potter	Gail	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00018b
t	t	t	f	f	f	Ramirez	Eugene	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002a5
t	t	f	f	f	t	Richardson	Juanita	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000296
t	t	f	f	f	t	Ruiz	Rose	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000284
t	t	f	f	f	t	Singleton	Clinton	1972-01-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000016
t	t	f	f	f	t	Singleton	Jimmy	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00004c
t	t	f	t	f	f	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
t	t	f	f	f	t	Stephens	Miguel	1989-08-04	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00036c
\.


--
-- Data for Name: measure_50_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_50_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Crawford	Velma	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00008e
t	t	f	t	f	f	Hill	Ana	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001e5
t	t	f	f	f	t	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
\.


--
-- Data for Name: measure_52_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_52_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Buchanan	Lori	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000fa
t	t	f	t	f	f	Ruiz	Rose	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000284
\.


--
-- Data for Name: measure_52_1; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_52_1 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
\.


--
-- Data for Name: measure_52_2; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_52_2 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
\.


--
-- Data for Name: measure_56_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_56_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	t	f	f	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
\.


--
-- Data for Name: measure_61_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_61_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	f	f	f	f	f	Allen	Georgia	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000148
t	t	f	t	f	f	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	f	t	f	f	Campbell	Darlene	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00038c
t	f	f	f	f	f	Crawford	Velma	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00008e
t	f	f	f	f	f	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	f	f	f	f	f	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	f	f	f	f	f	Goodman	Philip	1992-01-07	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000308
t	f	f	f	f	f	Griffith	Katherine	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00002c
t	f	f	f	f	f	Hampton	Johnnie	1974-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002f2
t	f	f	f	f	f	Harrington	Pamela	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000107
t	t	f	t	f	f	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	t	f	f	Hill	Ana	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001e5
t	f	f	f	f	f	Lee	John	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000173
t	f	f	f	f	f	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	f	f	t	Massey	Jacqueline	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000063
t	f	f	f	f	f	Mccarthy	Catherine	1990-11-28	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003de
t	t	f	t	f	f	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	f	f	f	f	f	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
t	t	f	t	f	f	Potter	Gail	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00018b
t	f	f	f	f	f	Ramirez	Eugene	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002a5
t	f	f	f	f	f	Richardson	Juanita	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000296
t	f	f	f	f	f	Singleton	Clinton	1972-01-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000016
t	f	f	f	f	f	Singleton	Jimmy	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00004c
t	f	f	f	f	f	Stephens	Miguel	1989-08-04	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00036c
\.


--
-- Data for Name: measure_61_1; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_61_1 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	f	f	f	f	f	Allen	Georgia	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000148
t	f	f	f	f	f	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	f	f	f	f	f	Campbell	Darlene	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00038c
t	f	f	f	f	f	Crawford	Velma	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00008e
t	f	f	f	f	f	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	t	f	f	f	t	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	f	f	f	f	f	Goodman	Philip	1992-01-07	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000308
t	f	f	f	f	f	Griffith	Katherine	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00002c
t	f	f	f	f	f	Hampton	Johnnie	1974-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002f2
t	f	f	f	f	f	Harrington	Pamela	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000107
t	f	f	f	f	f	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	f	f	f	f	f	Hill	Ana	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001e5
t	f	f	f	f	f	Lee	John	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000173
t	f	f	f	f	f	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	f	f	f	f	f	Massey	Jacqueline	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000063
t	f	f	f	f	f	Mccarthy	Catherine	1990-11-28	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003de
t	f	f	f	f	f	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	f	f	f	f	f	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
t	f	f	f	f	f	Potter	Gail	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00018b
t	f	f	f	f	f	Ramirez	Eugene	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002a5
t	f	f	f	f	f	Richardson	Juanita	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000296
t	f	f	f	f	f	Singleton	Clinton	1972-01-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000016
t	f	f	f	f	f	Singleton	Jimmy	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00004c
t	f	f	f	f	f	Stephens	Miguel	1989-08-04	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00036c
\.


--
-- Data for Name: measure_61_2; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_61_2 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Allen	Georgia	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000148
t	f	f	f	f	f	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	f	f	f	f	f	Campbell	Darlene	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00038c
t	t	f	f	f	t	Crawford	Velma	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00008e
t	t	f	f	f	t	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	f	f	f	f	f	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	t	f	f	f	t	Goodman	Philip	1992-01-07	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000308
t	t	f	f	f	t	Griffith	Katherine	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00002c
t	t	f	f	f	t	Hampton	Johnnie	1974-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002f2
t	t	f	f	f	t	Harrington	Pamela	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000107
t	f	f	f	f	f	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	f	f	f	f	f	Hill	Ana	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001e5
t	t	f	f	f	t	Lee	John	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000173
t	t	f	f	f	t	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	f	f	f	f	f	Massey	Jacqueline	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000063
t	t	t	f	f	f	Mccarthy	Catherine	1990-11-28	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003de
t	f	f	f	f	f	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	t	f	f	f	t	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
t	f	f	f	f	f	Potter	Gail	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00018b
t	t	f	f	f	t	Ramirez	Eugene	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002a5
t	t	t	f	f	f	Richardson	Juanita	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000296
t	t	f	f	f	t	Singleton	Clinton	1972-01-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000016
t	t	f	f	f	t	Singleton	Jimmy	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00004c
t	t	f	f	f	t	Stephens	Miguel	1989-08-04	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00036c
\.


--
-- Data for Name: measure_62_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_62_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Buchanan	Lori	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000fa
t	t	f	f	f	t	Lee	Guy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000058
t	t	f	t	f	f	Ruiz	Rose	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000284
\.


--
-- Data for Name: measure_64_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_64_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	f	f	f	f	f	Allen	Georgia	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000148
t	t	f	t	f	f	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	f	t	f	f	Campbell	Darlene	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00038c
t	f	f	f	f	f	Crawford	Velma	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00008e
t	f	f	f	f	f	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	f	f	f	f	f	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	f	f	f	f	f	Goodman	Philip	1992-01-07	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000308
t	f	f	f	f	f	Griffith	Katherine	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00002c
t	f	f	f	f	f	Hampton	Johnnie	1974-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002f2
t	f	f	f	f	f	Harrington	Pamela	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000107
t	t	f	t	f	f	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	t	f	f	Hill	Ana	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001e5
t	f	f	f	f	f	Lee	John	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000173
t	f	f	f	f	f	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	f	f	f	f	f	Massey	Jacqueline	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000063
t	f	f	f	f	f	Mccarthy	Catherine	1990-11-28	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003de
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	f	f	f	f	f	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
t	t	f	t	f	f	Potter	Gail	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00018b
t	f	f	f	f	f	Ramirez	Eugene	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002a5
t	f	f	f	f	f	Richardson	Juanita	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000296
t	f	f	f	f	f	Singleton	Clinton	1972-01-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000016
t	f	f	f	f	f	Singleton	Jimmy	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00004c
t	f	f	f	f	f	Stephens	Miguel	1989-08-04	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00036c
\.


--
-- Data for Name: measure_64_1; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_64_1 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	f	f	f	f	f	Allen	Georgia	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000148
t	f	f	f	f	f	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	f	f	f	f	f	Campbell	Darlene	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00038c
t	f	f	f	f	f	Crawford	Velma	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00008e
t	f	f	f	f	f	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	f	f	f	f	f	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	f	f	f	f	f	Goodman	Philip	1992-01-07	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000308
t	f	f	f	f	f	Griffith	Katherine	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00002c
t	f	f	f	f	f	Hampton	Johnnie	1974-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002f2
t	f	f	f	f	f	Harrington	Pamela	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000107
t	f	f	f	f	f	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	f	f	f	f	f	Hill	Ana	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001e5
t	f	f	f	f	f	Lee	John	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000173
t	f	f	f	f	f	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	f	f	f	f	f	Massey	Jacqueline	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000063
t	f	f	f	f	f	Mccarthy	Catherine	1990-11-28	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003de
t	f	f	f	f	f	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	f	f	f	f	f	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
t	f	f	f	f	f	Potter	Gail	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00018b
t	f	f	f	f	f	Ramirez	Eugene	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002a5
t	f	f	f	f	f	Richardson	Juanita	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000296
t	f	f	f	f	f	Singleton	Clinton	1972-01-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000016
t	f	f	f	f	f	Singleton	Jimmy	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00004c
t	f	f	f	f	f	Stephens	Miguel	1989-08-04	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00036c
\.


--
-- Data for Name: measure_64_2; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_64_2 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	f	f	f	f	f	Allen	Georgia	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000148
t	f	f	f	f	f	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	f	f	f	f	f	Campbell	Darlene	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00038c
t	f	f	f	f	f	Crawford	Velma	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00008e
t	f	f	f	f	f	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	f	f	f	f	f	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	f	f	f	f	f	Goodman	Philip	1992-01-07	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000308
t	f	f	f	f	f	Griffith	Katherine	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00002c
t	f	f	f	f	f	Hampton	Johnnie	1974-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002f2
t	f	f	f	f	f	Harrington	Pamela	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000107
t	f	f	f	f	f	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	f	f	f	f	f	Hill	Ana	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001e5
t	f	f	f	f	f	Lee	John	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000173
t	f	f	f	f	f	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	f	f	f	f	f	Massey	Jacqueline	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000063
t	f	f	f	f	f	Mccarthy	Catherine	1990-11-28	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003de
t	f	f	f	f	f	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	f	f	f	f	f	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
t	f	f	f	f	f	Potter	Gail	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00018b
t	f	f	f	f	f	Ramirez	Eugene	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002a5
t	f	f	f	f	f	Richardson	Juanita	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000296
t	f	f	f	f	f	Singleton	Clinton	1972-01-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000016
t	f	f	f	f	f	Singleton	Jimmy	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00004c
t	f	f	f	f	f	Stephens	Miguel	1989-08-04	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00036c
\.


--
-- Data for Name: measure_65_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_65_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	t	f	f	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
\.


--
-- Data for Name: measure_66_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_66_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	t	f	f	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
\.


--
-- Data for Name: measure_68_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_68_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Allen	Georgia	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000148
t	t	f	f	f	t	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	f	f	f	t	Campbell	Darlene	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00038c
t	t	f	f	f	t	Crawford	Velma	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00008e
t	t	f	f	f	t	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	t	f	f	f	t	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	t	f	f	f	t	Goodman	Philip	1992-01-07	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000308
t	t	f	f	f	t	Griffith	Katherine	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00002c
t	t	f	f	t	t	Hampton	Johnnie	1974-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002f2
t	t	f	f	f	t	Harrington	Pamela	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000107
t	t	f	f	f	t	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	t	f	t	Hill	Ana	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001e5
t	t	f	f	f	t	Lee	John	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000173
t	t	f	f	f	t	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	f	f	t	Massey	Jacqueline	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000063
t	t	f	f	f	t	Mccarthy	Catherine	1990-11-28	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003de
t	t	f	f	f	t	Mullins	Howard	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001b9
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	t	f	f	f	t	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
t	t	f	f	f	t	Potter	Gail	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00018b
t	t	f	f	f	t	Ramirez	Eugene	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002a5
t	t	f	f	f	t	Richardson	Juanita	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000296
t	t	f	f	f	t	Singleton	Jimmy	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00004c
t	t	f	f	f	t	Singleton	Clinton	1972-01-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000016
t	t	f	f	f	t	Stephens	Miguel	1989-08-04	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00036c
t	t	f	f	f	t	Zimmerman	Glen	1943-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000080
\.


--
-- Data for Name: measure_69_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_69_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Allen	Georgia	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000148
t	t	f	f	f	t	Campbell	Darlene	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00038c
t	t	f	f	f	t	Crawford	Velma	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00008e
t	t	f	f	f	t	Cummings	William	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000120
t	t	f	f	f	t	Goodman	Philip	1992-01-07	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000308
t	t	f	f	f	t	Griffith	Katherine	1964-09-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00002c
t	t	f	f	f	t	Hampton	Johnnie	1974-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002f2
t	t	f	f	f	t	Harrington	Pamela	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000107
t	t	f	t	f	f	Hill	Ana	1969-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0001e5
t	t	f	f	f	t	Lee	John	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000173
t	t	f	f	f	t	Massey	Jacqueline	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000063
t	t	t	f	f	f	Mccarthy	Catherine	1990-11-28	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003de
t	t	f	f	f	t	Potter	Gail	1984-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00018b
t	t	f	f	f	t	Ramirez	Eugene	1992-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002a5
t	t	t	f	f	f	Richardson	Juanita	1990-12-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000296
t	t	f	f	f	t	Singleton	Clinton	1972-01-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000016
t	t	f	f	f	t	Singleton	Jimmy	1989-08-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00004c
t	t	f	f	f	t	Stephens	Miguel	1989-08-04	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00036c
\.


--
-- Data for Name: measure_69_1; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_69_1 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Baldwin	Jeremy	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000270
t	t	f	f	f	t	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	t	f	f	f	t	Hayes	Philip	1944-02-02	M	http://cypress-demo.isi.edu/patients/560e0fe6637970313e0003cc
t	t	f	f	f	t	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	t	f	f	f	t	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
\.


--
-- Data for Name: measure_74_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_74_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Arnold	Terri	2004-02-05	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e000399
t	t	f	f	f	t	Barnes	Janet	2003-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002de
t	t	f	f	f	t	Buchanan	Lori	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000fa
t	t	f	f	f	t	Byrd	Elsie	2013-11-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00001c
t	t	f	f	f	t	Collins	Andy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000136
t	t	f	f	f	t	Hart	Marcus	2012-06-18	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00030e
t	t	f	f	f	t	Henderson	Peggy	2004-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000198
t	t	f	f	f	t	Jordan	Sherri	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000b8
t	t	f	t	f	f	Lee	Guy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000058
t	t	f	f	f	t	Mcdaniel	Theodore	2012-06-18	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00034c
t	t	f	f	f	t	Mcgee	Kristen	2013-11-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000374
t	t	f	f	f	t	Robinson	Renee	2004-01-04	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00006f
t	t	f	f	f	t	Ruiz	Rose	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000284
t	t	f	f	f	t	Scott	Shirley	2013-11-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000128
t	t	f	f	f	t	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
\.


--
-- Data for Name: measure_74_1; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_74_1 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Byrd	Elsie	2013-11-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00001c
t	t	f	f	f	t	Hart	Marcus	2012-06-18	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00030e
t	t	f	f	f	t	Mcdaniel	Theodore	2012-06-18	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00034c
t	t	f	f	f	t	Mcgee	Kristen	2013-11-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000374
t	t	f	f	f	t	Scott	Shirley	2013-11-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000128
\.


--
-- Data for Name: measure_74_2; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_74_2 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Arnold	Terri	2004-02-05	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e000399
t	t	f	f	f	t	Barnes	Janet	2003-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002de
t	t	f	f	f	t	Collins	Andy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000136
t	t	f	f	f	t	Henderson	Peggy	2004-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000198
t	t	f	t	f	f	Lee	Guy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000058
t	t	f	f	f	t	Robinson	Renee	2004-01-04	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00006f
\.


--
-- Data for Name: measure_74_3; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_74_3 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Buchanan	Lori	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000fa
t	t	f	f	f	t	Jordan	Sherri	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000b8
t	t	f	f	f	t	Ruiz	Rose	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000284
t	t	f	f	f	t	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
\.


--
-- Data for Name: measure_75_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_75_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Arnold	Terri	2004-02-05	F	http://cypress-demo.isi.edu/patients/560e0fe6637970313e000399
t	t	f	f	f	t	Barnes	Janet	2003-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002de
t	t	f	f	f	t	Buchanan	Lori	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000fa
t	t	f	f	f	t	Byrd	Elsie	2013-11-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00001c
t	t	f	f	f	t	Collins	Andy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000136
t	t	f	f	f	t	Hart	Marcus	2012-06-18	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00030e
t	t	f	f	f	t	Henderson	Peggy	2004-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000198
t	t	f	f	f	t	Jordan	Sherri	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000b8
t	t	f	t	f	f	Lee	Guy	2003-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000058
t	t	f	f	f	t	Mcdaniel	Theodore	2012-06-18	M	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00034c
t	t	f	f	f	t	Mcgee	Kristen	2013-11-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000374
t	t	f	f	f	t	Robinson	Renee	2004-01-04	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00006f
t	t	f	f	f	t	Ruiz	Rose	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000284
t	t	f	f	f	t	Scott	Shirley	2013-11-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000128
t	t	f	f	f	t	Smith	Esther	1997-02-01	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e00023d
\.


--
-- Data for Name: measure_77_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_77_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Buchanan	Lori	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000fa
t	t	f	t	f	f	Ruiz	Rose	1999-10-31	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000284
\.


--
-- Data for Name: measure_82_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_82_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	f	f	f	t	Byrd	Elsie	2013-11-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e00001c
t	t	f	t	f	f	Mcgee	Kristen	2013-11-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000374
t	t	f	t	f	f	Scott	Shirley	2013-11-01	F	http://cypress-demo.isi.edu/patients/560e0fe4637970313e000128
\.


--
-- Data for Name: measure_90_0; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY measure_90_0 (ipp, denom, denex, numer, denexcep, "out", lastname, firstname, dob, gender, patient_url) FROM stdin;
t	t	t	f	f	f	Doyle	Wanda	1939-01-02	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e0002c0
t	t	f	f	f	t	Mack	Jesus	1947-01-03	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000a2
t	t	f	f	f	t	Nelson	Jacob	1944-02-01	M	http://cypress-demo.isi.edu/patients/560e0fe4637970313e0000ed
t	t	f	t	f	f	Perez	Shannon	1947-01-03	F	http://cypress-demo.isi.edu/patients/560e0fe5637970313e000216
\.


--
-- Data for Name: patient_xref; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY patient_xref (patient_id, lastname, firstname) FROM stdin;
0	Allen	Georgia
1	Arnold	Terri
2	Baldwin	Jeremy
3	Barnes	Janet
4	Buchanan	Lori
5	Byrd	Elsie
6	Campbell	Darlene
7	Collins	Andy
8	Crawford	Velma
9	Cummings	William
10	Doyle	Wanda
11	Goodman	Philip
12	Griffith	Katherine
13	Hampton	Johnnie
14	Harrington	Pamela
15	Hart	Marcus
16	Hayes	Philip
17	Henderson	Peggy
18	Hill	Ana
19	Jordan	Sherri
20	Lee	Guy
21	Lee	John
22	Mack	Jesus
23	Massey	Jacqueline
24	Mccarthy	Catherine
25	Mcdaniel	Theodore
26	Mcgee	Kristen
27	Mullins	Howard
28	Nelson	Jacob
29	Perez	Shannon
30	Potter	Gail
31	Ramirez	Eugene
32	Richardson	Juanita
33	Robinson	Renee
34	Ruiz	Rose
35	Scott	Shirley
36	Singleton	Clinton
37	Singleton	Jimmy
38	Smith	Esther
39	Stephens	Miguel
40	Zimmerman	Glen
\.


--
-- Data for Name: totals_key; Type: TABLE DATA; Schema: answer_key; Owner: -
--

COPY totals_key (cms_name, total_ipp, total_denom, total_denex, total_numer, total_denexcep, long_name, relative_url, measure_name) FROM stdin;
cms137v4	2	2	0	1	\N	CMS137v4/0004 - Initiation and Engagement of Alcohol and Other Drug Dependence Treatment- Treatment	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2712	measure_137_0_patient_summary
cms137v4	2	2	0	0	\N	CMS137v4/0004 - Initiation and Engagement of Alcohol and Other Drug Dependence Treatment- Treatment w/ AOD	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2713	measure_137_1_patient_summary
cms137v4	0	0	0	0	\N	CMS137v4/0004 - Initiation and Engagement of Alcohol and Other Drug Dependence Treatment- Treatment, RS1: 13-17	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2714	measure_137_2_patient_summary
cms137v4	2	2	0	1	\N	CMS137v4/0004 - Initiation and Engagement of Alcohol and Other Drug Dependence Treatment- Treatment, RS2:=18	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2715	measure_137_3_patient_summary
cms137v4	0	0	0	0	\N	CMS137v4/0004 - Initiation and Engagement of Alcohol and Other Drug Dependence Treatment- Treatment w/ AOD, RS1: 13-17	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2716	measure_137_4_patient_summary
cms137v4	2	2	0	0	\N	CMS137v4/0004 - Initiation and Engagement of Alcohol and Other Drug Dependence Treatment- Treatment w AOD, RS2:=18	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2717	measure_137_5_patient_summary
cms165v4	4	4	1	2	\N	CMS165v4/0018 - Controlling High Blood Pressure	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b273d	measure_165_0_patient_summary
cms156v4	6	6	\N	1	\N	CMS156v4/0022 - Use of High-Risk Medications in the Elderly- 1+ High-Risk Medications	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2732	measure_156_0_patient_summary
cms156v4	6	6	\N	0	\N	CMS156v4/0022 - Use of High-Risk Medications in the Elderly- 2+ High-Risk Medications	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2733	measure_156_1_patient_summary
cms155v4	10	10	1	0	\N	CMS155v4/0024 - Weight Assessment and Counseling for Nutrition and Physical Activity for Children and Adolescents- BMI Recorded	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2729	measure_155_0_patient_summary
cms155v4	10	10	1	1	\N	CMS155v4/0024 - Weight Assessment and Counseling for Nutrition and Physical Activity for Children and Adolescents- Nutrition Counseling	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b272a	measure_155_1_patient_summary
cms155v4	10	10	1	0	\N	CMS155v4/0024 - Weight Assessment and Counseling for Nutrition and Physical Activity for Children and Adolescents- Physical Activity Counseling	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b272b	measure_155_2_patient_summary
cms155v4	6	6	1	0	\N	CMS155v4/0024 - Weight Assessment and Counseling for Nutrition and Physical Activity for Children and Adolescents- BMI Recorded, RS1: 3-11	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b272c	measure_155_3_patient_summary
cms155v4	4	4	0	0	\N	CMS155v4/0024 - Weight Assessment and Counseling for Nutrition and Physical Activity for Children and Adolescents- BMI Recorded, RS2: 12-17	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b272d	measure_155_4_patient_summary
cms155v4	6	6	1	0	\N	CMS155v4/0024 - Weight Assessment and Counseling for Nutrition and Physical Activity for Children and Adolescents- Nutrition Counseling, RS1: 3-11	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b272e	measure_155_5_patient_summary
cms155v4	4	4	0	1	\N	CMS155v4/0024 - Weight Assessment and Counseling for Nutrition and Physical Activity for Children and Adolescents- Nutrition Counseling, RS2: 12-17	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b272f	measure_155_6_patient_summary
cms155v4	6	6	1	0	\N	CMS155v4/0024 - Weight Assessment and Counseling for Nutrition and Physical Activity for Children and Adolescents- Physical Activity Counseling, RS1: 3-11	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2730	measure_155_7_patient_summary
cms155v4	4	4	0	0	\N	CMS155v4/0024 - Weight Assessment and Counseling for Nutrition and Physical Activity for Children and Adolescents- Physical Activity Counseling, RS2: 12-17	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2731	measure_155_8_patient_summary
cms138v4	19	19	\N	1	1	CMS138v4/0028 - Preventive Care and Screening: Tobacco Use: Screening and Cessation Intervention	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2718	measure_138_0_patient_summary
cms125v4	5	5	0	1	\N	CMS125v4/0031 - Breast Cancer Screening	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2700	measure_125_0_patient_summary
cms124v4	10	10	0	1	\N	CMS124v4/0032 - Cervical Cancer Screening	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b26ff	measure_124_0_patient_summary
cms153v4	5	5	1	1	\N	CMS153v4/0033 - Chlamydia Screening for Women- 16-24	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2725	measure_153_0_patient_summary
cms153v4	2	2	1	1	\N	CMS153v4/0033 - Chlamydia Screening for Women- RS1: 16-20	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2726	measure_153_1_patient_summary
cms153v4	3	3	0	0	\N	CMS153v4/0033 - Chlamydia Screening for Women- RS2: 21-24	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2727	measure_153_2_patient_summary
cms130v4	6	6	0	1	\N	CMS130v4/0034 - Colorectal Cancer Screening	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b270a	measure_130_0_patient_summary
cms126v4	3	3	1	1	\N	CMS126v4/0036 - Use of Appropriate Medications for Asthma- 5-64	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2701	measure_126_0_patient_summary
cms126v4	1	1	1	0	\N	CMS126v4/0036 - Use of Appropriate Medications for Asthma- RS1: 5-11	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2702	measure_126_1_patient_summary
cms126v4	2	2	0	1	\N	CMS126v4/0036 - Use of Appropriate Medications for Asthma- RS2: 12-18	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2703	measure_126_2_patient_summary
cms126v4	0	0	0	0	\N	CMS126v4/0036 - Use of Appropriate Medications for Asthma- RS3: 19-50	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2704	measure_126_3_patient_summary
cms126v4	0	0	0	0	\N	CMS126v4/0036 - Use of Appropriate Medications for Asthma- RS4: 51-64	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2705	measure_126_4_patient_summary
cms117v4	2	2	\N	1	\N	CMS117v4/0038 - Childhood Immunization Status	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b26fc	measure_117_0_patient_summary
cms147v5	26	26	\N	1	0	CMS147v5/0041 - Preventive Care and Screening: Influenza Immunization	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2722	measure_147_0_patient_summary
cms127v4	6	6	\N	1	\N	CMS127v4/0043 - Pneumonia Vaccination Status for Older Adults	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2706	measure_127_0_patient_summary
cms166v5	3	3	1	1	\N	CMS166v5/0052 - Use of Imaging Studies for Low Back Pain	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b273e	measure_166_0_patient_summary
cms131v4	3	3	\N	2	\N	CMS131v4/0055 - Diabetes: Eye Exam	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b270b	measure_131_0_patient_summary
cms123v4	3	3	0	2	\N	CMS123v4/0056 - Diabetes: Foot Exam	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b26fe	measure_123_0_patient_summary
cms122v4	3	3	\N	2	\N	CMS122v4/0059 - Diabetes: Hemoglobin A1c Poor Control	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b26fd	measure_122_0_patient_summary
cms148v4	3	3	\N	2	\N	CMS148v4/0060 - Hemoglobin A1c Test for Pediatric Patients	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2723	measure_148_0_patient_summary
cms134v4	3	3	\N	2	\N	CMS134v4/0062 - Diabetes: Urine Protein Screening	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b270e	measure_134_0_patient_summary
cms163v4	3	3	\N	2	\N	CMS163v4/0064 - Diabetes: Low Density Lipoprotein (LDL) Management	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b273b	measure_163_0_patient_summary
cms164v4	3	3	\N	2	\N	CMS164v4/0068 - Ischemic Vascular Disease (IVD): Use of Aspirin or Another Antithrombotic	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b273c	measure_164_0_patient_summary
cms145v4	3	3	\N	2	0	CMS145v4/0070 - Coronary Artery Disease (CAD): Beta-Blocker Therapy-Prior Myocardial Infarction (MI) or Left Ventricular Systolic Dysfunction (LVEF40%)- LVSD	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b271f	measure_145_0_patient_summary
cms145v4	3	0	\N	0	0	CMS145v4/0070 - Coronary Artery Disease (CAD): Beta-Blocker Therapy-Prior Myocardial Infarction (MI) or Left Ventricular Systolic Dysfunction (LVEF40%)- prior MI	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2720	measure_145_1_patient_summary
cms182v5	3	3	\N	2	\N	CMS182v5/0075 - Ischemic Vascular Disease (IVD): Complete Lipid Panel and LDL Control- Complete Lipid Profile	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2743	measure_182_0_patient_summary
cms182v5	3	3	\N	2	\N	CMS182v5/0075 - Ischemic Vascular Disease (IVD): Complete Lipid Panel and LDL Control- Most Recent LDL-C100 mg/dL	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2744	measure_182_1_patient_summary
cms135v4	6	3	\N	2	0	CMS135v4/0081 - Heart Failure (HF): Angiotensin-Converting Enzyme (ACE) Inhibitor or Angiotensin Receptor Blocker (ARB) Therapy for Left Ventricular Systolic Dysfunction (LVSD)	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b270f	measure_135_0_patient_summary
cms144v4	6	3	\N	2	0	CMS144v4/0083 - Heart Failure (HF): Beta-Blocker Therapy for Left Ventricular Systolic Dysfunction (LVSD)	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b271e	measure_144_0_patient_summary
cms143v4	2	2	\N	1	0	CMS143v4/0086 - Primary Open-Angle Glaucoma (POAG): Optic Nerve Evaluation	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b271d	measure_143_0_patient_summary
cms167v4	2	2	\N	1	0	CMS167v4/0088 - Diabetic Retinopathy: Documentation of Presence or Absence of Macular Edema and Level of Severity of Retinopathy	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b273f	measure_167_0_patient_summary
cms142v4	2	2	\N	1	0	CMS142v4/0089 - Diabetic Retinopathy: Communication with the Physician Managing Ongoing Diabetes Care	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b271c	measure_142_0_patient_summary
cms139v4	8	8	\N	1	0	CMS139v4/0101 - Falls: Screening for Future Fall Risk	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2719	measure_139_0_patient_summary
cms128v4	2	2	0	1	\N	CMS128v4/0105 - Anti-depressant Medication Management- 84 days	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2707	measure_128_0_patient_summary
cms128v4	2	2	0	0	\N	CMS128v4/0105 - Anti-depressant Medication Management- 180 days	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2708	measure_128_1_patient_summary
cms136v5	2	2	1	1	\N	CMS136v5/0108 - ADHD: Follow-Up Care for Children Prescribed Attention-Deficit/Hyperactivity Disorder (ADHD) Medication- Visit within 30 days	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2710	measure_136_0_patient_summary
cms136v5	0	0	0	0	\N	CMS136v5/0108 - ADHD: Follow-Up Care for Children Prescribed Attention-Deficit/Hyperactivity Disorder (ADHD) Medication- Visit with 2+ followups	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2711	measure_136_1_patient_summary
cms169v4	2	2	\N	1	\N	CMS169v4/0110 - Bipolar Disorder and Major Depression: Appraisal for alcohol or chemical substance use	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2740	measure_169_0_patient_summary
cms141v5	3	3	\N	1	0	CMS141v5/0385 - Colon Cancer: Chemotherapy for AJCC Stage III Colon Cancer Patients	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b271b	measure_141_0_patient_summary
cms140v4	2	2	\N	1	0	CMS140v4/0387 - Breast Cancer: Hormonal Therapy for Stage IC-IIIC Estrogen Receptor/Progesterone Receptor (ER/PR) Positive Breast Cancer	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b271a	measure_140_0_patient_summary
cms129v5	3	3	\N	1	0	CMS129v5/0389 - Prostate Cancer: Avoidance of Overuse of Bone Scan for Staging Low Risk Prostate Cancer Patients	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2709	measure_129_0_patient_summary
cms62v4	3	3	\N	2	\N	CMS62v4/0403 - HIV/AIDS: Medical Visit	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b274f	measure_62_0_patient_summary
cms52v4	2	2	\N	1	0	CMS52v4/0405 - HIV/AIDS: Pneumocystis Jiroveci Pneumonia (PCP) Prophylaxis- 6 years and older	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2748	measure_52_0_patient_summary
cms52v4	0	0	\N	0	0	CMS52v4/0405 - HIV/AIDS: Pneumocystis Jiroveci Pneumonia (PCP) Prophylaxis- 1-5 years	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2749	measure_52_1_patient_summary
cms52v4	0	0	\N	0	\N	CMS52v4/0405 - HIV/AIDS: Pneumocystis Jiroveci Pneumonia (PCP) Prophylaxis- 6 weeks to 1 year	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b274a	measure_52_2_patient_summary
cms2v5	28	28	4	1	0	CMS2v5/0418 - Preventive Care and Screening: Screening for Clinical Depression and Follow-Up Plan	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2746	measure_2_0_patient_summary
cms69v4	18	18	2	1	\N	CMS69v4/0421 - Preventive Care and Screening: Body Mass Index (BMI) Screening and Follow-Up Plan- 18-64	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2756	measure_69_0_patient_summary
cms69v4	6	6	0	0	\N	CMS69v4/0421 - Preventive Care and Screening: Body Mass Index (BMI) Screening and Follow-Up Plan- 65+	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2757	measure_69_1_patient_summary
cms158v4	3	3	\N	2	0	CMS158v4/0608 - Pregnant women that had HBsAg testing	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2735	measure_158_0_patient_summary
cms159v4	2	2	0	1	\N	CMS159v4/0710 - Depression Remission at Twelve Months	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2736	measure_159_0_patient_summary
cms160v4	3	3	0	2	\N	CMS160v4/0712 - Depression Utilization of the PHQ-9 Tool- Sep-Dec	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2737	measure_160_0_patient_summary
cms160v4	2	2	0	0	\N	CMS160v4/0712 - Depression Utilization of the PHQ-9 Tool- May-Aug	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2738	measure_160_1_patient_summary
cms160v4	1	1	0	0	\N	CMS160v4/0712 - Depression Utilization of the PHQ-9 Tool- Jan-Apr	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2739	measure_160_2_patient_summary
cms82v3	3	3	\N	2	\N	CMS82v3/1401 - Maternal Depression Screening	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b275e	measure_82_0_patient_summary
cms22v4	26	26	4	1	0	CMS22v4/BPScreen - Preventive Care and Screening: Screening for High Blood Pressure and Follow-Up Documented	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2745	measure_22_0_patient_summary
cms75v4	15	15	\N	1	\N	CMS75v4/ChildDentalDecay - Children Who Have Dental Decay or Cavities	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b275c	measure_75_0_patient_summary
cms64v5	24	6	0	5	\N	CMS64v5/CholesterolScreeningRisk - Preventive Care and Screening: Risk-Stratified Cholesterol -Fasting Low Density Lipoprotein (LDL-C)- LDL-C100 mg/dL	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2750	measure_64_0_patient_summary
cms64v5	24	0	0	0	\N	CMS64v5/CholesterolScreeningRisk - Preventive Care and Screening: Risk-Stratified Cholesterol -Fasting Low Density Lipoprotein (LDL-C)- LDL-C130 mg/dL	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2751	measure_64_1_patient_summary
cms64v5	24	0	0	0	\N	CMS64v5/CholesterolScreeningRisk - Preventive Care and Screening: Risk-Stratified Cholesterol -Fasting Low Density Lipoprotein (LDL-C)- LDL-C160 mg/dL	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2752	measure_64_2_patient_summary
cms50v4	3	3	\N	1	\N	CMS50v4/ClosingReferralLoop - Closing the Referral Loop: Receipt of Specialist Report	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2747	measure_50_0_patient_summary
cms149v4	2	2	\N	1	0	CMS149v4/DementiaCognitive - Dementia: Cognitive Assessment	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2724	measure_149_0_patient_summary
cms90v5	4	4	1	1	\N	CMS90v5/FSACHF - Functional Status Assessment for Complex Chronic Conditions	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b275f	measure_90_0_patient_summary
cms56v4	2	2	0	1	\N	CMS56v4/FSAHip - Functional Status Assessment for Hip Replacement	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b274b	measure_56_0_patient_summary
cms66v4	2	2	0	1	\N	CMS66v4/FSAKnee - Functional Status Assessment for Knee Replacement	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2754	measure_66_0_patient_summary
cms61v5	24	7	0	6	0	CMS61v5/FastingLDLTest - Preventive Care and Screening: Cholesterol - Fasting Low Density Lipoprotein (LDL-C) Test Performed- High Risk	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b274c	measure_61_0_patient_summary
cms61v5	24	1	0	0	0	CMS61v5/FastingLDLTest - Preventive Care and Screening: Cholesterol - Fasting Low Density Lipoprotein (LDL-C) Test Performed- Moderate Risk	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b274d	measure_61_1_patient_summary
cms61v5	24	16	2	0	0	CMS61v5/FastingLDLTest - Preventive Care and Screening: Cholesterol - Fasting Low Density Lipoprotein (LDL-C) Test Performed- Low Risk	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b274e	measure_61_2_patient_summary
cms77v4	2	2	\N	1	\N	CMS77v4/HIVRNAControl - HIV/AIDS: RNA Control for Patients with HIV	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b275d	measure_77_0_patient_summary
cms65v5	2	2	0	1	\N	CMS65v5/HypertensionImprovement - Hypertension: Improvement in Blood Pressure	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2753	measure_65_0_patient_summary
cms74v5	15	15	\N	1	\N	CMS74v5/PrimaryCariesPrevention - Primary Caries Prevention Intervention as Offered by Primary Care Providers, including Dentists- 0-20	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2758	measure_74_0_patient_summary
cms74v5	5	5	\N	0	\N	CMS74v5/PrimaryCariesPrevention - Primary Caries Prevention Intervention as Offered by Primary Care Providers, including Dentists- RS1:=5	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2759	measure_74_1_patient_summary
cms74v5	6	6	\N	1	\N	CMS74v5/PrimaryCariesPrevention - Primary Caries Prevention Intervention as Offered by Primary Care Providers, including Dentists- RS2: 6-12	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b275a	measure_74_2_patient_summary
cms74v5	4	4	\N	0	\N	CMS74v5/PrimaryCariesPrevention - Primary Caries Prevention Intervention as Offered by Primary Care Providers, including Dentists- RS3: 13-20	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b275b	measure_74_3_patient_summary
cms146v4	3	3	1	1	\N	CMS146v4/0002 - Appropriate Testing for Children with Pharyngitis	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b2721	measure_146_0_event_summary
cms154v4	3	3	1	1	\N	CMS154v4/0069 - Appropriate Treatment for Children with Upper Respiratory Infection (URI)	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2728	measure_154_0_event_summary
cms161v4	3	3	\N	1	\N	CMS161v4/0104 - Adult Major Depressive Disorder (MDD): Suicide Risk Assessment	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b273a	measure_161_0_event_summary
cms157v4	3	3	\N	1	\N	CMS157v4/0384 - Oncology: Medical and Radiation - Pain Intensity Quantified	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2734	measure_157_0_event_summary
cms68v5	47	47	\N	1	1	CMS68v5/0419 - Documentation of Current Medications in the Medical Record	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2755	measure_68_0_event_summary
cms132v4	2	2	0	1	\N	CMS132v4/0564 - Cataracts: Complications within 30 Days Following Cataract Surgery Requiring Additional Surgical Procedures	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b270c	measure_132_0_event_summary
cms133v4	2	2	0	1	\N	CMS133v4/0565 - Cataracts: 20/40 or Better Visual Acuity within 90 Days Following Cataract Surgery	/product_tests/560e0fe2637970313e000008/measures/55c40dec2ae4dcb7a39b270d	measure_133_0_event_summary
cms177v4	3	3	\N	1	\N	CMS177v4/1365 - Child and Adolescent Major Depressive Disorder (MDD): Suicide Risk Assessment	/product_tests/560e0fe2637970313e000008/measures/55c40ded2ae4dcb7a39b2741	measure_177_0_event_summary
\.


--
-- Name: measure_117_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_117_0
    ADD CONSTRAINT measure_117_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_122_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_122_0
    ADD CONSTRAINT measure_122_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_123_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_123_0
    ADD CONSTRAINT measure_123_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_124_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_124_0
    ADD CONSTRAINT measure_124_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_125_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_125_0
    ADD CONSTRAINT measure_125_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_126_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_126_0
    ADD CONSTRAINT measure_126_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_126_1_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_126_1
    ADD CONSTRAINT measure_126_1_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_126_2_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_126_2
    ADD CONSTRAINT measure_126_2_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_126_3_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_126_3
    ADD CONSTRAINT measure_126_3_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_126_4_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_126_4
    ADD CONSTRAINT measure_126_4_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_127_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_127_0
    ADD CONSTRAINT measure_127_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_128_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_128_0
    ADD CONSTRAINT measure_128_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_128_1_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_128_1
    ADD CONSTRAINT measure_128_1_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_129_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_129_0
    ADD CONSTRAINT measure_129_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_130_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_130_0
    ADD CONSTRAINT measure_130_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_131_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_131_0
    ADD CONSTRAINT measure_131_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_132_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_132_0
    ADD CONSTRAINT measure_132_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_133_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_133_0
    ADD CONSTRAINT measure_133_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_134_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_134_0
    ADD CONSTRAINT measure_134_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_135_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_135_0
    ADD CONSTRAINT measure_135_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_136_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_136_0
    ADD CONSTRAINT measure_136_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_136_1_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_136_1
    ADD CONSTRAINT measure_136_1_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_137_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_137_0
    ADD CONSTRAINT measure_137_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_137_1_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_137_1
    ADD CONSTRAINT measure_137_1_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_137_2_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_137_2
    ADD CONSTRAINT measure_137_2_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_137_3_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_137_3
    ADD CONSTRAINT measure_137_3_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_137_4_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_137_4
    ADD CONSTRAINT measure_137_4_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_137_5_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_137_5
    ADD CONSTRAINT measure_137_5_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_138_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_138_0
    ADD CONSTRAINT measure_138_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_139_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_139_0
    ADD CONSTRAINT measure_139_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_140_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_140_0
    ADD CONSTRAINT measure_140_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_141_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_141_0
    ADD CONSTRAINT measure_141_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_142_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_142_0
    ADD CONSTRAINT measure_142_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_143_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_143_0
    ADD CONSTRAINT measure_143_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_144_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_144_0
    ADD CONSTRAINT measure_144_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_145_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_145_0
    ADD CONSTRAINT measure_145_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_145_1_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_145_1
    ADD CONSTRAINT measure_145_1_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_146_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_146_0
    ADD CONSTRAINT measure_146_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_147_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_147_0
    ADD CONSTRAINT measure_147_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_148_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_148_0
    ADD CONSTRAINT measure_148_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_149_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_149_0
    ADD CONSTRAINT measure_149_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_153_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_153_0
    ADD CONSTRAINT measure_153_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_153_1_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_153_1
    ADD CONSTRAINT measure_153_1_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_153_2_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_153_2
    ADD CONSTRAINT measure_153_2_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_154_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_154_0
    ADD CONSTRAINT measure_154_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_155_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_155_0
    ADD CONSTRAINT measure_155_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_155_1_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_155_1
    ADD CONSTRAINT measure_155_1_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_155_2_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_155_2
    ADD CONSTRAINT measure_155_2_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_155_3_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_155_3
    ADD CONSTRAINT measure_155_3_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_155_4_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_155_4
    ADD CONSTRAINT measure_155_4_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_155_5_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_155_5
    ADD CONSTRAINT measure_155_5_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_155_6_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_155_6
    ADD CONSTRAINT measure_155_6_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_155_7_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_155_7
    ADD CONSTRAINT measure_155_7_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_155_8_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_155_8
    ADD CONSTRAINT measure_155_8_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_156_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_156_0
    ADD CONSTRAINT measure_156_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_156_1_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_156_1
    ADD CONSTRAINT measure_156_1_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_157_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_157_0
    ADD CONSTRAINT measure_157_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_158_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_158_0
    ADD CONSTRAINT measure_158_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_159_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_159_0
    ADD CONSTRAINT measure_159_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_160_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_160_0
    ADD CONSTRAINT measure_160_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_160_1_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_160_1
    ADD CONSTRAINT measure_160_1_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_160_2_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_160_2
    ADD CONSTRAINT measure_160_2_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_161_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_161_0
    ADD CONSTRAINT measure_161_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_163_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_163_0
    ADD CONSTRAINT measure_163_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_164_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_164_0
    ADD CONSTRAINT measure_164_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_165_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_165_0
    ADD CONSTRAINT measure_165_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_166_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_166_0
    ADD CONSTRAINT measure_166_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_167_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_167_0
    ADD CONSTRAINT measure_167_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_169_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_169_0
    ADD CONSTRAINT measure_169_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_177_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_177_0
    ADD CONSTRAINT measure_177_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_182_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_182_0
    ADD CONSTRAINT measure_182_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_182_1_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_182_1
    ADD CONSTRAINT measure_182_1_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_22_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_22_0
    ADD CONSTRAINT measure_22_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_2_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_2_0
    ADD CONSTRAINT measure_2_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_50_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_50_0
    ADD CONSTRAINT measure_50_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_52_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_52_0
    ADD CONSTRAINT measure_52_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_52_1_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_52_1
    ADD CONSTRAINT measure_52_1_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_52_2_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_52_2
    ADD CONSTRAINT measure_52_2_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_56_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_56_0
    ADD CONSTRAINT measure_56_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_61_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_61_0
    ADD CONSTRAINT measure_61_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_61_1_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_61_1
    ADD CONSTRAINT measure_61_1_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_61_2_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_61_2
    ADD CONSTRAINT measure_61_2_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_62_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_62_0
    ADD CONSTRAINT measure_62_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_64_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_64_0
    ADD CONSTRAINT measure_64_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_64_1_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_64_1
    ADD CONSTRAINT measure_64_1_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_64_2_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_64_2
    ADD CONSTRAINT measure_64_2_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_65_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_65_0
    ADD CONSTRAINT measure_65_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_66_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_66_0
    ADD CONSTRAINT measure_66_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_68_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_68_0
    ADD CONSTRAINT measure_68_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_69_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_69_0
    ADD CONSTRAINT measure_69_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_69_1_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_69_1
    ADD CONSTRAINT measure_69_1_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_74_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_74_0
    ADD CONSTRAINT measure_74_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_74_1_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_74_1
    ADD CONSTRAINT measure_74_1_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_74_2_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_74_2
    ADD CONSTRAINT measure_74_2_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_74_3_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_74_3
    ADD CONSTRAINT measure_74_3_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_75_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_75_0
    ADD CONSTRAINT measure_75_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_77_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_77_0
    ADD CONSTRAINT measure_77_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_82_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_82_0
    ADD CONSTRAINT measure_82_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- Name: measure_90_0_lastname_firstname_key; Type: CONSTRAINT; Schema: answer_key; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measure_90_0
    ADD CONSTRAINT measure_90_0_lastname_firstname_key UNIQUE (lastname, firstname);


--
-- PostgreSQL database dump complete
--

