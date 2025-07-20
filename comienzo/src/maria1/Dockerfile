FROM alpine:3.16

# Instalar dependencias necesarias
RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client \
    tini \
    su-exec \
    curl \
	&& mkdir -p /run/mysqld /var/lib/mysql \
	&& chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Copiar archivos de configuración
COPY ./conf/init.sql /docker-entrypoint-initdb.d/
COPY ./conf/my.cnf /etc/my.cnf
COPY ./conf/entrypoint.sh /entrypoint.sh

# Permisos
RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
CMD ["mysqld", "--user=mysql"]
