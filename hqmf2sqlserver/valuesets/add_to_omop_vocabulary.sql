:r "C:\Ephir\hqmf2sql\valuesets\defaults.sql"

--set search_path = :valueset_schema, :vocab_schema;

EXEC('Create FUNCTION '+@valueset_schema+'.greatest
    (
      @val1 INT =0,
      @val2 INT=0 --,
 --     @val3 INT =0
	  )
      
     RETURNS INT  WITH SCHEMABINDING
AS  
   BEGIN
        DECLARE  @MAX AS INT ;
        SET @MAX=0
        IF isnull(@val1,0)> isnull(@MAX,0) SET @MAX=isnull(@val1,0) 
        IF isnull(@val2,0)> isnull(@MAX,0) SET @MAX=isnull(@val2,0) 
--        IF isnull(@val3,0)> isnull(@MAX,0) SET @MAX=isnull(@val3,0)

        RETURN @MAX ;
    END;');

--select setval ('concept_extras_sequence',
--  greatest(last_value, :hqmf_concept_id_start_value, (select max(concept_id) from concept_extras))) from concept_extras_sequence;
--alter sequence concept_extras_sequence restart with :hqmf_concept_id_start_value;
EXEC('DBCC CHECKIDENT (''concept_extras'', RESEED, '+@valueset_schema+'.greatest('+@hqmf_concept_id_start_value+', IDENT_CURRENT(''concept_extras'')));');

--EXEC('SET IDENTITY_INSERT '+@vocab_schema+'.vocabulary_extras  ON;');

EXEC('SET IDENTITY_INSERT '+@vocab_schema+'.vocabulary_extras  ON;
insert into '+@vocab_schema+'.vocabulary_extras(vocabulary_id, vocabulary_name) 
select '+@hqmf_value_set_vocabulary_id+', '+@hqmf_value_set_vocabulary_name+'
  where not exists (select 1 from '+@vocab_schema+'.vocabulary_extras where vocabulary_name = '+@hqmf_value_set_vocabulary_name+');
insert into '+@vocab_schema+'.vocabulary_extras(vocabulary_id, vocabulary_name)
  select '+@hqmf_miscellaneous_vocabulary_id+', '+@hqmf_miscellaneous_vocabulary_name+'
    where not exists (select 1 from '+@vocab_schema+'.vocabulary_extras where vocabulary_name = '+@hqmf_miscellaneous_vocabulary_name+');
SET IDENTITY_INSERT '+@vocab_schema+'.vocabulary_extras  OFF;');


EXEC('create table '+@valueset_schema+'.overflow_vocabulary_map (
   overflow_vocabulary_name varchar(5000) primary key,
   hqmf_code_system_oid varchar(5000) not null unique,
   hqmf_code_system_name varchar(5000) not null,
--   hqmf_code_system_versions text[]
);');

EXEC('create table '+@valueset_schema+'.overflow_voc_map_supl (
   overflow_vocabulary_name varchar(5000) ,
   hqmf_code_system_versions varchar(5000)
);');



--comment on table overflow_vocabulary_map is 'Some codes that appear in value sets do not have corresponding OMOP concept IDs. This table defines vocabularies to use when creating new concept IDs for those codes.';
--comment on column overflow_vocabulary_map.overflow_vocabulary_name is 'Name of overflow vocabulary';
--comment on column overflow_vocabulary_map.hqmf_code_system_oid is 'Vocabulary OID (corresponds to value_set_entries.code_system)';
--comment on column overflow_vocabulary_map.hqmf_code_system_name is 'Vocabulary name (from HQMF, for display only)';
--comment on column overflow_vocabulary_map.hqmf_code_system_versions is 'Vocabulary versions (from HQMF)';

EXEC('create sequence '+@valueset_schema+'.overflow_vocabulary_sequence minvalue 1;');

EXEC('insert into '+@valueset_schema+'.overflow_vocabulary_map(overflow_vocabulary_name, hqmf_code_system_oid, hqmf_code_system_name)
--, hqmf_code_system_versions)
   select ''hqmf_overflow_'' + hqmf_code_system_name + ''_'' + 
   coalesce(STUFF(
   (SELECT '','' + coalesce(s.hqmf_code_system_version, ''0'')
		FROM '+@valueset_schema+'.vocabulary_map s
		WHERE s.hqmf_code_system_oid = v.hqmf_code_system_oid and s.hqmf_code_system_name = v.hqmf_code_system_name
		FOR XML PATH('''')),1,1,''''), ''0'')
    + ''_'' + cast(NEXT VALUE FOR valuesets.overflow_vocabulary_sequence as varchar),
     hqmf_code_system_oid, hqmf_code_system_name
   from '+@valueset_schema+'.vocabulary_map v
     where not exists
      (select 1 from '+@valueset_schema+'.overflow_vocabulary_map o where o.hqmf_code_system_oid = v.hqmf_code_system_oid)
   group by v.hqmf_code_system_oid, v.hqmf_code_system_name;');

EXEC('insert into '+@valueset_schema+'.overflow_voc_map_supl(overflow_vocabulary_name, hqmf_code_system_versions)
   select o.overflow_vocabulary_name, v.hqmf_code_system_version
   from '+@valueset_schema+'.overflow_vocabulary_map o
   join '+@valueset_schema+'.vocabulary_map v 
		on o.hqmf_code_system_oid = v.hqmf_code_system_oid and o.hqmf_code_system_name = v.hqmf_code_system_name
		;');

--- The folowing 2 views (unified_vocabulary_map and arrayed_vocabulary_map) 
--- use PostgresSQL array functionality not available in MS SQL Server.
--- The respectfive columns or views will not be created in MS SQL version of the code. 
--- Views/columns definitions are commented out.
EXEC('create view '+@valueset_schema+'.unified_vocabulary_map as
   select m.hqmf_code_system_oid,
          m.hqmf_code_system_name,
--          array_agg(distinct(m.hqmf_code_system_version)) hqmf_code_system_versions,
          m.omop_vocabulary_id,
	  v.vocabulary_name,
          0 is_overflow_vocabulary
  from '+@valueset_schema+'.vocabulary_map m left join '+@vocab_schema+'.vocabulary v on v.vocabulary_id = m.omop_vocabulary_id 
   where m.omop_vocabulary_id is not null
   group by m.hqmf_code_system_oid, m.hqmf_code_system_name, m.omop_vocabulary_id, v.vocabulary_name
   union
   select o.hqmf_code_system_oid,
          o.hqmf_code_system_name,
--          o.hqmf_code_system_versions,
          v.vocabulary_id,
	      v.vocabulary_name,
          1 is_overflow_vocabulary
   from '+@valueset_schema+'.overflow_vocabulary_map o left join '+@vocab_schema+'.vocabulary v on v.vocabulary_name = o.overflow_vocabulary_name;');

--create or replace view arrayed_vocabulary_map as
--   select u.hqmf_code_system_oid,
--	  v.vocabulary_id overflow_vocabulary_id,
--          array_agg(u.omop_vocabulary_id) vocabulary_ids
--   from unified_vocabulary_map u
--        left join overflow_vocabulary_map o on o.hqmf_code_system_oid = u.hqmf_code_system_oid
--        left join vocabulary v on v.vocabulary_name = o.overflow_vocabulary_name
--   group by u.hqmf_code_system_oid, v.vocabulary_id;

EXEC('insert into '+@vocab_schema+'.vocabulary_extras(vocabulary_name)
   select distinct overflow_vocabulary_name
   from '+@valueset_schema+'.overflow_vocabulary_map o
   where not exists (select 1 from '+@vocab_schema+'.vocabulary_extras v where v.vocabulary_name = o.overflow_vocabulary_name);');


-- Create OMOP concept ids for HQMF value sets
EXEC('insert into '+@vocab_schema+'.concept_extras(concept_name, concept_level, concept_class, vocabulary_id, concept_code, valid_start_date)
   select 
     v.value_set_name,
     '+@hqmf_value_set_concept_level+',
     '+@hqmf_value_set_concept_class+',
     '+@hqmf_value_set_vocabulary_id+',
     v.value_set_oid,
     cast('+@hqmf_value_set_default_start_date+' as date)
   from '+@valueset_schema+'.value_sets v
   where not exists (select 1 from '+@vocab_schema+'.concept_extras c where c.concept_code = v.value_set_oid)
   group by v.value_set_name, v.value_set_oid;');

-- Create OMOP concept ids for missing codes used by HQMF value sets
-- (don't use source_to_concept)
-- !!!INSERT uses arrayed_vocabulary_map - comment out
--EXEC('insert into '+@valueset_schema+'.concept_extras(concept_name, concept_level, concept_class, vocabulary_id, concept_code, valid_start_date)
--  select distinct e.display_name,
--    '+@hqmf_overflow_concept_level+',
--    '+@hqmf_overflow_concept_class+',
--    m.overflow_vocabulary_id,
--   e.code,
--    cast('+@hqmf_value_set_default_start_date+' as date)
--   from '+@valueset_schema+'.value_set_entries e join arrayed_vocabulary_map m 
--    on e.code_system = m.hqmf_code_system_oid
--   where not exists
--     (select 1 from '+@vocab_schema+'.concept c where
--       c.vocabulary_id = any(m.vocabulary_ids) and c.concept_code = e.code);');

-- Create OMOP concept ids for missing codes used by HQMF value sets
-- (use source_to_concept)
-- insert into concept_extras(concept_name, concept_level, concept_class, vocabulary_id, concept_code, valid_start_date)
--   select distinct e.display_name,
--     :hqmf_overflow_concept_level,
--     :hqmf_overflow_concept_class,
--     m.overflow_vocabulary_id,
--     e.code,
--     cast(:hqmf_value_set_default_start_date as date)
--   from value_set_entries e join arrayed_vocabulary_map m 
--     on e.code_system = m.hqmf_code_system_oid
--   where not exists
--     (select 1 from concept c where
--       c.vocabulary_id = any(m.vocabulary_ids) and c.concept_code = e.code)
--   and not exists
--     (select 1 from source_to_concept_map s where
--      s.source_vocabulary_id = any(m.vocabulary_ids)
--      and s.primary_map = 'Y'
--      and s.source_code = e.code and s.target_concept_id != 0);

-- Create a concept code to use for unmapped lab text results

-- insert into concept_extras(concept_name, concept_level, concept_class, vocabulary_id, concept_code, valid_start_date)
--   select
--    :lab_observation_unmapped_text_name,
--    0,
--    'Qualifier value',
--    :hqmf_miscellaneous_vocabulary_id,
--    :lab_observation_unmapped_text_name,
--    :hqmf_value_set_default_start_date
--   where not exists (select 1 from concept
--        where vocabulary_id = :hqmf_miscellaneous_vocabulary_id
--       and concept_code = :lab_observation_unmapped_text_name);

--cluster concept_extras;
--analyze concept_extras;

EXEC('SET IDENTITY_INSERT '+@vocab_schema+'.relationship_extras ON;
-- Create OMOP relationship for hqmf "in value set" relationship
insert into '+@vocab_schema+'.relationship_extras(relationship_id, relationship_name, is_hierarchical, defines_ancestry)
  select '+@value_set_member_relationship_id+', '+@value_set_member_relationship_name+', 0, 0
  where not exists 
  (select 1 from '+@vocab_schema+'.relationship_extras where relationship_name = '+@value_set_member_relationship_name+');
insert into '+@vocab_schema+'.relationship_extras(relationship_id, relationship_name, is_hierarchical, defines_ancestry)
  select '+@value_set_member_relationship_id_mapped+', '+@value_set_member_relationship_name_mapped+', 0, 0
  where not exists 
  (select 1 from '+@vocab_schema+'.relationship_extras where relationship_name = '+@value_set_member_relationship_name_mapped+');
  SET IDENTITY_INSERT '+@vocab_schema+'.relationship_extras OFF;');

-- The following INSERT uses arrayed_vocabulary_map view which was not implemented in SQL Server version of the ccode (see above). 
-- The INSERT statement is commented out.
-- Create OMOP concept-relationship entries defining which codes are in which value sets
-- Start with concepts directly mapped
--EXEC('insert into '+@valueset_schema+'.concept_relationship_extras (
--   concept_id_1,
--   concept_id_2,
--   relationship_id,
--   valid_start_date)
-- select distinct
--   c_val.concept_id,
--   c_set.concept_id,
--   @value_set_member_relationship_id,
--   cast(hqmf_relationship_default_start_date as date)
-- from '+@valueset_schema+'.value_set_entries v 
--      join '+@valueset_schema+'.arrayed_vocabulary_map m on
--         v.code_system = m.hqmf_code_system_oid 
--!!!!rewrite ANY
--      join '+@vocab_schema+'.concept c_val on c_val.vocabulary_id = any(m.vocabulary_ids) and c_val.concept_code = v.code
--      join '+@vocab_schema+'.concept c_set on c_set.vocabulary_id = @hqmf_value_set_vocabulary_id and c_set.concept_code = v.value_set_oid
-- where not exists
--    (select 1 from '+@valueset_schema+'.concept_relationship_extras r
--     where r.concept_id_1 = c_val.concept_id and r.concept_id_2 = c_set.concept_id
--       and r.relationship_id in (@value_set_member_relationship_id, @value_set_member_relationship_id_mapped));');


-- Add values from source-to-concept map
-- Don't insist on primary_map = 'Y' here; accept older mappings
-- insert into concept_relationship_extras (
--    concept_id_1,
--    concept_id_2,
--    relationship_id,
--    valid_start_date)
--  select distinct
--    c_val.target_concept_id,
--    c_set.concept_id,
--    :value_set_member_relationship_id_mapped,
--    cast(:hqmf_relationship_default_start_date as date)
--  from value_set_entries v 
--       join arrayed_vocabulary_map m on
--          v.code_system = m.hqmf_code_system_oid
--       join source_to_concept_map c_val on 
--          c_val.source_vocabulary_id = any(m.vocabulary_ids) and 
--          c_val.source_code = v.code and c_val.invalid_reason is null and 
--          c_val.target_concept_id != 0 and
--          c_val.valid_start_date < now() and c_val.valid_end_date > now()
--       join concept c_set on c_set.vocabulary_id = :hqmf_value_set_vocabulary_id and c_set.concept_code = v.value_set_oid
--  where not exists
--     (select 1 from concept_relationship_extras r
--      where r.concept_id_1 = c_val.target_concept_id and r.concept_id_2 = c_set.concept_id
--        and r.relationship_id in (:value_set_member_relationship_id, :value_set_member_relationship_id_mapped));


--cluster concept_relationship_extras;
--analyze concept_relationship_extras;

