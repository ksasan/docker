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
ARG virtx=virtx
ARG dbHost=db
ENV username=$username		\
	passwd=$passwd		\
	virtx=$virtx		\
	dbHost=$dbHost

# ---------------------------------------------------------------------------
#  Handle old releases of Linux 
# ---------------------------------------------------------------------------
RUN sudo echo "deb http://cz.archive.ubuntu.com/ubuntu precise main universe" >> /etc/apt/sources.list		\
	&& sudo sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

# ---------------------------------------------------------------------------
# Prepare for running in daemon mode
# ---------------------------------------------------------------------------
RUN apt-get update && apt-get install -y openssh-server supervisor vim
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# ---------------------------------------------------------------------------
# Setup User
# ---------------------------------------------------------------------------
RUN echo "User $username is being setup" \
&& adduser --gecos "${username},,,," --disabled-login ${username}

# ---------------------------------------------------------------------------
# Allow login permission
# ---------------------------------------------------------------------------
RUN  sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config 	\
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
 libcurl4-openssl-dev	
RUN sudo apt-get update
RUN sudo apt-get install -y libruby1.8 libmysql-ruby1.8 libcurl4-gnutls-dev	\
 apache2-dev apache2 mysql-client

COPY ./virtualx.tgz /var/www/.
RUN cd /var/www			\
  && tar zxf virtualx.tgz	\
  && rm virtualx.tgz


# --------------------
# Ruby related setup
# --------------------
RUN curl -L https://get.rvm.io | bash -s stable --autolibs=enabled

# --------------------
# Ruby related setup
# --------------------
SHELL	["/bin/bash", "-c"]
WORKDIR /var/www/virtualx
RUN export LANGUAGE=en_US.UTF-8         	\
        && export LANG=en_US.UTF-8      	\
        && export LC_ALL=en_US.UTF-8		\
	&& source /etc/profile.d/rvm.sh		\
	&& rvm install ruby-1.8.7		\
	&& rvm use ruby-1.8.7 --default 	\
	&& gem install gemset			\
	&& gem install bundle			\
	&& bundle install

RUN gem install rails --version 3.0.3

WORKDIR /
ADD ./mysql.sh /opt/mysql.sh  

# -----------------------------------------------
# Content to be run after linkage to database 
# -----------------------------------------------
SHELL	["/bin/bash", "-c"]
RUN	cp /var/www/virtualx/config/database.yml.example /var/www/virtualx/config/database.yml \
	&& sed -i -re 's/\r//g ; s/host:\s*localhost/host: db/g ; s/database:.*/database: virtx/ ; s/username:.*/username: virtx/ ; s/password:.*/password: virtx/;' /var/www/virtualx/config/database.yml

# -----------------------------------------------
# Setup other important components (WSGI related)
# -----------------------------------------------
COPY virtxDbSetup.sh /tmp/virtxDbSetup.sh
COPY apacheModPassenger.conf /tmp/apacheModPassenger.conf 
COPY virtualx.conf  /etc/apache2/sites-available/virtualx.conf
RUN cat /tmp/apacheModPassenger.conf >> /etc/apache2/apache2.conf
SHELL	["/bin/bash", "-c"]
RUN cd /var/www/virtualx				\
	&& source /etc/profile.d/rvm.sh			\
	&& gem install passenger			\
	&& passenger-install-apache2-module --auto

# -----------------------------------------------
# Final touch
# -----------------------------------------------
RUN sudo chown -R www-data:www-data /var/www/virtualx	\
	&& a2dissite 000-default.conf			\
	&& a2ensite virtualx.conf

# ---------------------------------------------------------------------------
# Ports setup
# ---------------------------------------------------------------------------
EXPOSE 80 
EXPOSE 22 

CMD ["/usr/bin/supervisord"]






