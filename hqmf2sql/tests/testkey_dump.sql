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
-- Name: expected_cypress_ep; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA expected_cypress_ep;


SET search_path = expected_cypress_ep, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cms122v3_patient_summary; Type: TABLE; Schema: expected_cypress_ep; Owner: -; Tablespace: 
--

CREATE TABLE cms122v3_patient_summary (
    population_id character varying(256),
    title character varying(256),
    strat_id character varying(256),
    patient_id integer,
    effective_ipp boolean,
    effective_denom boolean,
    effective_denex boolean,
    effective_numer boolean,
    effective_denexcep boolean
);


--
-- Name: cms123v3_patient_summary; Type: TABLE; Schema: expected_cypress_ep; Owner: -; Tablespace: 
--

CREATE TABLE cms123v3_patient_summary (
    population_id character varying(256),
    title character varying(256),
    strat_id character varying(256),
    patient_id integer,
    effective_ipp boolean,
    effective_denom boolean,
    effective_denex boolean,
    effective_numer boolean,
    effective_denexcep boolean
);


--
-- Name: cms126v3_patient_summary; Type: TABLE; Schema: expected_cypress_ep; Owner: -; Tablespace: 
--

CREATE TABLE cms126v3_patient_summary (
    population_id character varying(256),
    title character varying(256),
    strat_id character varying(256),
    patient_id integer,
    effective_ipp boolean,
    effective_denom boolean,
    effective_denex boolean,
    effective_numer boolean,
    effective_denexcep boolean
);


--
-- Name: cms127v3_patient_summary; Type: TABLE; Schema: expected_cypress_ep; Owner: -; Tablespace: 
--

CREATE TABLE cms127v3_patient_summary (
    population_id character varying(256),
    title character varying(256),
    strat_id character varying(256),
    patient_id integer,
    effective_ipp boolean,
    effective_denom boolean,
    effective_denex boolean,
    effective_numer boolean,
    effective_denexcep boolean
);


--
-- Name: cms139v3_patient_summary; Type: TABLE; Schema: expected_cypress_ep; Owner: -; Tablespace: 
--

CREATE TABLE cms139v3_patient_summary (
    population_id character varying(256),
    title character varying(256),
    strat_id character varying(256),
    patient_id integer,
    effective_ipp boolean,
    effective_denom boolean,
    effective_denex boolean,
    effective_numer boolean,
    effective_denexcep boolean
);


--
-- Name: cms148v3_patient_summary; Type: TABLE; Schema: expected_cypress_ep; Owner: -; Tablespace: 
--

CREATE TABLE cms148v3_patient_summary (
    population_id character varying(256),
    title character varying(256),
    strat_id character varying(256),
    patient_id integer,
    effective_ipp boolean,
    effective_denom boolean,
    effective_denex boolean,
    effective_numer boolean,
    effective_denexcep boolean
);


--
-- Name: cms163v3_patient_summary; Type: TABLE; Schema: expected_cypress_ep; Owner: -; Tablespace: 
--

CREATE TABLE cms163v3_patient_summary (
    population_id character varying(256),
    title character varying(256),
    strat_id character varying(256),
    patient_id integer,
    effective_ipp boolean,
    effective_denom boolean,
    effective_denex boolean,
    effective_numer boolean,
    effective_denexcep boolean
);


--
-- Name: cms164v3_patient_summary; Type: TABLE; Schema: expected_cypress_ep; Owner: -; Tablespace: 
--

CREATE TABLE cms164v3_patient_summary (
    population_id character varying(256),
    title character varying(256),
    strat_id character varying(256),
    patient_id integer,
    effective_ipp boolean,
    effective_denom boolean,
    effective_denex boolean,
    effective_numer boolean,
    effective_denexcep boolean
);


--
-- Name: cms182v4_patient_summary; Type: TABLE; Schema: expected_cypress_ep; Owner: -; Tablespace: 
--

CREATE TABLE cms182v4_patient_summary (
    population_id character varying(256),
    title character varying(256),
    strat_id character varying(256),
    patient_id integer,
    effective_ipp boolean,
    effective_denom boolean,
    effective_denex boolean,
    effective_numer boolean,
    effective_denexcep boolean
);


--
-- Name: cms69v3_patient_summary; Type: TABLE; Schema: expected_cypress_ep; Owner: -; Tablespace: 
--

CREATE TABLE cms69v3_patient_summary (
    population_id character varying(256),
    title character varying(256),
    strat_id character varying(256),
    patient_id integer,
    effective_ipp boolean,
    effective_denom boolean,
    effective_denex boolean,
    effective_numer boolean,
    effective_denexcep boolean
);


