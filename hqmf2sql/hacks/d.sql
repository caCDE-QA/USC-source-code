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
-- Name: export_valuesets; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA export_valuesets;


SET search_path = export_valuesets, pg_catalog;

--
-- Name: ydm_to_date(numeric, numeric, numeric); Type: FUNCTION; Schema: export_valuesets; Owner: -
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


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: arrayed_vocabulary_map; Type: TABLE; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE TABLE arrayed_vocabulary_map (
    hqmf_code_system_oid text,
    overflow_vocabulary_id integer,
    vocabulary_ids integer[]
);


--
-- Name: hqmf_code_lists; Type: TABLE; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE TABLE hqmf_code_lists (
    code integer,
    code_list_id text
);


--
-- Name: TABLE hqmf_code_lists; Type: COMMENT; Schema: export_valuesets; Owner: -
--

COMMENT ON TABLE hqmf_code_lists IS 'Derived table - associates OMOP concepts (for individual codes) to HQMF vocabulary IDs';


--
-- Name: COLUMN hqmf_code_lists.code; Type: COMMENT; Schema: export_valuesets; Owner: -
--

COMMENT ON COLUMN hqmf_code_lists.code IS 'Concept ID associated with a particular code.';


--
-- Name: COLUMN hqmf_code_lists.code_list_id; Type: COMMENT; Schema: export_valuesets; Owner: -
--

COMMENT ON COLUMN hqmf_code_lists.code_list_id IS 'HQMF vocabulary OID.';


--
-- Name: omop_level_2_concept_code_lists; Type: TABLE; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE TABLE omop_level_2_concept_code_lists (
    code integer,
    code_list_id text
);


--
-- Name: code_lists; Type: VIEW; Schema: export_valuesets; Owner: -
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
-- Name: code_lists_value_set_reverse_map; Type: TABLE; Schema: export_valuesets; Owner: -; Tablespace: 
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
-- Name: hl7_template_xref; Type: TABLE; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE TABLE hl7_template_xref (
    template_id text,
    template_name text
);


--
-- Name: med_status_map; Type: TABLE; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE TABLE med_status_map (
    omop_concept_id integer,
    hqmf_status text
);


--
-- Name: overflow_vocabulary_map; Type: TABLE; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE TABLE overflow_vocabulary_map (
    overflow_vocabulary_name text NOT NULL,
    hqmf_code_system_oid text NOT NULL,
    hqmf_code_system_name text NOT NULL,
    hqmf_code_system_versions text[]
);


--
-- Name: TABLE overflow_vocabulary_map; Type: COMMENT; Schema: export_valuesets; Owner: -
--

COMMENT ON TABLE overflow_vocabulary_map IS 'Some codes that appear in value sets do not have corresponding OMOP concept IDs. This table defines vocabularies to use when creating new concept IDs for those codes.';


--
-- Name: COLUMN overflow_vocabulary_map.overflow_vocabulary_name; Type: COMMENT; Schema: export_valuesets; Owner: -
--

COMMENT ON COLUMN overflow_vocabulary_map.overflow_vocabulary_name IS 'Name of overflow vocabulary';


--
-- Name: COLUMN overflow_vocabulary_map.hqmf_code_system_oid; Type: COMMENT; Schema: export_valuesets; Owner: -
--

COMMENT ON COLUMN overflow_vocabulary_map.hqmf_code_system_oid IS 'Vocabulary OID (corresponds to value_set_entries.code_system)';


--
-- Name: COLUMN overflow_vocabulary_map.hqmf_code_system_name; Type: COMMENT; Schema: export_valuesets; Owner: -
--

COMMENT ON COLUMN overflow_vocabulary_map.hqmf_code_system_name IS 'Vocabulary name (from HQMF, for display only)';


--
-- Name: COLUMN overflow_vocabulary_map.hqmf_code_system_versions; Type: COMMENT; Schema: export_valuesets; Owner: -
--

COMMENT ON COLUMN overflow_vocabulary_map.hqmf_code_system_versions IS 'Vocabulary versions (from HQMF)';


--
-- Name: overflow_vocabulary_sequence; Type: SEQUENCE; Schema: export_valuesets; Owner: -
--

