sqldir=cms/sql

cd $sqldir

for f in `find . -name \*.errs -size 0 -print`; do
    psql -f `basename $f .errs`.sql cqm >& `basename $f .errs`.out
done
