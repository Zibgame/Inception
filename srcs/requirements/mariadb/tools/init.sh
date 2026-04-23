#!/bin/bash

mysqld_safe &
pid="$!"

echo "Waiting for MariaDB..."

until mysqladmin ping --silent; do
	sleep 2
done

echo "MariaDB started"

mysql -u root -p"$MYSQL_ROOT_PASSWORD" << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

wait "$pid"
