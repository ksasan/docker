#!/usr/bin/env bash
echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY PASSWORD 'toor' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql  
echo "GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY PASSWORD 'toor' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql  
