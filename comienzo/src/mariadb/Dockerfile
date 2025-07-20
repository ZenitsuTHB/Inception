FROM alpine:3.20.3

# Instalar MariaDB, tini y su-exec para manejar señales y usuarios
RUN apk update && apk add --no-cache \
    mariadb mariadb-client tini su-exec

# Crear carpetas necesarias con permisos adecuados
RUN mkdir -p /run/mysqld /var/lib/mysql \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Copiar archivos de configuración y scripts
COPY ./conf/init.sql /docker-entrypoint-initdb.d/init.sql
COPY ./conf/my.cnf /etc/my.cnf
COPY ./conf/entrypoint.sh /entrypoint.sh

# Dar permisos de ejecución al entrypoint
RUN chmod +x /entrypoint.sh

# Exponer el puerto de MariaDB
EXPOSE 3306

# Usar tini para buen manejo de señales y lanzar entrypoint
ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]

#FROM alpine:3.20
#
## Install MariaDB
#RUN apk update && apk add --no-cache mariadb mariadb-client
#
## Create runtime directories
#RUN mkdir -p /run/mysqld
#RUN chown -R mysql:mysql /run/mysqld
#
## Copy initialization script
#COPY ./conf/init.sql /docker-entrypoint-initdb.d/init.sql
#COPY ./conf/my.cnf /etc/my.cnf
#
## Create data volume dir with correct perms
#RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql
#
## Expose port (optional, compose handles internal network)
#EXPOSE 3306
#
## Entrypoint script for proper PID 1 behavior (no tail hack)
#COPY ./conf/entrypoint.sh /entrypoint.sh
#RUN chmod +x /entrypoint.sh
#
#ENTRYPOINT ["/entrypoint.sh"]