CREATE SEQUENCE overflow_vocabulary_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: unified_vocabulary_map; Type: TABLE; Schema: export_valuesets; Owner: -; Tablespace: 
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
-- Name: value_set_entries; Type: TABLE; Schema: export_valuesets; Owner: -; Tablespace: 
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
-- Name: TABLE value_set_entries; Type: COMMENT; Schema: export_valuesets; Owner: -
--

COMMENT ON TABLE value_set_entries IS 'Value set entries (from standard value set definitions)';


--
-- Name: unique_code_systems; Type: VIEW; Schema: export_valuesets; Owner: -
--

CREATE VIEW unique_code_systems AS
 SELECT DISTINCT value_set_entries.code_system,
    value_set_entries.code_system_name,
    value_set_entries.code_system_version
   FROM value_set_entries;


--
-- Name: value_code_xref; Type: TABLE; Schema: export_valuesets; Owner: -; Tablespace: 
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
-- Name: value_set_code_systems; Type: TABLE; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE TABLE value_set_code_systems (
    value_set_oid text NOT NULL,
    code_system text NOT NULL,
    code_system_name text
);


--
-- Name: value_set_code_xref; Type: TABLE; Schema: export_valuesets; Owner: -; Tablespace: 
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
-- Name: value_set_entries_value_set_entry_id_seq; Type: SEQUENCE; Schema: export_valuesets; Owner: -
--

CREATE SEQUENCE value_set_entries_value_set_entry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: value_set_entries_value_set_entry_id_seq; Type: SEQUENCE OWNED BY; Schema: export_valuesets; Owner: -
--

ALTER SEQUENCE value_set_entries_value_set_entry_id_seq OWNED BY value_set_entries.value_set_entry_id;


--
-- Name: value_set_sanity_checks; Type: TABLE; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE TABLE value_set_sanity_checks (
    test_name text,
    passed boolean
);


--
-- Name: value_sets; Type: TABLE; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE TABLE value_sets (
    value_set_oid text NOT NULL,
    value_set_name text NOT NULL,
    value_set_version text NOT NULL
);


--
-- Name: TABLE value_sets; Type: COMMENT; Schema: export_valuesets; Owner: -
--

COMMENT ON TABLE value_sets IS 'Value set names (from standard value set definitions)';


--
-- Name: vocabulary_map; Type: TABLE; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE TABLE vocabulary_map (
    hqmf_code_system_oid text NOT NULL,
    hqmf_code_system_name text NOT NULL,
    hqmf_code_system_version text,
    omop_vocabulary_id integer
);


--
-- Name: TABLE vocabulary_map; Type: COMMENT; Schema: export_valuesets; Owner: -
--

COMMENT ON TABLE vocabulary_map IS 'Mapping of NLM value set OIDs to OMOP vocabulary IDs';


--
-- Name: COLUMN vocabulary_map.hqmf_code_system_oid; Type: COMMENT; Schema: export_valuesets; Owner: -
--

COMMENT ON COLUMN vocabulary_map.hqmf_code_system_oid IS 'Code system OID; corresponds to the code_system column of value_set_entries';


--
-- Name: COLUMN vocabulary_map.hqmf_code_system_name; Type: COMMENT; Schema: export_valuesets; Owner: -
--

COMMENT ON COLUMN vocabulary_map.hqmf_code_system_name IS 'Code system name; used for display purposes only';


--
-- Name: COLUMN vocabulary_map.omop_vocabulary_id; Type: COMMENT; Schema: export_valuesets; Owner: -
--

COMMENT ON COLUMN vocabulary_map.omop_vocabulary_id IS 'OMOP vocabulary id';


--
-- Name: value_set_entry_id; Type: DEFAULT; Schema: export_valuesets; Owner: -
--

ALTER TABLE ONLY value_set_entries ALTER COLUMN value_set_entry_id SET DEFAULT nextval('value_set_entries_value_set_entry_id_seq'::regclass);


--
-- Data for Name: arrayed_vocabulary_map; Type: TABLE DATA; Schema: export_valuesets; Owner: -
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
-- Data for Name: code_lists_value_set_reverse_map; Type: TABLE DATA; Schema: export_valuesets; Owner: -
--

COPY code_lists_value_set_reverse_map (value_set_oid, value_set_name, code_system, code_system_name, concept_id, concept_code, concept_name, vocabulary_id, vocabulary_name, in_original_value_set) FROM stdin;
\.


