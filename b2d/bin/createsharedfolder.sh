#!/bin/sh
cid=`docker run -v /data --name my-data busybox true`
docker run --rm -v /usr/local/bin/docker:/docker -v /var/run/docker.sock:/docker.sock svendowideit/samba my-data
path=`docker inspect ${cid} | grep "mnt.*vfs" | head -1 | tr -s " " | cut -d  " " -f 3 | xargs echo `
ln -s ${path} ~/data
