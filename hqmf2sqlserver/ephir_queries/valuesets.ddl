-- ************************
-- PostgreSQL database dump
-- NOT PORTED TO SQL SERVER

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = valuesets, pg_catalog;

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
-- Name: individual_code_map; Type: VIEW; Schema: valuesets; Owner: -
--

CREATE VIEW individual_code_map AS
 SELECT '2.16.840.1.113883.6.1'::text AS code_system_oid,
    'LOINC'::text AS code_system,
    concept.concept_code AS data_code,
    concept.concept_code AS measure_code,
    concept.concept_id AS code
   FROM vocabulary_plus.concept
  WHERE (concept.vocabulary_id = 6)
UNION
 SELECT '2.16.840.1.113762.1.4.1'::text AS code_system_oid,
    'Administrative Sex'::text AS code_system,
    concept.concept_code AS data_code,
    concept.concept_code AS measure_code,
    concept.concept_id AS code
   FROM vocabulary_plus.concept
  WHERE (concept.vocabulary_id = 12)
UNION
 SELECT '2.16.840.1.113883.6.96'::text AS code_system_oid,
    'SNOMED-CT'::text AS code_system,
    concept.concept_code AS data_code,
    concept.concept_code AS measure_code,
    concept.concept_id AS code
   FROM vocabulary_plus.concept
  WHERE (concept.vocabulary_id = 1);


--
-- PostgreSQL database dump complete
--

