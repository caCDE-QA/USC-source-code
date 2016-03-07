-- The name of the schema that has your vanilla OMOP vocabulary tables (vocabulary, concept, etc.):
DECLARE @omop_vocab_schema varchar(60) = 'vocabulary';

-- The name of the schema we will create to include vocabulary additions
DECLARE @vocab_schema varchar(60) = 'vocabulary_plus';

-- The name of the schema that holds your OMOP data tables (person, visit_occurence, etc.):
DECLARE @omop_schema  varchar(60) = 'omop_test';

-- The HQMF database user. This user should have the ability to create new schemas, plus read-only
-- access to your OMOP data and vocabulary tables.
DECLARE @hqmfuser  varchar(60) = 'hqmfuser';

-- The name of the database (used in a "GRANT CREATE ON DATABASE :database TO :hqmfuser")
DECLARE @database  varchar(60) = 'heracles';

-- The name of the schema we will create to hold HQMF value set mappings
DECLARE @valueset_schema  varchar(60) = 'valuesets';

-- The name of the schema that we will create to hold the HQMF version of your data
DECLARE @hqmf_schema  varchar(60) = 'hqmf_test';

-- The name of the schema that will create to hold data in a format halfway between OMOP and HQMF.
DECLARE @omop_hqmf_additions_schema  varchar(60) = 'omop_hqmf_additions_test';

-- We will define custom concepts with concept IDs starting
-- with hqmf_concept_id_start_value. If you define your own
-- custom concept IDs, change this to something high enough
-- that our concept ids will be guaranteed not to conflict
-- with yours.
DECLARE @hqmf_concept_id_start_value  int = 1002000000;

-- You probably shouldn't change anything below this line.

DECLARE @base_vocab_schema varchar(60) = @omop_vocab_schema;
DECLARE @hqmf_value_set_vocabulary_name  varchar(20) = '''hqmf value sets''';
DECLARE @hqmf_value_set_vocabulary_id  int = 40000;
DECLARE @hqmf_value_set_concept_class  varchar(60) = '''value set''';
DECLARE @hqmf_value_set_concept_level  int = 2;
DECLARE @hqmf_value_set_default_start_date  varchar(60) = '''1970-01-01''';
DECLARE @hqmf_relationship_default_start_date  varchar(60) = '''1970-01-01''';
DECLARE @lab_observation_numeric_concept_id  int = 38000277;
DECLARE @lab_observation_text_concept_id  int = 38000278;
DECLARE @lab_observation_concept_code_concept_id  int = 38000279;
DECLARE @lab_observation_recorded_from_ehr_concept_id  int = 38000280;
DECLARE @lab_observation_recorded_from_ehr_with_text_concept_id  int = 38000281;
DECLARE @icd9_overflow_vocabulary_name_1  varchar(60) = '''hqmf_overflow_ICD-9-CM__5''';
DECLARE @icd9_overflow_vocabulary_name_2  varchar(60) = '''hqmf_overflow_ICD-9-CM__6''';
DECLARE @icd9_cm_vocabulary_id  int = 2;
DECLARE @icd9_proc_vocabulary_id  int = 3;
DECLARE @icd9_overflow_vocabulary_1  int = 40101;
DECLARE @icd9_overflow_vocabulary_2  int = 40110;
DECLARE @cpt_vocabulary_id  int = 4;
DECLARE @hcpcs_vocabulary_id  int = 5;
DECLARE @snomed_vocabulary_id  int = 1;
DECLARE @relationship_subsumes  int = 10;
DECLARE @relationship_medra_to_snomed  int = 125;
DECLARE @relationship_indication_to_snomed  int = 247;
DECLARE @lab_observation_unmapped_text_name  varchar(60) = '''Unmapped text result''';
DECLARE @hqmf_miscellaneous_vocabulary_id  int = 40113;
DECLARE @hqmf_miscellaneous_vocabulary_name  varchar(60) = '''HQMF miscellaneous concepts''';
DECLARE @value_set_member_relationship_id  int = 1000;
DECLARE @value_set_member_relationship_name  varchar(60) = '''in value set (HQMF)''';
DECLARE @value_set_member_relationship_id_mapped  int = 1001;
DECLARE @value_set_member_relationship_name_mapped  varchar(60) = '''mapped value in value set (HQMF)''';
DECLARE @hqmf_overflow_concept_level  int = 1;
DECLARE @hqmf_overflow_concept_class  varchar(60) = '''hqmf mapped overflow concept''';
DECLARE @omop_mapping_schema  varchar(60) = @valueset_schema;
