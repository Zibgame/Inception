FROM debian:bookworm

RUN apt-get update \
    && apt-get install -y mariadb-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN rm -rf /var/lib/mysql/*

RUN sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

COPY ./tools/init.sh /init.sh
RUN chmod +x /init.sh

CMD ["/init.sh"]