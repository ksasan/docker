#!/bin/sh

ctrname=dkrctrnm
numberctrs=`docker ps -a | grep $ctrname | tr -s " " | cut -d " " -f 1 | wc -l`
ctrlist=`docker ps -a | grep $ctrname | tr -s " " | cut -d " " -f 1`

if [[ $numberctrs -gt 0 ]] ; then 
	echo "Stopping containers ..."
	docker stop $ctrlist
	echo "Removing containers ..."
	docker rm $ctrlist
else
	echo "No container to stop / remove !"
fi
exit 0
