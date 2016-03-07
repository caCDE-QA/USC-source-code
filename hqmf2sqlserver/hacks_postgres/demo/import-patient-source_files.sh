#!/bin/sh

usage="Usage: $0 [-P patient_dir] {eh|ep} db"

mydir=`cd \`dirname $0\`; pwd`

patdir=$mydir/../../licensed/measure_bundle/2.6.0/patients/ep/json

while getopts "P:" option; do
    case $option in
	        P)
		        patdir="$OPTARG"
			;;
	?)
	echo $usage;
	exit 1;
	esac
done
shift $((OPTIND-1))

if [ $# -ne 2 ]; then
    echo $usage
    exit 1
fi

measuretype=$1; shift
db=$1; shift

psql $db <<EOF

create schema source_data_${measuretype};
set search_path = source_data_${measuretype};

create table patient_json (
  patient json
);

EOF

for p in $patdir/*.json; do
    jsonlint -F $p| sed -e 's/\\n/\\\\n/g' | psql -c "\copy source_data_${measuretype}.patient_json from STDIN" $db
done

