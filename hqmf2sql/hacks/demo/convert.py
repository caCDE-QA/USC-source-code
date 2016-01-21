#!/usr/bin/python3

import cgi
import cgitb
from tempfile import mkstemp
from os import fdopen, chdir, execv

workdir="/var/local/hqmf-scratch"
prog="/home/laura/src/hqmf2sql-trunk/hacks/demo/simplexml2sql.sh"

cgitb.enable(display=0, logdir="/tmp")
form=cgi.FieldStorage()
hqmf=form.getvalue("hqmf")
year=form.getvalue("year")
result_schema=form.getvalue("result_schema")
data_schema=form.getvalue("data_schema")
(hfd, hname) = mkstemp()
hfile=fdopen(hfd, mode="wb")
hfile.write(hqmf)
hfile.close()
print("Content-type: application/sql")
print("Content-disposition: attachment; filename=measure.sql\n\n", flush=True)
chdir(workdir)
args = ["simplexml2sql.sh", "-w", workdir]
if year is not None and year.strip != '':
    args.append('-y')
    args.append(year)
if result_schema is not None and result_schema.strip != '':
    args.append('-r')
    args.append(result_schema)
if data_schema is not None and data_schema.strip != '':
    args.append('-H')
    args.append(data_schema)
args.append(hname)
execv(prog, args)



