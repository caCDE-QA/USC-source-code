#!/bin/sh

db=cqm
mydir=`dirname $0`
usage="Usage: $0 [-d db] [-j] [-n] [-s start] [-e end] [-H hqmf_schema] [-r result_schema] [-y year] file"

while getopts "d:jns:e:H:r:y:" option; do
    case $option in
	d)
	    db=$OPTARG
	    ;;
	j)
	    jopt="-j"
	    ;;
	n)
	    nopt="-n"
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
	r)
	    ropts="-r $OPTARG"
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

export DYLD_FALLBACK_LIBRARY_PATH=/Library/PostgreSQL/9.4/lib
mypythonpath="${mydir}:${mydir}/build"
if [ "X$PYTHONPATH" != X ]; then
   export PYTHONPATH="$mypythonpath:$PYTHONPATH"
else
   export PYTHONPATH="$mypythonpath"
fi

python3 $mydir/hqmf2sql.py $jopt $nopt $sopts $eopts $Hopts $ropts $db $*