--
-- Name: cms74v4_patient_summary; Type: TABLE; Schema: expected_cypress_ep; Owner: -; Tablespace: 
--

CREATE TABLE cms74v4_patient_summary (
    population_id character varying(256),
    title character varying(256),
    strat_id character varying(256),
    patient_id integer,
    effective_ipp boolean,
    effective_denom boolean,
    effective_denex boolean,
    effective_numer boolean,
    effective_denexcep boolean
);


--
-- Name: cms75v3_patient_summary; Type: TABLE; Schema: expected_cypress_ep; Owner: -; Tablespace: 
--

CREATE TABLE cms75v3_patient_summary (
    population_id character varying(256),
    title character varying(256),
    strat_id character varying(256),
    patient_id integer,
    effective_ipp boolean,
    effective_denom boolean,
    effective_denex boolean,
    effective_numer boolean,
    effective_denexcep boolean
);


--
-- Name: cms82v2_patient_summary; Type: TABLE; Schema: expected_cypress_ep; Owner: -; Tablespace: 
--

CREATE TABLE cms82v2_patient_summary (
    population_id character varying(256),
    title character varying(256),
    strat_id character varying(256),
    patient_id integer,
    effective_ipp boolean,
    effective_denom boolean,
    effective_denex boolean,
    effective_numer boolean,
    effective_denexcep boolean
);


--
-- Data for Name: cms122v3_patient_summary; Type: TABLE DATA; Schema: expected_cypress_ep; Owner: -
--

COPY cms122v3_patient_summary (population_id, title, strat_id, patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) FROM stdin;
\N	\N	\N	7	t	t	\N	t	\N
\N	\N	\N	24	t	t	\N	t	\N
\N	\N	\N	16	t	t	\N	t	\N
\N	\N	\N	40	t	t	\N	t	\N
\.


--
-- Data for Name: cms123v3_patient_summary; Type: TABLE DATA; Schema: expected_cypress_ep; Owner: -
--

COPY cms123v3_patient_summary (population_id, title, strat_id, patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) FROM stdin;
\N	\N	\N	24	t	t	\N	f	\N
\N	\N	\N	7	t	t	\N	f	\N
\N	\N	\N	16	t	t	\N	t	\N
\N	\N	\N	40	t	t	\N	t	\N
\.


--
-- Data for Name: cms126v3_patient_summary; Type: TABLE DATA; Schema: expected_cypress_ep; Owner: -
--

COPY cms126v3_patient_summary (population_id, title, strat_id, patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) FROM stdin;
Population1	5-64	\N	17	t	t	f	t	\N
Population1	5-64	\N	20	t	t	t	f	\N
Population1	5-64	\N	10	t	t	f	f	\N
Population1	5-64	\N	3	t	t	f	f	\N
Population2	RS1: 5-11	40280381-3D61-56A7-013E-66493A34443E	17	f	f	f	f	\N
Population2	RS1: 5-11	40280381-3D61-56A7-013E-66493A34443E	3	f	f	f	f	\N
Population2	RS1: 5-11	40280381-3D61-56A7-013E-66493A34443E	10	f	f	f	f	\N
Population2	RS1: 5-11	40280381-3D61-56A7-013E-66493A34443E	20	f	f	f	f	\N
Population3	RS2: 12-18	40280381-3D61-56A7-013E-66493BC34440	17	t	t	f	t	\N
Population3	RS2: 12-18	40280381-3D61-56A7-013E-66493BC34440	3	t	t	f	f	\N
Population3	RS2: 12-18	40280381-3D61-56A7-013E-66493BC34440	10	t	t	f	f	\N
Population3	RS2: 12-18	40280381-3D61-56A7-013E-66493BC34440	20	f	f	f	f	\N
Population4	RS3: 19-50	40280381-3D61-56A7-013E-66493D314442	10	f	f	f	f	\N
Population4	RS3: 19-50	40280381-3D61-56A7-013E-66493D314442	20	f	f	f	f	\N
Population4	RS3: 19-50	40280381-3D61-56A7-013E-66493D314442	3	f	f	f	f	\N
Population4	RS3: 19-50	40280381-3D61-56A7-013E-66493D314442	17	f	f	f	f	\N
Population5	RS4: 51-64	40280381-3D61-56A7-013E-66493E984444	17	f	f	f	f	\N
Population5	RS4: 51-64	40280381-3D61-56A7-013E-66493E984444	3	f	f	f	f	\N
Population5	RS4: 51-64	40280381-3D61-56A7-013E-66493E984444	20	f	f	f	f	\N
Population5	RS4: 51-64	40280381-3D61-56A7-013E-66493E984444	10	f	f	f	f	\N
\.


