#!/bin/sh

set -e

# Setup DB only if empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql > /dev/null

    # Start MySQL server in background
    mysqld_safe --user=mysql &

    # Wait for socket to be ready
    while ! mysqladmin ping --silent; do
        sleep 1
    done

    # Apply init SQL (users, passwords, privileges)
    echo "Applying init SQL..."
    mysql < /docker-entrypoint-initdb.d/init.sql

    # Stop MySQL after setup
    mysqladmin shutdown
fi

# Final run: Safe foreground execution (PID 1)
exec mysqld_safe --user=mysql

