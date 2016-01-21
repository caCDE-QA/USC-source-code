#!/bin/sh

usage="Usage: $0 {eh|ep} [psql_args] ..."

if [ $# -lt 1 ]; then
   echo $usage
   exit 1
fi

mtype=$1; shift

psql -v cypress_schema=cypress_data_${mtype} -v hqmf_schema=hqmf_cypress_${mtype} -f convert_cypress_patients.sql $*