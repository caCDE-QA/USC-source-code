#!/bin/sh 

usage="$0 [-x] [-s sourcedir] [-o outdir]"
outdir=.

skip_cache_rebuild=

sourcedir=../licensed/measure_bundle/2.7.0/

while getopts "xs:o:" option; do
    case $option in
	x)
	    skip_cache_rebuild=true
	    ;;
	s)
	    sourcedir=$OPTARG
	    ;;
	o)
	    outdir=$OPTARG
	    ;;
	?)
	    echo $usage;
	    exit 1
    esac
done

cache_dir=$outdir/vs_cache
cache_sanity_file=$cache_dir/this_is_a_cache

shift $((OPTIND-1))

mydir=`cd \`dirname $0\`; pwd`

cd $mydir


if [ "X$skip_cache_rebuild" = X ]; then
   if [ -e $cache_dir ]; then
      if [ ! -d $cache_dir ]; then
	  echo "$0: $cache_dir is not a directory"
	  exit 1
      fi
      if [ ! -e $cache_sanity_file ]; then
          echo "$cache_sanity_file not found; not deleting $cache_dir"
          exit 1
      fi
      rm -rf $cache_dir
   fi
   mkdir $cache_dir
   touch $cache_sanity_file
   python ./dump_value_sets.py $cache_dir ${sourcedir}/value_sets/json/*
fi


cat create_valueset_tables.sql
sed -e "s:vs_cache:${cache_dir}:" load_value_sets.sql
cat add_to_omop_vocabulary.sql create_valueset_omop_mappings.sql load_hl7_tables.sql