--
-- Data for Name: cms127v3_patient_summary; Type: TABLE DATA; Schema: expected_cypress_ep; Owner: -
--

COPY cms127v3_patient_summary (population_id, title, strat_id, patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) FROM stdin;
\N	\N	\N	28	t	t	\N	f	\N
\N	\N	\N	34	t	t	\N	f	\N
\N	\N	\N	4	t	t	\N	f	\N
\N	\N	\N	35	t	t	\N	f	\N
\N	\N	\N	37	t	t	\N	t	\N
\N	\N	\N	38	t	t	\N	f	\N
\.


--
-- Data for Name: cms139v3_patient_summary; Type: TABLE DATA; Schema: expected_cypress_ep; Owner: -
--

COPY cms139v3_patient_summary (population_id, title, strat_id, patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) FROM stdin;
\N	\N	\N	28	t	t	\N	f	\N
\N	\N	\N	34	t	t	\N	f	\N
\N	\N	\N	4	t	t	\N	f	\N
\N	\N	\N	35	t	t	\N	f	\N
\N	\N	\N	37	t	t	\N	t	\N
\N	\N	\N	38	t	t	\N	f	\N
\.


--
-- Data for Name: cms148v3_patient_summary; Type: TABLE DATA; Schema: expected_cypress_ep; Owner: -
--

COPY cms148v3_patient_summary (population_id, title, strat_id, patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) FROM stdin;
\N	\N	\N	8	t	t	\N	f	\N
\N	\N	\N	36	t	t	\N	t	\N
\.


--
-- Data for Name: cms163v3_patient_summary; Type: TABLE DATA; Schema: expected_cypress_ep; Owner: -
--

COPY cms163v3_patient_summary (population_id, title, strat_id, patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) FROM stdin;
\N	\N	\N	24	t	t	\N	f	\N
\N	\N	\N	7	t	t	\N	f	\N
\N	\N	\N	16	t	t	\N	t	\N
\N	\N	\N	40	t	t	\N	t	\N
\.


--
-- Data for Name: cms164v3_patient_summary; Type: TABLE DATA; Schema: expected_cypress_ep; Owner: -
--

COPY cms164v3_patient_summary (population_id, title, strat_id, patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) FROM stdin;
\N	\N	\N	28	t	t	\N	f	\N
\N	\N	\N	34	t	t	\N	t	\N
\N	\N	\N	35	t	t	\N	f	\N
\.


--
-- Data for Name: cms182v4_patient_summary; Type: TABLE DATA; Schema: expected_cypress_ep; Owner: -
--

COPY cms182v4_patient_summary (population_id, title, strat_id, patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) FROM stdin;
Population1	Complete Lipid Profile	\N	28	t	t	\N	f	\N
Population1	Complete Lipid Profile	\N	34	t	t	\N	t	\N
Population1	Complete Lipid Profile	\N	35	t	t	\N	f	\N
Population2	Most Recent LDL-C \\\\u003C100 mg/dL	\N	35	t	t	\N	f	\N
Population2	Most Recent LDL-C \\\\u003C100 mg/dL	\N	28	t	t	\N	f	\N
Population2	Most Recent LDL-C \\\\u003C100 mg/dL	\N	34	t	t	\N	t	\N
\.


--
-- Data for Name: cms69v3_patient_summary; Type: TABLE DATA; Schema: expected_cypress_ep; Owner: -
--

COPY cms69v3_patient_summary (population_id, title, strat_id, patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) FROM stdin;
Population1	18-64	\N	5	t	t	f	f	\N
Population1	18-64	\N	24	t	t	f	f	\N
Population1	18-64	\N	33	t	t	f	f	\N
Population1	18-64	\N	1	t	t	f	f	\N
Population1	18-64	\N	15	t	t	f	f	\N
Population1	18-64	\N	25	t	t	f	f	\N
Population1	18-64	\N	11	t	t	f	f	\N
Population1	18-64	\N	29	t	t	f	f	\N
Population1	18-64	\N	40	t	t	f	f	\N
Population1	18-64	\N	18	t	t	f	f	\N
Population1	18-64	\N	23	t	t	f	f	\N
Population1	18-64	\N	22	t	t	f	f	\N
Population1	18-64	\N	16	t	t	f	f	\N
Population1	18-64	\N	7	t	t	f	f	\N
Population1	18-64	\N	14	t	t	f	f	\N
Population1	18-64	\N	30	t	t	t	f	\N
Population1	18-64	\N	41	t	t	f	t	\N
Population1	18-64	\N	6	t	t	f	f	\N
Population1	18-64	\N	21	t	t	f	f	\N
Population2	65+	\N	4	t	t	f	f	\N
Population2	65+	\N	28	t	t	f	f	\N
Population2	65+	\N	35	t	t	f	f	\N
Population2	65+	\N	38	t	t	f	f	\N
Population2	65+	\N	34	t	t	f	f	\N
Population2	65+	\N	37	t	t	f	f	\N
\.


