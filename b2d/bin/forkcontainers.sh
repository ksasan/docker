#!/bin/sh

counter=1
numberhosts=3
hostname=dkrctrhost
ctrname=dkrctrnm
imagename=boot2docker:5000/ubuntusshd
#imagename=ksasan/ubuntusshd

while true ; do
	echo "Running loop iteration #${counter} #"
	hostid="${hostname}-${counter}"
	dkrctrid="${ctrname}-${counter}"
	docker run -d -h ${hostid} --name=${dkrctrid} $imagename


	counter=$(( counter + 1 ))
	if [[ $counter -gt $numberhosts ]] ; then
		echo "All hosts spawned. Now exiting "
		exit 0
	fi
done

exit 0
