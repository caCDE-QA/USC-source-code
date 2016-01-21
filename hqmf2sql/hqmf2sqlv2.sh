#!/bin/sh

db=cqm
mydir=`dirname $0`
usage="Usage: $0 [-d] [-j] [-n] [-s start] [-e end] [-H hqmf_schema] [-r result_schema] [-y year] [-u] db file"

while getopts "djns:e:H:r:y:u" option; do
    case $option in
	d)
	    dopt="-d"
	    ;;
	j)
	    jopt="-j"
	    ;;
	n)
	    nopt="-n"
	    ;;
	u)
	    uopt="-u"
	    ;;
	s)
	    sopts="-s $OPTARG"
	    ;;
	e)
	    eopts="-e $OPTARG"
	    ;;
	H)
	    Hopts="-H $OPTARG"
	    ;;

	y)
	    year=$OPTARG
	    sopts="-s ${year}01010000"
	    eopts="-e ${year}12312359"
	    ;;
	?)
	    echo $usage;
	    exit 1;
    esac
done

shift $((OPTIND-1))

db=$1; shift
file=$1; shift

if [ `basename "$file" .xml` != `basename "$file"` ]; then
    newfile=,${$}.json
    python3 $mydir/xmltojson.py < $file > $newfile
    file=$newfile
fi

export DYLD_FALLBACK_LIBRARY_PATH=/Library/PostgreSQL/9.4/lib
mypythonpath="${mydir}:${mydir}/build"
if [ "X$PYTHONPATH" != X ]; then
   export PYTHONPATH="$mypythonpath:$PYTHONPATH"
else
   export PYTHONPATH="$mypythonpath"
fi

python3 $mydir/hqmf2sqlv2.py $uopt $dopt $jopt $nopt $sopts $eopts $Hopts $ropts $db $file
