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
-- Name: valuesets; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA export_valuesets;


SET search_path = export_valuesets;

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


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: hl7_template_xref; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE hl7_template_xref as select * from valuesets.hl7_template_xref;


--
-- Name: overflow_vocabulary_map; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE overflow_vocabulary_map as select * from valuesets.overflow_vocabulary_map;


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
-- Name: vocabulary_map; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE vocabulary_map as select * from valuesets.vocabulary_map;


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
-- Name: unified_vocabulary_map; Type: VIEW; Schema: valuesets; Owner: -
--

CREATE table unified_vocabulary_map AS select * from valuesets.unified_vocabulary_map;

--
-- Name: arrayed_vocabulary_map; Type: VIEW; Schema: valuesets; Owner: -
--

CREATE table arrayed_vocabulary_map AS select * from valuesets.arrayed_vocabulary_map;


--
-- Name: hqmf_code_lists; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE hqmf_code_lists as select * from valuesets.hqmf_code_lists;


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

CREATE TABLE omop_level_2_concept_code_lists as select * from valuesets.omop_level_2_concept_code_lists;


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

CREATE TABLE code_lists_value_set_reverse_map as select * from valuesets.code_lists_value_set_reverse_map;


--
-- Name: med_status_map; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE med_status_map as select * from valuesets.med_status_map;


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
-- Name: value_set_entries; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE value_set_entries as select * from valuesets.value_set_entries;

--
-- Name: TABLE value_set_entries; Type: COMMENT; Schema: valuesets; Owner: -
--

COMMENT ON TABLE value_set_entries IS 'Value set entries (from standard value set definitions)';


--
-- Name: unique_code_systems; Type: VIEW; Schema: valuesets; Owner: -
--

CREATE table unique_code_systems AS select * from valuesets.unique_code_systems;


--
-- Name: value_code_xref; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE value_code_xref as select * from valuesets.value_code_xref;

--
-- Name: value_set_code_systems; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE value_set_code_systems as select * from valuesets.value_set_code_systems;


--
-- Name: value_set_code_xref; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE value_set_code_xref as select * from valuesets.value_set_code_xref;


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

CREATE TABLE value_set_sanity_checks as select * from valuesets.value_set_sanity_checks;

--
-- Name: value_sets; Type: TABLE; Schema: valuesets; Owner: -; Tablespace: 
--

CREATE TABLE value_sets as select * from valuesets.value_sets;


--
-- Name: TABLE value_sets; Type: COMMENT; Schema: valuesets; Owner: -
--

COMMENT ON TABLE value_sets IS 'Value set names (from standard value set definitions)';


--
-- Name: value_set_entry_id; Type: DEFAULT; Schema: valuesets; Owner: -
--

ALTER TABLE ONLY value_set_entries ALTER COLUMN value_set_entry_id SET DEFAULT nextval('value_set_entries_value_set_entry_id_seq'::regclass);


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
-- PostgreSQL database dump complete
--

