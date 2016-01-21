#!/bin/sh

omopdir=/opt/beari
omop_schema=omop_test4

$omopdir/common/omop_schemas/new_omop_schema.sh -o $omop_schema -n
echo ""
cat to_omop.sql
