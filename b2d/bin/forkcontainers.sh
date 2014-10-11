#!/bin/sh

counter=1
numberhosts=3
hostname=dkrctrhost
ctrname=dkrctrnm

while true ; do
	echo "Running loop iteration #${counter} #"
	hostid="${hostname}-${counter}"
	dkrctrid="${ctrname}-${counter}"
	#docker run -d -h ${hostid} --name=${dkrctrid} ubuntu:14.04
	docker run -d -h ${hostid} --name=${dkrctrid} ubuntussh:14.04 


	counter=$(( counter + 1 ))
	if [[ $counter -gt $numberhosts ]] ; then
		echo "All hosts spawned. Now exiting "
		exit 0
	fi
done

exit 0
