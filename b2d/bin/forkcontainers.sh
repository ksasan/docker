#!/bin/sh

counter=1
numberhosts=3
hostname=dkrctrhost
ctrname=dkrctrnm
imagename=boot2docker:5000/ubuntusshd
#imagename=ksasan/ubuntusshd

while true ; do
	echo "Running loop iteration #${counter} #"
	hostid="${hostname}${counter}"
	dkrctrid="${ctrname}${counter}"
	cmd="docker run -d -h ${hostid} --name=${dkrctrid} $ctridlist $imagename"
	echo "Running command $cmd "
	fullctrid=`$cmd `
	ctrid=`echo $fullctrid | cut -c1-8 `
	#ctrid="ctr${counter}"

#	if [[ $counter -eq 1 ]] ; then
#		#ctridlist="--link=${ctrid}:${hostid}"
#		ctridlist="--link=${hostid}:${ctrid}"
#	else
#		#ctridlist="${ctridlist} --link=${ctrid}:${hostid}"
#		ctridlist="${ctridlist} --link=${hostid}:${ctrid}"
#	fi
#	#ctridparam="--link=[${ctridlist}]"


	counter=$(( counter + 1 ))
	if [[ $counter -gt $numberhosts ]] ; then
		echo "All hosts spawned. Now exiting "
		exit 0
	fi
done

exit 0
