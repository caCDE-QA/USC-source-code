USE [TCC]
GO

/****** Object:  View [hqmf_test].[individual_characteristic]    Script Date: 2/21/2016 10:04:45 AM ******/
DROP VIEW [hqmf_test].[individual_characteristic]
GO

/****** Object:  View [hqmf_test].[individual_characteristic]    Script Date: 2/21/2016 10:04:45 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [hqmf_test].[individual_characteristic] 
--WITH SCHEMABINDING
	as select
   person_id as patient_id,
--   ydm_to_date(year_of_birth, month_of_birth, day_of_birth) as start_dt,
   convert(date, 
   right('0'+cast(coalesce(day_of_birth, '01') as varchar), 2)+'/'+right('0'+cast(coalesce(month_of_birth, '01') as varchar),2)+'/'
   +cast(coalesce(year_of_birth, 1990) as varchar), 103) 
   as start_dt,
   cast(NULL as datetime) as end_dt,
   3022007 as code,
   cast(NULL as varchar(max)) as status,
   cast(NULL as int) as negation,
   cast(NULL as varchar(max)) as value,
   'person' as audit_key_type,
   person_id as audit_key_value
from omop_test.person
union select
   p.person_id as patient_id,
--   ydm_to_date(p.year_of_birth, p.month_of_birth, p.day_of_birth)::timestamp as start_dt,
   convert(date, 
   right('0'+cast(coalesce(day_of_birth, '01') as varchar), 2)+'/'+right('0'+cast(coalesce(month_of_birth, '01') as varchar), 2)+'/'
   +cast(coalesce(year_of_birth, 1990) as varchar), 103) 
   as start_dt,
   cast(NULL as datetime) as end_dt,
   p.gender_concept_id as code,
   cast(NULL as varchar(max)) as status,
   cast(NULL as int) as negation,
   c.concept_code as value,
   'person'as audit_key_type,
   person_id as audit_key_value
from omop_test.person p join vocabulary_plus.concept c on c.concept_id = p.gender_concept_id
union select
   person_id as patient_id,
   death_date as start_dt,
   cast(NULL as datetime) as end_dt,
   death_type_concept_id as code,
   cast(NULL as varchar(max)) as status,
   cast(NULL as int) as  negation,
   cast(NULL as varchar(max)) as value,
   'death' as audit_key_type,
   person_id as audit_key_value
from omop_test.death
union select distinct
   person_id as patient_id,
   condition_start_date as start_dt,
   cast(NULL as datetime) as end_dt,
   c.condition_concept_id as code,
   'active' as status,
   cast(NULL as int) as negation,
   cast(NULL as varchar(max)) as value,
   'condition_occurrence' as audit_key_type,
   condition_occurrence_id as audit_key_value
from omop_test.condition_occurrence c join valuesets.code_lists l on l.code = c.condition_concept_id
join valuesets.value_sets vs on vs.value_set_oid = l.code_list_id
where lower(vs.value_set_name) like '%tobacco%' or lower(vs.value_set_name) like '%smok%';
GO


