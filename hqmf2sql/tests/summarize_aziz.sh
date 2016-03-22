cat <<EOF
\set race_code 4013886
\set ethnicity_code 4271761

set search_path = results, hqmf_altamed_2016_02_21, omop_altamed_2016_02_21;

create table all_results (
    measure_id varchar,
    measure_name varchar,
    patient_id integer,
    effective_ipp boolean,
    effective_denom boolean,
    effective_denex boolean,
    effective_numer boolean,
    effective_denexcep boolean
);
EOF

for m in `tr '[A-Z]' '[a-z]' < measures_good.txt`; do
    num=`echo $m | sed -e 's/cms//' -e 's/v.*//'`
cat <<EOF
insert into all_results(measure_id, measure_name, patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep)
   select '${m}', m.description, patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep
   from measure_${num}_0_patient_summary s
   left join measures m on m.measure_id = '${m}';
EOF
done

cat <<EOF
create table safe_harbor_patient_characteristic as
   select patient_id,
   greatest(date_trunc('year', start_dt), '1-1-1927'::date) start_dt,
   date_trunc('year', end_dt) end_dt,
   code,
   status,
   negation,
   value,
   null::text audit_key_type,
   null::integer audit_key_value
from patient_characteristic;

insert into safe_harbor_patient_characteristic (patient_id, start_dt, code, value)
   select person_id,
   (greatest(year_of_birth, 1927)::text || '-01-01')::date start_dt,
   :race_code,
   race_concept_id
from person;

insert into safe_harbor_patient_characteristic (patient_id, start_dt, code, value)
   select person_id,
   (greatest(year_of_birth, 1927)::text || '-01-01')::date start_dt,
   :ethnicity_code,
   ethnicity_concept_id
from person;
EOF