--
-- Data for Name: cms74v4_patient_summary; Type: TABLE DATA; Schema: expected_cypress_ep; Owner: -
--

COPY cms74v4_patient_summary (population_id, title, strat_id, patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) FROM stdin;
Population1	0-20	\N	13	t	t	\N	f	\N
Population1	0-20	\N	39	t	t	\N	f	\N
Population1	0-20	\N	10	t	t	\N	f	\N
Population1	0-20	\N	31	t	t	\N	f	\N
Population1	0-20	\N	2	t	t	\N	f	\N
Population1	0-20	\N	8	t	t	\N	f	\N
Population1	0-20	\N	20	t	t	\N	f	\N
Population1	0-20	\N	32	t	t	\N	f	\N
Population1	0-20	\N	3	t	t	\N	f	\N
Population1	0-20	\N	9	t	t	\N	t	\N
Population1	0-20	\N	12	t	t	\N	f	\N
Population1	0-20	\N	0	t	t	\N	f	\N
Population1	0-20	\N	19	t	t	\N	f	\N
Population1	0-20	\N	36	t	t	\N	f	\N
Population1	0-20	\N	17	t	t	\N	f	\N
Population2	RS1: \\\\u003C= 5	40280381-3E93-D1AF-013E-E72A14EC22D9	9	f	f	\N	f	\N
Population2	RS1: \\\\u003C= 5	40280381-3E93-D1AF-013E-E72A14EC22D9	36	f	f	\N	f	\N
Population2	RS1: \\\\u003C= 5	40280381-3E93-D1AF-013E-E72A14EC22D9	3	f	f	\N	f	\N
Population2	RS1: \\\\u003C= 5	40280381-3E93-D1AF-013E-E72A14EC22D9	31	t	t	\N	f	\N
Population2	RS1: \\\\u003C= 5	40280381-3E93-D1AF-013E-E72A14EC22D9	17	f	f	\N	f	\N
Population2	RS1: \\\\u003C= 5	40280381-3E93-D1AF-013E-E72A14EC22D9	2	f	f	\N	f	\N
Population2	RS1: \\\\u003C= 5	40280381-3E93-D1AF-013E-E72A14EC22D9	32	f	f	\N	f	\N
Population2	RS1: \\\\u003C= 5	40280381-3E93-D1AF-013E-E72A14EC22D9	10	f	f	\N	f	\N
Population2	RS1: \\\\u003C= 5	40280381-3E93-D1AF-013E-E72A14EC22D9	13	f	f	\N	f	\N
Population2	RS1: \\\\u003C= 5	40280381-3E93-D1AF-013E-E72A14EC22D9	39	f	f	\N	f	\N
Population2	RS1: \\\\u003C= 5	40280381-3E93-D1AF-013E-E72A14EC22D9	0	t	t	\N	f	\N
Population2	RS1: \\\\u003C= 5	40280381-3E93-D1AF-013E-E72A14EC22D9	8	f	f	\N	f	\N
Population2	RS1: \\\\u003C= 5	40280381-3E93-D1AF-013E-E72A14EC22D9	19	t	t	\N	f	\N
Population2	RS1: \\\\u003C= 5	40280381-3E93-D1AF-013E-E72A14EC22D9	20	f	f	\N	f	\N
Population2	RS1: \\\\u003C= 5	40280381-3E93-D1AF-013E-E72A14EC22D9	12	t	t	\N	f	\N
Population3	RS2: 6-12	40280381-3E93-D1AF-013E-E72A164322DB	0	f	f	\N	f	\N
Population3	RS2: 6-12	40280381-3E93-D1AF-013E-E72A164322DB	8	t	t	\N	f	\N
Population3	RS2: 6-12	40280381-3E93-D1AF-013E-E72A164322DB	19	f	f	\N	f	\N
Population3	RS2: 6-12	40280381-3E93-D1AF-013E-E72A164322DB	20	t	t	\N	f	\N
Population3	RS2: 6-12	40280381-3E93-D1AF-013E-E72A164322DB	3	f	f	\N	f	\N
Population3	RS2: 6-12	40280381-3E93-D1AF-013E-E72A164322DB	12	f	f	\N	f	\N
Population3	RS2: 6-12	40280381-3E93-D1AF-013E-E72A164322DB	17	f	f	\N	f	\N
Population3	RS2: 6-12	40280381-3E93-D1AF-013E-E72A164322DB	31	f	f	\N	f	\N
Population3	RS2: 6-12	40280381-3E93-D1AF-013E-E72A164322DB	2	t	t	\N	f	\N
Population3	RS2: 6-12	40280381-3E93-D1AF-013E-E72A164322DB	32	t	t	\N	f	\N
Population3	RS2: 6-12	40280381-3E93-D1AF-013E-E72A164322DB	10	f	f	\N	f	\N
Population3	RS2: 6-12	40280381-3E93-D1AF-013E-E72A164322DB	13	f	f	\N	f	\N
Population3	RS2: 6-12	40280381-3E93-D1AF-013E-E72A164322DB	39	f	f	\N	f	\N
Population3	RS2: 6-12	40280381-3E93-D1AF-013E-E72A164322DB	36	t	t	\N	f	\N
Population3	RS2: 6-12	40280381-3E93-D1AF-013E-E72A164322DB	9	t	t	\N	t	\N
Population4	RS3: 13-20	40280381-3E93-D1AF-013E-E72A179D22DD	17	t	t	\N	f	\N
Population4	RS3: 13-20	40280381-3E93-D1AF-013E-E72A179D22DD	3	t	t	\N	f	\N
Population4	RS3: 13-20	40280381-3E93-D1AF-013E-E72A179D22DD	31	f	f	\N	f	\N
Population4	RS3: 13-20	40280381-3E93-D1AF-013E-E72A179D22DD	2	f	f	\N	f	\N
Population4	RS3: 13-20	40280381-3E93-D1AF-013E-E72A179D22DD	8	f	f	\N	f	\N
Population4	RS3: 13-20	40280381-3E93-D1AF-013E-E72A179D22DD	20	f	f	\N	f	\N
Population4	RS3: 13-20	40280381-3E93-D1AF-013E-E72A179D22DD	32	f	f	\N	f	\N
Population4	RS3: 13-20	40280381-3E93-D1AF-013E-E72A179D22DD	12	f	f	\N	f	\N
Population4	RS3: 13-20	40280381-3E93-D1AF-013E-E72A179D22DD	0	f	f	\N	f	\N
Population4	RS3: 13-20	40280381-3E93-D1AF-013E-E72A179D22DD	19	f	f	\N	f	\N
Population4	RS3: 13-20	40280381-3E93-D1AF-013E-E72A179D22DD	9	f	f	\N	f	\N
Population4	RS3: 13-20	40280381-3E93-D1AF-013E-E72A179D22DD	36	f	f	\N	f	\N
Population4	RS3: 13-20	40280381-3E93-D1AF-013E-E72A179D22DD	39	t	t	\N	f	\N
Population4	RS3: 13-20	40280381-3E93-D1AF-013E-E72A179D22DD	13	t	t	\N	f	\N
Population4	RS3: 13-20	40280381-3E93-D1AF-013E-E72A179D22DD	10	t	t	\N	f	\N
\.


