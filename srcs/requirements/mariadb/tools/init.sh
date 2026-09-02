#!/bin/bash
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "First boot: initializing MariaDB..."

    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db

    # Ecrire le SQL dans un fichier (pas de background, --init-file le lit au démarrage)
    cat > /tmp/init.sql << SQLEOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
SQLEOF

    echo "Starting mysqld with init file..."
    exec mysqld --user=mysql --datadir=/var/lib/mysql --init-file=/tmp/init.sql --console
fi

exec mysqld --user=mysql --datadir=/var/lib/mysql --console