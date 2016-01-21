#!/bin/sh

measure_base=`pwd`/../licensed/measure_bundle/2.6.0/sources/ep
scratchdir=`pwd`/scratch

mkdir -p $scratchdir
measures=`cat prop_provider_measures`
cd ..
for m in $measures; do
    ./hqmf2sql.sh -s "201301010000" -e "201312312359" -d cqm $measure_base/$m/hqmf_model.json > $scratchdir/${m}.sql 2> $scratchdir/${m}.errs
done
