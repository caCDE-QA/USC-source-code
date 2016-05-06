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
BEGIN
   truncate table measure_totals;
   truncate table test_results;
   for summary_table_name in
       select distinct tablename from pg_tables p1 where schemaname = current_schema() and tablename like 'measure%patient_summary'
        and exists (select 1 from pg_tables p2 where p2.schemaname = 'answer_key' and p2.tablename = p1.tablename)
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
                 me.effective_denex is not distinct from a.effective_denex and
                 me.effective_numer is not distinct from a.effective_numer and
                 me.effective_denexcep is not distinct from a.effective_denexcep))';
	  execute query;
	  query = 'insert into measure_totals (measure_name, total_ipp, total_denom, total_numer, total_denex, total_denexcep) select ''' || summary_table_name || ''', sum(effective_ipp::integer), sum(effective_denom::integer), sum(effective_numer::integer), sum(effective_denex::integer), sum(effective_denexcep::integer) from ' || summary_table_name;
	  execute query;
	  query = 'insert into test_results(measure_name, test_name, passed) select ''' ||
	     summary_table_name || ''', ''totals_match'', ' ||
	    ' exists (select 1 from measure_totals me join answer_key.measure_totals a
	    on a.measure_name = me.measure_name where
	    a.measure_name = ''' || summary_table_name || ''' and
	    a.total_ipp is not distinct from me.total_ipp and
	    a.total_denom is not distinct from me.total_denom and
	    a.total_denex is not distinct from me.total_denex and
 	    a.total_numer is not distinct from me.total_numer and
	    a.total_denexcep is not distinct from me.total_denexcep)';
	  execute query;
       end loop;
       return null;
END
$$
language 'plpgsql';
	     
	     

