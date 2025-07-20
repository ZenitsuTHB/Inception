# Fichier : Makefile

DOCKER= docker
COMPOSE= ${DOCKER} compose

MANDATORY_PATH= -f ./docker-compose.yml

all: build up

up:
	sudo mkdir -p /home/avolcy/data/db
	sudo mkdir -p /home/avolcy/data/wp
	${COMPOSE} ${MANDATORY_PATH} up --build -d
	sudo mkdir -p $(HOME)/data/mysql $(HOME)/data/wordpress

down:
	docker-compose down

clean: down
	docker system prune -a -f

.PHONY: all build up down clean
