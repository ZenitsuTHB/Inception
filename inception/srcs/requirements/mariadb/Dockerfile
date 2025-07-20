FROM alpine:3.20.3

RUN apk update && apk add --no-cache \
    mariadb mariadb-client tini su-exec

RUN mkdir -p /run/mysqld /var/lib/mysql \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY ./conf/my.cnf /etc/my.cnf
COPY ./conf/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]

