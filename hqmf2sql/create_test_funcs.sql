set search_path = results;

create table test_results (
   test_time timestamp default now(),
   measure_name text,
   test_name text,
   passed boolean
);

create table measure_totals (
   test_time timestamp default now(),
   measure_name text,
   total_ipp integer,
   total_denom integer,
   total_denex integer,   
   total_numer integer,
   total_denexcep integer
);

create or replace function populate_test_summary() returns text as $$
DECLARE
   summary_table_name text;
   answer_key_name text;
   query text;
   q text;	
BEGIN
   truncate table measure_totals;
   truncate table test_results;
   for summary_table_name in
       select distinct table_name from information_schema.tables p1 where table_schema = current_schema() and table_name like 'measure%patient_summary'
        and exists (select 1 from information_schema.tables p2 where p2.table_schema = 'answer_key' and p2.table_name = p1.table_name)
       loop
          query = 'insert into test_results(measure_name, test_name, passed) select ''' ||
	     summary_table_name || ''', ''all_expected_found'', ' ||
	     ' not exists (select 1 from answer_key.' || summary_table_name || ' a where not exists ' ||
	       '(select 1 from ' || summary_table_name || ' me where me.patient_id = a.patient_id))';
	  execute query;
          query = 'insert into test_results(measure_name, test_name, passed) select ''' ||
	     summary_table_name || ''', ''no_unexpected_found'', ' ||
	    ' not exists (select 1 from ' || summary_table_name || ' me where not exists ' ||
	       '(select 1 from answer_key.' || summary_table_name || ' a where a.patient_id = me.patient_id))';
	  execute query;
          query = 'insert into test_results(measure_name, test_name, passed) select ''' ||
	     summary_table_name || ''', ''agrees_with_expected'', ' ||	  
	     ' not exists (select 1 from answer_key.' || summary_table_name || ' a where not exists ' ||
	     ' (select 1 from ' || summary_table_name || ' me where
	         me.patient_id = a.patient_id and
                 me.effective_ipp is not distinct from a.effective_ipp and
                 me.effective_denom is not distinct from a.effective_denom and
                 (me.effective_denex is not distinct from a.effective_denex or me.effective_denex is null and a.effective_denex is false) and
                 me.effective_numer is not distinct from a.effective_numer and
                 (me.effective_denexcep is not distinct from a.effective_denexcep or me.effective_denexcep is null and a.effective_denexcep is false)))';
	  execute query;
       end loop;
   for summary_table_name in
       select distinct measure_name from hqmf_analysis.consort c join information_schema.tables t on t.table_name = c.measure_name and t.table_schema = current_schema()
       loop
	  query = 'insert into measure_totals (measure_name, total_ipp, total_denom, total_numer, total_denex, total_denexcep) select ''' || summary_table_name || ''', sum(effective_ipp::integer), sum(effective_denom::integer), sum(effective_numer::integer), sum(effective_denex::integer), sum(effective_denexcep::integer) from ' || summary_table_name;
	  execute query;
       end loop;

       insert into test_results(measure_name, test_name, passed)
          select me.measure_name, 'totals_match',
            exists (select 1 from answer_key.totals_key a where me.measure_name = a.measure_name and
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
   select distinct x.measure_name,
     not exists (select 1 from test_results y where y.measure_name = x.measure_name and y.test_name != 'totals_match' and y.passed = false) patients_match
   from test_results x;
