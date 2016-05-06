set search_path = results;

create table test_results (
   test_time timestamp default now(),
   test_name text,
   passed boolean
);

create or replace function populate_test_summary() returns text as $$
DECLARE
   summary_table_name text;
   answer_key_name text;
   query text;
BEGIN
   for summary_table_name in
       select distinct tablename from pg_tables p1 where schemaname = current_schema() and tablename like 'measure%patient_summary'
        and exists (select 1 from pg_tables p2 where p2.schemaname = 'answer_key' and p2.tablename = p1.tablename)
       loop
          query = 'insert into test_results(test_name, passed) select
	     ''' || summary_table_name || '_all_expected_found'', ' ||
	     ' not exists (select 1 from answer_key.' || summary_table_name || ' a where not exists ' ||
	       '(select 1 from ' || summary_table_name || ' me where me.patient_id = a.patient_id))';
	  execute query;
          query = 'insert into test_results(test_name, passed) select
	     ''' || summary_table_name || '_no_unexpected_found'', ' ||
	    ' not exists (select 1 from ' || summary_table_name || ' me where not exists ' ||
	       '(select 1 from answer_key.' || summary_table_name || ' a where a.patient_id = me.patient_id))';
	  execute query;
          query = 'insert into test_results(test_name, passed) select
	     ''' || summary_table_name || '_agrees_with_expected'', ' ||
	     ' not exists (select 1 from answer_key.' || summary_table_name || ' a where not exists ' ||
	     ' (select 1 from ' || summary_table_name || ' me where
	         me.patient_id = a.patient_id and
                 me.effective_ipp is not distinct from a.effective_ipp and
                 me.effective_denom is not distinct from a.effective_denom and
                 me.effective_denex is not distinct from a.effective_denex and
                 me.effective_numer is not distinct from a.effective_numer and
                 me.effective_denexcep is not distinct from a.effective_denexcep))';
	  execute query;


       end loop;
       return null;
END
$$
language 'plpgsql';
	     
	     

