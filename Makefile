NAME = inception

COMPOSE = docker compose -f srcs/docker-compose.yml

all:
	mkdir -p /home/zcadinot/data/mariadb
	mkdir -p /home/zcadinot/data/wordpress
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v
	docker system prune -af

fclean: clean
	sudo rm -rf /home/zcadinot/data/mariadb
	sudo rm -rf /home/zcadinot/data/wordpress

re: fclean all

.PHONY: all down clean fclean re
