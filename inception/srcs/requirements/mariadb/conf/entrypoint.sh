#!/bin/sh
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "🔧 Initializing MariaDB..."
  mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql > /dev/null

  echo "⚙️ Executing SQL bootstrap commands..."
  mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking --bootstrap <<EOSQL
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

CREATE USER IF NOT EXISTS 'editor'@'%' IDENTIFIED BY 'editorpass';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO 'editor'@'%';

CREATE USER IF NOT EXISTS 'editor'@'localhost' IDENTIFIED BY 'editorpass';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO 'editor'@'localhost';

DROP USER IF EXISTS ''@'localhost';
DROP USER IF EXISTS ''@'$(hostname)';
DROP DATABASE IF EXISTS test;

FLUSH PRIVILEGES;
EOSQL
  echo "✅ MariaDB configured."
fi

exec su-exec mysql mysqld --datadir=/var/lib/mysql

