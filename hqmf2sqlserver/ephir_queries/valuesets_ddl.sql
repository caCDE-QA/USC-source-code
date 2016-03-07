-- ************************
-- PostgreSQL database dump
-- NOT PORTED TO SQL SERVER
-- is part of hqmf setup

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

CREATE VIEW valuesets.code_lists AS
 SELECT hqmf_code_lists.code,
    hqmf_code_lists.code_list_id
   FROM valuesets.hqmf_code_lists
UNION
 SELECT omop_level_2_concept_code_lists.code,
    omop_level_2_concept_code_lists.code_list_id
   FROM valuesets.omop_level_2_concept_code_lists;


--
-- Name: individual_code_map; Type: VIEW; Schema: valuesets; Owner: -
--

CREATE VIEW valuesets.individual_code_map 
AS
 SELECT '2.16.840.1.113883.6.1' AS code_system_oid,
    'LOINC' AS code_system,
    concept.concept_code AS data_code,
    concept.concept_code AS measure_code,
    concept.concept_id AS code
   FROM vocabulary_plus.concept concept
  WHERE concept.vocabulary_id = 6
UNION
 SELECT '2.16.840.1.113762.1.4.1' AS code_system_oid,
    'Administrative Sex' AS code_system,
    concept.concept_code AS data_code,
    concept.concept_code AS measure_code,
    concept.concept_id AS code
   FROM vocabulary_plus.concept
  WHERE concept.vocabulary_id = 12
UNION
 SELECT '2.16.840.1.113883.6.96' AS code_system_oid,
    'SNOMED-CT' AS code_system,
    concept.concept_code AS data_code,
    concept.concept_code AS measure_code,
    concept.concept_id AS code
   FROM vocabulary_plus.concept
  WHERE concept.vocabulary_id = 1;


--
-- PostgreSQL database dump complete
--

