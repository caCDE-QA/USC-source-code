#!/bin/sh

for f in scratch/*.sql; do
    psql -f $f cqm >& scratch/`basename $f .sql`.out
done