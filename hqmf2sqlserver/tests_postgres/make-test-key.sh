#!/bin/sh
answer_schema=answer_schema

echo "create schema ${answer_schema};"

for measure in $*; do
    echo "drop table if exists ${answer_schema}.${measure}_patient_summary;"
    echo "create table ${answer_schema}.${measure}_patient_summary as select * from results_cypress_ep.${measure}_patient_summary;"
    echo "alter table ${answer_schema}.${measure}_patient_summary add constraint uniq_${measure}_pat_pop unique(patient_id, population_id);"
done

