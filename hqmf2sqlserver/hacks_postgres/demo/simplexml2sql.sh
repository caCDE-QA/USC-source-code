#!/bin/sh

usage="Usage: $0 file"

year=2013

mydir=`cd \`dirname $0\`; pwd`
hqmfdir=`cd $mydir/../..; pwd`
simplexmldir=`cd $mydir/../../licensed/simplexml_parser; pwd`
workdir="$simplexmldir"
rvm=/usr/local/rvm/bin/rvm
while getopts "w:s:e:y:H:r:" option; do
    case $option in
	w)
	    workdir=$OPTARG
	    ;;
	s)
	    sopts="-s $OPTARG"
	    ;;
	e)
	    eopts="-e $OPTARG"
	    ;;
	y)
	    yopts="-y $OPTARG"
	    ;;
	H)
	    Hopts="-H $OPTARG"
	    ;;
	r)
	    ropts="-r $OPTARG"
	    ;;

	?)
	    echo $usage;
	    exit 1
    esac
done

shift $((OPTIND-1))

parseddir=${workdir}/tmp/parsed

if [ $# -ne 1 ]; then
   echo $usage
   exit 1
fi

file=$1
#jsonfile=`echo "$file" | sed -e "s:.*/:$parseddir/:" -e "s/_SimpleXML//" -e "s/.xml$/.json/"`


cd $simplexmldir

jsonfile=`$rvm 2.0.0 do bundle exec rake "simplexml:parse[${file}]" | grep "^Wrote:" | sed -e 's/Wrote: //'`
if [[ $jsonfile != /* ]]; then
    jsonfile=${workdir}/$jsonfile
fi

cd $hqmfdir
./hqmf2sql.sh $sopts $eopts $Hopts $ropts $yopts -d cqm $jsonfile
