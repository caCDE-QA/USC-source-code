#!/bin/sh

for f in `cat ,list`; do
    psql -f $f cqm > out/`basename $f .sql`.out
done

