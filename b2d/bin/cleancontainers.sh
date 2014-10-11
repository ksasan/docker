#!/bin/sh

counter=1
numberhosts=7
hostname=dkrctrhost
ctrname=dkrctrnm
ctrlist=`docker ps -a | grep $ctrname | tr -s " " | cut -d " " -f 1`
docker rm $ctrlist

exit 0
