#!/bin/sh

for f in cscratch/*.sql; do
    psql -f $f cqm >& cscratch/`basename $f .sql`.out
done