cat <<EOF
set search_path = results;

create table measures (measure_id text, description text);
\copy measures (measure_id, description) from 'measures.csv' with csv

create table global_summary (measure_id text, measure_name text, ipp boolean, denom boolean, denex boolean, numer boolean, denexcep boolean, total integer);

EOF
for m in `tr '[A-Z]' '[a-z]' < measures_good.txt`; do
    num=`echo $m | sed -e 's/cms//' -e 's/v.*//'`
cat <<EOF
insert into global_summary (measure_id, measure_name, ipp, denom, denex, numer, denexcep, total)
   select '${m}', m.description, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep, count(distinct(patient_id))
   from measure_${num}_0_patient_summary
   left join measures m on m.measure_id = '${m}'
   group by effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep, m.description;
EOF
done
