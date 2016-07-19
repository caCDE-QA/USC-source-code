usage="$0 [psql_options]"

cd `dirname $0`

psql $* <<EOF
drop schema results cascade;
create schema results;
EOF

psql -f ../create_test_funcs.sql $*
psql -f ../measure_prep/create_date_funcs.sql $*
