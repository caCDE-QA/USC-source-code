set search_path = ex_results;

create table test_ex_results (
   test_time timestamp default now(),
   measure_name text,
   test_name text,
   passed boolean
);

create or replace function populate_test_ex() returns text as $$
DECLARE
   summary_table_name text;
   answer_key_name text;
   query text;
   q text;	
BEGIN
   truncate table test_ex_results;
   for summary_table_name in
       select distinct table_name from information_schema.tables p1 where table_schema = current_schema() and table_name like 'measure%patient_summary'
        and exists (select 1 from information_schema.tables p2 where p2.table_schema = 'answer_key' and p2.table_name = p1.table_name)
       loop
          query = 'insert into test_ex_results(measure_name, test_name, passed) select ''' ||
	     summary_table_name || ''', ''all_expected_found'', ' ||
	     ' not exists (select 1 from answer_key.' || summary_table_name || ' a where not exists ' ||
	       '(select 1 from ' || summary_table_name || ' me where me.patient_id = a.patient_id))';
	  execute query;
          query = 'insert into test_ex_results(measure_name, test_name, passed) select ''' ||
	     summary_table_name || ''', ''no_unexpected_found'', ' ||
	    ' not exists (select 1 from ' || summary_table_name || ' me where not exists ' ||
	       '(select 1 from answer_key.' || summary_table_name || ' a where a.patient_id = me.patient_id))';
	  execute query;
          query = 'insert into test_ex_results(measure_name, test_name, passed) select ''' ||
	     summary_table_name || ''', ''agrees_modulo_exceptions'', ' ||	  
	     ' not exists (select 1 from answer_key.' || summary_table_name || ' a where not exists ' ||
	     ' (select 1 from ' || summary_table_name || ' me where
	         me.patient_id = a.patient_id and
                 me.effective_ipp is not distinct from a.effective_ipp and
                 me.effective_denom is not distinct from a.effective_denom and
                 (a.effective_denex or (me.effective_numer is not distinct from a.effective_numer))))';
	  execute query;
       end loop;
	return null;
END
$$
language 'plpgsql';
	     
	     

create or replace view patients_match_modulo_ex as
   select distinct x.measure_name,
     not exists (select 1 from test_ex_results y where y.measure_name = x.measure_name and y.passed = false) patients_match
   from test_ex_results x;
