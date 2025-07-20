.PHONY: build up down clean re fclean

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

clean:	down
	docker system prune -f

re: clean build up

fclean: clean
	sudo rm -rf /home/archly/data/*
	docker system prune -a -f
