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
          query = 'insert into test_results(test_name, passed) select distinct
	     ''' || summary_table_name || ''', 
	     not exists (select 1 from answer_key.' || summary_table_name || ' expected
               where me.patient_id = expected.patient_id and (me.effective_ipp is distinct from expected.effective_ipp or
                 me.effective_denom is distinct from expected.effective_denom or
                 me.effective_denex is distinct from expected.effective_denex or
                 me.effective_numer is distinct from expected.effective_numer or
                 me.effective_denexcep is distinct from expected.effective_denexcep))
             from ' || summary_table_name || ' me ';
	  execute query;
       end loop;
       return null;
END
$$
language 'plpgsql';
	     
	     

