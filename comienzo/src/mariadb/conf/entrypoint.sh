#!/bin/sh
set -e

# Inicializar base de datos solo si está vacía
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql > /dev/null

    # Ejecutar init.sql en modo bootstrap, sin abrir red
    mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking --bootstrap < /docker-entrypoint-initdb.d/init.sql

    echo "Database initialized"
fi

# Ejecutar MariaDB en primer plano, sin trucos ni background
exec su-exec mysql mysqld --datadir=/var/lib/mysql

##!/bin/sh
#
#set -e
#
## Setup DB only if empty
#if [ ! -d "/var/lib/mysql/mysql" ]; then
#    echo "Initializing database..."
#    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql > /dev/null
#
#    # Start MySQL server in background
#    mysqld_safe --user=mysql &
#
#    # Wait for socket to be ready
#    while ! mysqladmin ping --silent; do
#        sleep 1
#    done
#
#    # Apply init SQL (users, passwords, privileges)
#    echo "Applying init SQL..."
#    mysql < /docker-entrypoint-initdb.d/init.sql
#
#    # Stop MySQL after setup
#    mysqladmin shutdown
#fi
#
## Final run: Safe foreground execution (PID 1)
#exec mysqld_safe --user=mysql
#
