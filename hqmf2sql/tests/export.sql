set search_path = results;

\copy (select * from global_summary order by measure_id, numer, denom) to 'results/summary.csv' with csv header force quote measure_id, measure_name
\copy all_results to 'results/all_results.csv' with csv header force quote measure_id, measure_name
\copy safe_harbor_patient_characteristic to 'results/safe_harbor_patient_characteristic.csv' with csv header force quote start_dt, end_dt, status, value, audit_key_type
