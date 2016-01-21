#!/bin/sh

usage="Usage: $0 [-P patient_dir] {eh|ep} db"

mydir=`cd \`dirname $0\`; pwd`

patdir=$mydir/cypress_test_data

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

create schema cypress_data_${measuretype};
set search_path = cypress_data_${measuretype};

create table patient_json (
  patient json
);

EOF

for p in $patdir/*.xml; do
    python parse_cypress_patients.py $p | jsonlint -F | sed -e 's/\\n/\\\\n/g' | psql -c "\copy cypress_data_${measuretype}.patient_json from STDIN" $db
done

