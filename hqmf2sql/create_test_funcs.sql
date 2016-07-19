set search_path = results;

create table test_results (
   test_time timestamp default now(),
   measure text,
   population integer,
   result_table_name text,
   test_name text,
   passed boolean
);

create table measure_totals (
   test_time timestamp default now(),
   measure text,
   population integer,
   result_table_name text, 
   total_ipp integer,
   total_denom integer,
   total_denex integer,   
   total_numer integer,
   total_denexcep integer
);

create or replace function populate_test_summary() returns text as $$
DECLARE
   result_table_name text;
   answer_table_name text;
   measure text;
   query text;
   q text;
   population integer;
   tables_exist boolean;
BEGIN
   truncate table measure_totals;
   truncate table test_results;
   for result_table_name in
       select distinct table_name from information_schema.tables p1 where table_schema = current_schema() and table_name like 'measure%patient_summary'
       loop
          select c.measure, regexp_replace(x.table_name, '_event_summary', '_patient_summary'), x.pop
	  from hqmf_analysis.consort c
	  join answer_key.measure_pop_xref x on x.measure = c.measure and x.pop = c.population
	  where c.table_name = result_table_name
	  into measure,
	  answer_table_name, population;

	  select exists (select 1 from information_schema.tables where table_schema = 'answer_key' and table_name = answer_table_name) into tables_exist;

          if tables_exist then
          query = 'insert into test_results(measure, population, result_table_name, test_name, passed) select ''' ||
	     measure || ''', ' || population || ', ''' || result_table_name || ''', ''all_expected_found'', ' ||
	     ' not exists (select 1 from answer_key.' || answer_table_name || ' a where not exists ' ||
	       '(select 1 from ' || result_table_name || ' me where me.patient_id = a.patient_id))';
	  execute query;
          query = 'insert into test_results(measure, population, result_table_name, test_name, passed) select ''' ||
	     measure || ''', ' || population || ', ''' || result_table_name || ''', ''no_unexpected_found'', ' ||
	    ' not exists (select 1 from ' || result_table_name || ' me where not exists ' ||
	       '(select 1 from answer_key.' || answer_table_name || ' a where a.patient_id = me.patient_id))';
	  execute query;
          query = 'insert into test_results(measure, population, result_table_name, test_name, passed) select ''' ||
	     measure || ''', ' || population || ', ''' || result_table_name || ''', ''agrees_with_expected'', ' ||
	     ' not exists (select 1 from answer_key.' || answer_table_name || ' a where not exists ' ||
	     ' (select 1 from ' || result_table_name || ' me where
	         me.patient_id = a.patient_id and
                 me.effective_ipp is not distinct from a.effective_ipp and
                 me.effective_denom is not distinct from a.effective_denom and
                 (me.effective_denex is not distinct from a.effective_denex or me.effective_denex is null and a.effective_denex is false) and
                 me.effective_numer is not distinct from a.effective_numer and
                 (me.effective_denexcep is not distinct from a.effective_denexcep or me.effective_denexcep is null and a.effective_denexcep is false)))';
	  execute query;
	  end if;
       end loop;
   for result_table_name in
       select distinct c.table_name from hqmf_analysis.consort c join information_schema.tables t on t.table_name = c.table_name and t.table_schema = current_schema()
       loop
   	  query = 'insert into measure_totals (measure, population, result_table_name, total_ipp, total_denom, total_numer, total_denex, total_denexcep) select ''' || measure || ''', ' || population || ', ''' || result_table_name || ''', sum(effective_ipp::integer), sum(effective_denom::integer), sum(effective_numer::integer), sum(effective_denex::integer), sum(effective_denexcep::integer) from ' || result_table_name;
   	  execute query;
       end loop;

       insert into test_results(measure, population, result_table_name, test_name, passed)
          select me.measure, me.population, me.result_table_name, 'totals_match',
            exists (select 1 from answer_key.totals_key a where me.measure = a.measure and me.population = a.population and
   	       a.total_ipp is not distinct from me.total_ipp and
   	       ((a.total_denom is not distinct from me.total_denom) or (a.total_denom = 0 and me.total_denom is null)) and
   	       ((a.total_denex is not distinct from me.total_denex) or (a.total_denex = 0 and me.total_denex is null)) and
   	       ((a.total_numer is not distinct from me.total_numer) or (a.total_numer = 0 and me.total_numer is null)) and
   	       ((a.total_denexcep is not distinct from me.total_denexcep) or (a.total_denexcep = 0 and me.total_denexcep is null)))
            from measure_totals me where me.total_ipp is not null;
   	return null;
END
$$
language 'plpgsql';
	     
	     

create or replace view patients_match as
   select distinct x.measure, x.population, x.result_table_name,
     not exists (select 1 from test_results y where y.result_table_name = x.result_table_name and y.test_name != 'totals_match' and y.passed = false) patients_match
   from test_results x;