--
-- Data for Name: hl7_template_xref; Type: TABLE DATA; Schema: export_valuesets; Owner: -
--

COPY hl7_template_xref (template_id, template_name) FROM stdin;
\.


--
-- Data for Name: hqmf_code_lists; Type: TABLE DATA; Schema: export_valuesets; Owner: -
--

COPY hqmf_code_lists (code, code_list_id) FROM stdin;
\.


--
-- Data for Name: med_status_map; Type: TABLE DATA; Schema: export_valuesets; Owner: -
--

COPY med_status_map (omop_concept_id, hqmf_status) FROM stdin;
\.


--
-- Data for Name: omop_level_2_concept_code_lists; Type: TABLE DATA; Schema: export_valuesets; Owner: -
--

COPY omop_level_2_concept_code_lists (code, code_list_id) FROM stdin;
\.


--
-- Data for Name: overflow_vocabulary_map; Type: TABLE DATA; Schema: export_valuesets; Owner: -
--

COPY overflow_vocabulary_map (overflow_vocabulary_name, hqmf_code_system_oid, hqmf_code_system_name, hqmf_code_system_versions) FROM stdin;
\.


--
-- Name: overflow_vocabulary_sequence; Type: SEQUENCE SET; Schema: export_valuesets; Owner: -
--

SELECT pg_catalog.setval('overflow_vocabulary_sequence', 1, false);


--
-- Data for Name: unified_vocabulary_map; Type: TABLE DATA; Schema: export_valuesets; Owner: -
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
-- Data for Name: value_code_xref; Type: TABLE DATA; Schema: export_valuesets; Owner: -
--

COPY value_code_xref (code, code_system, code_system_name, display_name, concept_id, concept_name) FROM stdin;
\.


--
-- Data for Name: value_set_code_systems; Type: TABLE DATA; Schema: export_valuesets; Owner: -
--

COPY value_set_code_systems (value_set_oid, code_system, code_system_name) FROM stdin;
\.


--
-- Data for Name: value_set_code_xref; Type: TABLE DATA; Schema: export_valuesets; Owner: -
--

COPY value_set_code_xref (value_set_name, value_set_oid, code_system, code, code_system_name, display_name, concept_id, concept_name) FROM stdin;
\.


--
-- Data for Name: value_set_entries; Type: TABLE DATA; Schema: export_valuesets; Owner: -
--

COPY value_set_entries (value_set_entry_id, value_set_oid, code, code_system, code_system_name, code_system_version, display_name, black_list, white_list) FROM stdin;
\.


--
-- Name: value_set_entries_value_set_entry_id_seq; Type: SEQUENCE SET; Schema: export_valuesets; Owner: -
--

SELECT pg_catalog.setval('value_set_entries_value_set_entry_id_seq', 1, false);


--
-- Data for Name: value_set_sanity_checks; Type: TABLE DATA; Schema: export_valuesets; Owner: -
--

COPY value_set_sanity_checks (test_name, passed) FROM stdin;
\.


--
-- Data for Name: value_sets; Type: TABLE DATA; Schema: export_valuesets; Owner: -
--

COPY value_sets (value_set_oid, value_set_name, value_set_version) FROM stdin;
\.


--
-- Data for Name: vocabulary_map; Type: TABLE DATA; Schema: export_valuesets; Owner: -
--

COPY vocabulary_map (hqmf_code_system_oid, hqmf_code_system_name, hqmf_code_system_version, omop_vocabulary_id) FROM stdin;
\.


--
-- Name: overflow_vocabulary_map_hqmf_code_system_oid_key; Type: CONSTRAINT; Schema: export_valuesets; Owner: -; Tablespace: 
--

ALTER TABLE ONLY overflow_vocabulary_map
    ADD CONSTRAINT overflow_vocabulary_map_hqmf_code_system_oid_key UNIQUE (hqmf_code_system_oid);


--
-- Name: overflow_vocabulary_map_pkey; Type: CONSTRAINT; Schema: export_valuesets; Owner: -; Tablespace: 
--

ALTER TABLE ONLY overflow_vocabulary_map
    ADD CONSTRAINT overflow_vocabulary_map_pkey PRIMARY KEY (overflow_vocabulary_name);


--
-- Name: value_set_code_systems_pkey; Type: CONSTRAINT; Schema: export_valuesets; Owner: -; Tablespace: 
--

