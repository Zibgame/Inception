FROM debian:bullseye

RUN apt-get update \
	&& apt-get install -y mariadb-server \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY ./tools/init.sh /init.sh

RUN chmod +x /init.sh

RUN sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

CMD ["/init.sh"]
