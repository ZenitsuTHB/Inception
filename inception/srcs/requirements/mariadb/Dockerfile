FROM alpine:3.20

# Install MariaDB
RUN apk update && apk add --no-cache mariadb mariadb-client

# Create runtime directories
RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

# Copy initialization script
COPY ./conf/init.sql /docker-entrypoint-initdb.d/init.sql

# Create data volume dir with correct perms
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

# Expose port (optional, compose handles internal network)
EXPOSE 3306

# Entrypoint script for proper PID 1 behavior (no tail hack)
COPY ./conf/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

