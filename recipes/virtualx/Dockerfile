#
# Dockerfile
#
FROM ubuntu:14.10
MAINTAINER Khelender Sasan "ksasan@gmail.com"

# ---------------------------------------------------------------------------
# Setup environment variables
# ---------------------------------------------------------------------------
ARG username=user
ARG passwd=pass
ENV username=$username
ENV passwd=$passwd

RUN export LANGUAGE=en_US.UTF-8         \
        && export LANG=en_US.UTF-8      \
        && export LC_ALL=en_US.UTF-8

# ---------------------------------------------------------------------------
#  Handle old releases of Linux 
# ---------------------------------------------------------------------------
RUN sudo echo "deb http://cz.archive.ubuntu.com/ubuntu precise main universe" >> /etc/apt/sources.list
RUN sudo sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

# ---------------------------------------------------------------------------
# Prepare for running in daemon mode
# ---------------------------------------------------------------------------
RUN apt-get update && apt-get install -y openssh-server supervisor vim	\
&& COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# ---------------------------------------------------------------------------
# Setup User
# ---------------------------------------------------------------------------
RUN echo "User $username is being setup" \
&& adduser --gecos "${username},,,," --disabled-login ${username}

# ---------------------------------------------------------------------------
# Allow login permission
# ---------------------------------------------------------------------------
RUN  sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config 	\
	&& sed -i 's/bind-address.\+/bind-address=0.0.0.0/' /etc/mysql/my.cnf 			\
	&& mkdir /var/run/supervisor && mkdir /var/run/sshd					\
	&& echo 'root:toor' | chpasswd 								\
	&& echo ${username}:${passwd} | sudo chpasswd

# ---------------------------------------------------------------------------
# Installation of VirtualX
# ---------------------------------------------------------------------------
RUN apt-get install -y curl
# Basic packages 
RUN sudo apt-get install -y build-essential bison openssl libreadline5 curl git \ 
 zlib1g zlib1g-dev libssl-dev libxml2-dev libmysqlclient-dev libcurl3 libcurl3-gnutls  \
 libcurl4-openssl-dev			\
 libruby1.8 libmysql-ruby1.8 libcurl4-gnutls-dev	\
 apache2-dev apache2 mysql-client

# --------------------
# SQL setup
# --------------------
RUN echo "										\
	CREATE DATABASE virtx CHARACTER SET utf8 COLLATE utf8_bin;			\
	CREATE USER 'virtx'@'%' IDENTIFIED BY 'virtx' ;					\
	GRANT ALL ON 'virtx'.* TO virtx@'%' IDENTIFIED BY 'virtx' WITH GRANT OPTION;	\
	GRANT ALL ON *.* TO root@'%' IDENTIFIED BY 'toor' WITH GRANT OPTION; 		\
	FLUSH PRIVILEGES" | mysql

# --------------------
# Ruby related setup
# --------------------
RUN curl -L https://get.rvm.io | bash -s stable --autolibs=enabled
RUN source /etc/profile.d/rvm.sh		\
	&& rvm install ruby-1.8.7		\
	&& rvm use ruby-1.8.7 --default 	\
	&& cd /var/www/virtualx			\
	&& gem install gemset			\
	&& gem install bundle			\
	&& bundle install			\
	&& gem install rails --version 3.0.3	\
	&& cp /var/www/virtualx/config/database.yml.example /var/www/virtualx/config/database.yml \
	&& sed -i -re 's/\r//g ; s/host:\s*localhost/host: db/g ; s/database:.*/database: virtx/ ; s/username:.*/username: virtx/ ; s/passwd:.*/passwd: virtx/;' config/database.yml 		 	\
	&& rake db:create RAILS_ENV=production	\
	&& rake db:migrate RAILS_ENV=production \
	&& rake db:seed RAILS_ENV=production	\
	&& gem install passenger		\
	&& passenger-install-apache2-module

#RUN source /home/${username}/.rvm/scripts/rvm	\
#    source /usr/local/rvm/bin/rvmrc		\

RUN  echo "LoadModule passenger_module /home/user/.rvm/gems/ruby-1.8.7-head/gems/passenger-5.1.5/buildout/apache2/mod_passenger.so
   <IfModule mod_passenger.c>
     PassengerRoot /home/user/.rvm/gems/ruby-1.8.7-head/gems/passenger-5.1.5
     PassengerDefaultRuby /home/user/.rvm/gems/ruby-1.8.7-head/wrappers/ruby
   </IfModule> " >> /etc/apache2/apache2.conf
RUN sudo service apache2 restart


# ---------------------------------------------------------------------------
# Ports setup
# ---------------------------------------------------------------------------
EXPOSE 80 
EXPOSE 22 

#stuff for mysql
COPY ./mysql.sh /opt/mysql.sh  

CMD ["/usr/bin/supervisord"]

# -------------------------------------------------------------------------------
# JUNK
# -------------------------------------------------------------------------------
#	&& sed -i -re 's/\r//' config/database.yml \
#	&& sed -i -re 's/host:\s*localhost/host: db/' config/database.yml \
#	&& sed -i -re 's/database:.*/database: virtx/' config/database.yml \
#	&& sed -i -re 's/username:.*/username: virtx/' config/database.yml \
#	&& sed -i -re 's/passwd:.*/passwd: virtx/' config/database.yml \
