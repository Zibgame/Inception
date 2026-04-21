FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php \
    php-fpm \
    php-mysql \
    mariadb-client \
    wget \
    tar \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html
RUN mkdir -p /run/php

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz \
	&& tar -xzf latest.tar.gz \
	&& mv wordpress/* . \
	&& rm -rf wordpress latest.tar.gz

RUN chown -R www-data:www-data /var/www/html

RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/init.sh /init.sh
RUN chmod +x /init.sh

CMD ["/init.sh"]