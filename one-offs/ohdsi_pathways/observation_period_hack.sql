set search_path = omop_altamed_2015_11_01;

insert into observation_period(person_id,
   observation_period_start_date,
   observation_period_end_date)
   select person_id,
          min(visit_start_date),
	  max(coalesce(visit_end_date, visit_start_date))
   from visit_occurrence
   where visit_start_date <= '2015-11-01'::date
   group by person_id;
