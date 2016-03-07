:r "C:\Ephir\hqmf2sql\omop_etl\defaults.sql"
---

EXEC ('CREATE SCHEMA '+@vocab_schema+';');
--set search_path = @vocab_schema;
--create table vocabulary_extras (like @omop_vocab_schema.vocabulary including all);
--EXEC ('select * into '+@vocab_schema+'.vocabulary_extras from '+@omop_vocab_schema+'.vocabulary where 1=2;');
EXEC('CREATE TABLE '+@vocab_schema+'.vocabulary_extras(
	VOCABULARY_ID int IDENTITY(40000,1) NOT NULL,
	VOCABULARY_NAME varchar(256) NULL
);');
--create view vocabulary as select * from vocabulary_extras union select * from @omop_vocab_schema.vocabulary;
EXEC ('create view '+@vocab_schema+'.vocabulary as select * from '+@vocab_schema+'.vocabulary_extras union select * from '+@omop_vocab_schema+'.vocabulary;');
--create table concept_extras (like @omop_vocab_schema.concept including all);
--EXEC ('select * into '+@vocab_schema+'.concept_extras from '+@omop_vocab_schema+'.concept where 1=2;');
EXEC('CREATE TABLE '+@vocab_schema+'.concept_extras(
	CONCEPT_ID int IDENTITY(1000000001,1) NOT NULL,
	CONCEPT_NAME varchar(256) NULL,
	CONCEPT_LEVEL int NULL,
	CONCEPT_CLASS varchar(60) NULL,
	VOCABULARY_ID int NULL,
	CONCEPT_CODE varchar(40) NULL,
	VALID_START_DATE date NULL,
	VALID_END_DATE date NULL,
	INVALID_REASON varchar(1) NULL,
);');
--create view concept as select * from concept_extras union select * from @omop_vocab_schema.concept;
EXEC ('create view '+@vocab_schema+'.concept as select * from '+@vocab_schema+'.concept_extras union select * from '+@omop_vocab_schema+'.concept;');
--create table concept_ancestor_extras (like @omop_vocab_schema.concept_ancestor including all);
EXEC ('select * into '+@vocab_schema+'.concept_ancestor_extras from '+@omop_vocab_schema+'.concept_ancestor where 1=2;');
--create view concept_ancestor as select * from concept_ancestor_extras union select * from @omop_vocab_schema.concept_ancestor;
EXEC ('create view '+@vocab_schema+'.concept_ancestor as select * from '+@vocab_schema+'.concept_ancestor_extras union select * from '+@omop_vocab_schema+'.concept_ancestor;');
--create table drug_approval_extras (like @omop_vocab_schema.drug_approval including all);
EXEC ('select * into '+@vocab_schema+'.drug_approval_extras from '+@omop_vocab_schema+'.drug_approval where 1=2;');
--create view drug_approval as select * from drug_approval_extras union select * from @omop_vocab_schema.drug_approval;
EXEC ('create view '+@vocab_schema+'.drug_approval as select * from '+@vocab_schema+'.drug_approval_extras union select * from '+@omop_vocab_schema+'.drug_approval;');
--create table drug_strength_extras (like @omop_vocab_schema.drug_strength including all);
EXEC ('select * into '+@vocab_schema+'.drug_strength_extras from '+@omop_vocab_schema+'.drug_strength where 1=2;');
--create view drug_strength as select * from drug_strength_extras union select * from @omop_vocab_schema.drug_strength;
EXEC ('create view '+@vocab_schema+'.drug_strength as select * from '+@vocab_schema+'.drug_strength_extras union select * from '+@omop_vocab_schema+'.drug_strength;');
--create table relationship_extras (like @omop_vocab_schema.relationship including all);
--EXEC ('select * into '+@vocab_schema+'.relationship_extras from '+@omop_vocab_schema+'.relationship where 1=2;');
EXEC('CREATE TABLE '+@vocab_schema+'.relationship_extras(
	RELATIONSHIP_ID int IDENTITY(1000,1) NOT NULL,
	RELATIONSHIP_NAME varchar(256) NULL,
	IS_HIERARCHICAL int NULL,
	DEFINES_ANCESTRY int NULL,
	REVERSE_RELATIONSHIP smallint NULL
);');
--create view relationship as select * from relationship_extras union select * from @omop_vocab_schema.relationship;
EXEC ('create view '+@vocab_schema+'.relationship as select * from '+@vocab_schema+'.relationship_extras union select * from '+@omop_vocab_schema+'.relationship;');
--create table concept_relationship_extras (like @omop_vocab_schema.concept_relationship including all);
EXEC ('select * into '+@vocab_schema+'.concept_relationship_extras from '+@omop_vocab_schema+'.concept_relationship where 1=2;');
--create view concept_relationship as select * from concept_relationship_extras union select * from @omop_vocab_schema.concept_relationship;
EXEC ('create view '+@vocab_schema+'.concept_relationship as select * from '+@vocab_schema+'.concept_relationship_extras union select * from '+@omop_vocab_schema+'.concept_relationship;');
--create table source_to_concept_map_extras (like @omop_vocab_schema.source_to_concept_map including all);
EXEC ('select * into '+@vocab_schema+'.source_to_concept_map_extras from '+@omop_vocab_schema+'.source_to_concept_map where 1=2;');
--create view source_to_concept_map as select * from source_to_concept_map_extras union select * from @omop_vocab_schema.source_to_concept_map;
EXEC ('create view '+@vocab_schema+'.source_to_concept_map as select * from '+@vocab_schema+'.source_to_concept_map_extras union select * from '+@omop_vocab_schema+'.source_to_concept_map;');

--create sequence vocabulary_extras_sequence minvalue 40000;
--alter table vocabulary_extras alter column vocabulary_id set default nextval ('vocabulary_extras_sequence');
--EXEC('alter table '+@vocab_schema+'.vocabulary_extras drop column vocabulary_id;');
--EXEC('alter table '+@vocab_schema+'.vocabulary_extras add vocabulary_id int identity(1,1);');

--create sequence concept_extras_sequence minvalue 1000000001;
--alter table concept_extras alter column concept_id set default nextval ('concept_extras_sequence');
--EXEC('alter table '+@vocab_schema+'.concept_extras drop column concept_id;;');
--EXEC('alter table '+@vocab_schema+'.concept_extras add concept_id int identity(1,1);');

--create sequence relationship_extras_sequence minvalue 1000;
--alter table relationship_extras alter column relationship_id set default nextval ('relationship_extras_sequence');
--EXEC('alter table '+@vocab_schema+'.relationship_extras drop column relationship_id;');
--EXEC('alter table '+@vocab_schema+'.relationship_extras add relationship_id int identity(1000,1);');