#!/bin/bash

set -e

echo "Waiting for MariaDB..."

# Démarrage temporaire du serveur MariaDB en arrière-plan pour init
mysqld_safe --datadir=/var/lib/mysql --user=mysql &
pid="$!"

# Attente que MariaDB soit prête
until mysqladmin ping --silent; do
    echo "MariaDB not ready yet..."
    sleep 2
done

echo "MariaDB is ready!"

# Création base + user si pas déjà fait
mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

FLUSH PRIVILEGES;
EOF

echo "Database and user created"

# Stop du mysqld_safe temporaire
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

wait "$pid"

echo "Starting MariaDB in foreground..."

# IMPORTANT : process principal Docker (foreground)
exec mysqld_safe --datadir=/var/lib/mysql --user=mysql --console