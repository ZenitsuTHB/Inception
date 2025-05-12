# Fichier : Makefile
all: build up

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

clean: down
	docker system prune -a -f

.PHONY: all build up down clean
