#!/bin/sh
if [ $# -lt 1 ]; then
   echo "Usage $0 <container_id> [directory]"
   exit 1
fi
cid=$1
shift
if [ $# -lt 1 ]; then
   destDir=~/data
else
   destDir=$1
   shift
fi
path=`docker inspect ${cid} | grep "mnt.*vfs" | head -1 | tr -s ' ' | cut -d  " " -f 3 | xargs echo `
ln -s ${path} ~/data
#cmd="ln -s ${path} ${destDir}"
#echo "Running $cmd "
