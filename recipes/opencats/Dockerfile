#
# Dockerfile
#
#FROM sasan/opencats:v0.5
FROM ubuntu:16.04
MAINTAINER Khelender Sasan "ksasan@gmail.com"

RUN apt-get update

RUN apt-get update && apt-get install -y openssh-server supervisor
RUN mkdir -p /var/run/sshd /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD install.sh /install.sh
RUN /install.sh

RUN echo 'root:toor' | chpasswd \
	&& sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
	&& sed -i 's/bind-address.\+/bind-address=0.0.0.0/' /etc/mysql/my.cnf \
	&& mkdir /var/run/supervisor && mkdir /var/run/sshd

EXPOSE 80 
EXPOSE 22 
EXPOSE 3306

#stuff for mysql
COPY ./mysql.sh /opt/mysql.sh  


# Docker user
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo


#WORKDIR /root
CMD ["/usr/bin/supervisord"]