--
-- Data for Name: cms75v3_patient_summary; Type: TABLE DATA; Schema: expected_cypress_ep; Owner: -
--

COPY cms75v3_patient_summary (population_id, title, strat_id, patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) FROM stdin;
\N	\N	\N	31	t	t	\N	f	\N
\N	\N	\N	8	t	t	\N	f	\N
\N	\N	\N	20	t	t	\N	f	\N
\N	\N	\N	13	t	t	\N	f	\N
\N	\N	\N	39	t	t	\N	f	\N
\N	\N	\N	10	t	t	\N	f	\N
\N	\N	\N	36	t	t	\N	f	\N
\N	\N	\N	17	t	t	\N	f	\N
\N	\N	\N	2	t	t	\N	f	\N
\N	\N	\N	32	t	t	\N	f	\N
\N	\N	\N	3	t	t	\N	f	\N
\N	\N	\N	9	t	t	\N	t	\N
\N	\N	\N	12	t	t	\N	f	\N
\N	\N	\N	0	t	t	\N	f	\N
\N	\N	\N	19	t	t	\N	f	\N
\.


--
-- Data for Name: cms82v2_patient_summary; Type: TABLE DATA; Schema: expected_cypress_ep; Owner: -
--

COPY cms82v2_patient_summary (population_id, title, strat_id, patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) FROM stdin;
\N	\N	\N	19	t	t	\N	t	\N
\N	\N	\N	12	t	t	\N	f	\N
\.


--
-- PostgreSQL database dump complete
--

