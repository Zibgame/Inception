#!/bin/bash

export MYSQL_USER=$WORDPRESS_DB_USER
export MYSQL_PASSWORD=$WORDPRESS_DB_PASSWORD
export MYSQL_DATABASE=$WORDPRESS_DB_NAME

echo "Waiting for MariaDB..."

until mysql -h mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "USE $MYSQL_DATABASE;" > /dev/null 2>&1
do
	sleep 2
done

echo "MariaDB ready"

cd /var/www/html

if [ ! -f wp-config.php ]; then
	cp wp-config-sample.php wp-config.php
fi

sed -i "s/database_name_here/$MYSQL_DATABASE/" wp-config.php
sed -i "s/username_here/$MYSQL_USER/" wp-config.php
sed -i "s/password_here/$MYSQL_PASSWORD/" wp-config.php
sed -i "s/localhost/mariadb/" wp-config.php

if [ ! -f /var/www/html/.installed ]; then
    wp core install \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root

    wp user create ${WP_USER} ${WP_USER_EMAIL} \
        --role=author \
        --user_pass=${WP_USER_PASSWORD} \
        --allow-root

    touch /var/www/html/.installed
fi

exec php-fpm7.4 -F
