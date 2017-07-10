#/bin/bash
source /etc/profile.d/rvm.sh		\
&& cd /var/www/virtualx			\
&& rake db:create RAILS_ENV=production	\
&& rake db:migrate RAILS_ENV=production 	\
&& rake db:seed RAILS_ENV=production