ALTER TABLE ONLY value_set_code_systems
    ADD CONSTRAINT value_set_code_systems_pkey PRIMARY KEY (value_set_oid, code_system);

ALTER TABLE value_set_code_systems CLUSTER ON value_set_code_systems_pkey;


--
-- Name: value_set_entries_pkey; Type: CONSTRAINT; Schema: export_valuesets; Owner: -; Tablespace: 
--

ALTER TABLE ONLY value_set_entries
    ADD CONSTRAINT value_set_entries_pkey PRIMARY KEY (value_set_entry_id);


--
-- Name: value_set_entries_value_set_oid_code_system_code_key; Type: CONSTRAINT; Schema: export_valuesets; Owner: -; Tablespace: 
--

ALTER TABLE ONLY value_set_entries
    ADD CONSTRAINT value_set_entries_value_set_oid_code_system_code_key UNIQUE (value_set_oid, code_system, code);


--
-- Name: value_sets_pkey; Type: CONSTRAINT; Schema: export_valuesets; Owner: -; Tablespace: 
--

ALTER TABLE ONLY value_sets
    ADD CONSTRAINT value_sets_pkey PRIMARY KEY (value_set_oid);


--
-- Name: code_lists_value_set_reverse_map_code_system_value_set_oid_idx; Type: INDEX; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE INDEX code_lists_value_set_reverse_map_code_system_value_set_oid_idx ON code_lists_value_set_reverse_map USING btree (code_system, value_set_oid);

ALTER TABLE code_lists_value_set_reverse_map CLUSTER ON code_lists_value_set_reverse_map_code_system_value_set_oid_idx;


--
-- Name: code_lists_value_set_reverse_map_in_original_value_set_idx; Type: INDEX; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE INDEX code_lists_value_set_reverse_map_in_original_value_set_idx ON code_lists_value_set_reverse_map USING btree (in_original_value_set);


--
-- Name: hqmf_code_lists_code_idx; Type: INDEX; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE INDEX hqmf_code_lists_code_idx ON hqmf_code_lists USING btree (code);

ALTER TABLE hqmf_code_lists CLUSTER ON hqmf_code_lists_code_idx;


--
-- Name: hqmf_code_lists_code_list_id_idx; Type: INDEX; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE INDEX hqmf_code_lists_code_list_id_idx ON hqmf_code_lists USING btree (code_list_id);


--
-- Name: value_code_xref_code_system_code_idx; Type: INDEX; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE INDEX value_code_xref_code_system_code_idx ON value_code_xref USING btree (code_system, code);

ALTER TABLE value_code_xref CLUSTER ON value_code_xref_code_system_code_idx;


--
-- Name: value_set_entries_code; Type: INDEX; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE INDEX value_set_entries_code ON value_set_entries USING btree (code);


--
-- Name: value_set_entries_code_system_name_version_code; Type: INDEX; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE INDEX value_set_entries_code_system_name_version_code ON value_set_entries USING btree (code_system_name, code_system_version, code);


--
-- Name: value_set_entries_code_system_value_set_code; Type: INDEX; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE INDEX value_set_entries_code_system_value_set_code ON value_set_entries USING btree (code_system, value_set_oid, code);

ALTER TABLE value_set_entries CLUSTER ON value_set_entries_code_system_value_set_code;


--
-- Name: value_set_entries_code_system_version_code; Type: INDEX; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE INDEX value_set_entries_code_system_version_code ON value_set_entries USING btree (code_system, code_system_version, code);


--
-- Name: value_set_entries_value_set_oid; Type: INDEX; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE INDEX value_set_entries_value_set_oid ON value_set_entries USING btree (value_set_oid);


--
-- Name: vocabulary_map_hqmf_idx; Type: INDEX; Schema: export_valuesets; Owner: -; Tablespace: 
--

CREATE INDEX vocabulary_map_hqmf_idx ON vocabulary_map USING btree (hqmf_code_system_oid, hqmf_code_system_version);


--
-- Name: value_set_entries_value_set_oid_fkey; Type: FK CONSTRAINT; Schema: export_valuesets; Owner: -
--

ALTER TABLE ONLY value_set_entries
    ADD CONSTRAINT value_set_entries_value_set_oid_fkey FOREIGN KEY (value_set_oid) REFERENCES value_sets(value_set_oid);


--
-- PostgreSQL database dump complete
--

