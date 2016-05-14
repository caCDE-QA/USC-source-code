set search_path = hqmf_analysis, results;

update consort set count_matches = null, patients_match = null;

update consort c set count_matches = passed from test_results r
  where r.measure_name = c.measure_name and r.test_name = 'totals_match';
  
update consort c set patients_match =
  exists (select 1 from test_results r where r.measure_name = c.measure_name
     and passed and r.test_name = 'agrees_with_expected')
  and not exists (select 1 from test_results r where r.measure_name = c.measure_name
     and not passed and r.test_name != 'totals_match')
  where exists (select 1 from test_results r where r.measure_name = c.measure_name and r.test_name != 'totals_match');

create or replace view measure_populations as
   select measure, count(*) total_populations, sum((patients_match and count_matches)::integer) passing_populations,
     count(*) = sum((patients_match and count_matches)::integer) fully_passes
   from consort
   group by measure;


