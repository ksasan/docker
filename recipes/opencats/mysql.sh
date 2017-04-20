#!/usr/bin/env bash
echo "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY 'toor' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql  
echo "GRANT ALL ON *.* TO root@'localhost' IDENTIFIED BY 'toor' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql  
echo "GRANT ALL ON *.* TO 'root'@'127.0.0.1' IDENTIFIED BY 'toor' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql  
