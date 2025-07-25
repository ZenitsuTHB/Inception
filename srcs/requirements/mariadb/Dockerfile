# Fichier : nginx/Dockerfile
# Nous choisissons Alpine pour sa légèreté
FROM alpine:3.21

RUN apk update && apk add --no-cache mariadb-client mariadb

COPY --chmod=744 ./entry.sh /

ENTRYPOINT ["./entry.sh"]

EXPOSE 3306

# Lançons NGINX au démarrage
CMD ["mysqld"]
