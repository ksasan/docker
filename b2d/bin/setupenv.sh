#!/bin/sh 
reldir=`dirname $0`
absdir=`cd ${reldir}/.. > /dev/null ; pwd `
homedir=`cd > /dev/null ; pwd `
setupdir="${homedir}/workarea"
cmd="ln -s ${absdir} ${setupdir}"
ln -s ${absdir} ${setupdir}
#echo "Target Dir : $setupdir "
#echo "Running command $cmd "
#dir=$absdir
#echo "Dir is $dir"
