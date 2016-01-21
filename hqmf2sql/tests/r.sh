#!/bin/sh

usage="$0 out"

if [ $# -ne 1 ]; then
   echo $usage
   exit 1
fi

outdir=$1; shift

for f in `cat ,list`; do
    outbase=$outdir/`basename $f .json`
    ../hqmf2sqlv2.sh -H hqmf_cypress_ep -s '2014-01-01' -e '2014-12-31' cqm $f > ${outbase}.sql 2> ${outbase}.errs
done
