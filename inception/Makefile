NAME=inception

up:
	docker compose -f srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	sudo rm -rf /home/$(LOGIN)data

fclean: clean
	docker system prune -af --volumes

re: fclean up

