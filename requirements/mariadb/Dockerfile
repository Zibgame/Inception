#choisir debian
FROM debian:bullseye

# mettre a joure tout est installer mariadb
RUN apt-get update \
	&& apt-get install -y mariadb-server \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

#utiliser copy pour copier mon fichier init
COPY ./tools/init.sh /init.sh

RUN chmod +x /init.sh

# commande qui se lance au demarage
CMD ["/init.sh"] 