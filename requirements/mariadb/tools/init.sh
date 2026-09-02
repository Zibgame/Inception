#!/bin/bash

service mariadb start

sleep 3

mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;"
mysql -e "CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'wppass';"
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';"
mysql -e "FLUSH PRIVILEGES;"

mysqladmin shutdown

exec mysqld_safe