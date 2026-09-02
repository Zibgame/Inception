#!/bin/bash

echo "Waiting for MariaDB..."
until mysql -h mariadb -u"${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" \
      -e "USE ${WORDPRESS_DB_NAME};" > /dev/null 2>&1; do
    sleep 2
done
echo "MariaDB ready."

cd /var/www/html

if [ ! -f wp-config.php ]; then
    wp config create \
        --dbname="${WORDPRESS_DB_NAME}" \
        --dbuser="${WORDPRESS_DB_USER}" \
        --dbpass="${WORDPRESS_DB_PASSWORD}" \
        --dbhost="mariadb" \
        --allow-root
fi

if [ ! -f /var/www/html/.installed ]; then
    wp core install \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root

    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --role=author \
        --user_pass="${WP_USER_PASSWORD}" \
        --allow-root

    touch /var/www/html/.installed
fi

exec php-fpm8.2 -F