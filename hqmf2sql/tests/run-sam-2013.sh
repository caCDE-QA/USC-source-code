#!/bin/sh

usage="$0 out"

if [ $# -ne 1 ]; then
   echo $usage
   exit 1
fi

outdir=$1; shift

for f in `cat sam.list.2013`; do
    num=`basename $f .json`
    outbase=$outdir/$num
    ../hqmf2sqlv2.sh -u -H hqmf_sam_$num -s '2013-01-01' -e '2013-12-31' cqm $f > ${outbase}.sql 2> ${outbase}.errs
done

