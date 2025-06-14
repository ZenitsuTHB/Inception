# Fichier : Makefile

DOCKER= docker
COMPOSE= ${DOCKER} compose

MANDATORY_PATH= -f ./docker-compose.yml

all: build up

up:
	${COMPOSE} ${MANDATORY_PATH} up --build -d

down:
	docker-compose down

clean: down
	docker system prune -a -f

.PHONY: all build up down clean
