#!/bin/sh

set -e

echo "🔎 DNS check: pinging mariadb..."
ping -c 3 mariadb || echo "❌ mariadb DNS resolution failed"

echo "🌐 Testing DB port 3306 reachability..."
nc -zv mariadb 3306 || echo "❌ mariadb:3306 not reachable"

echo "🔐 Testing login..."
mysql -h mariadb -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" -e "SELECT 1;" || echo "❌ MariaDB login failed"

echo "🔄 ENTRYPOINT: Starting WordPress setup"

until mysql -h mariadb -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" -e "SELECT 1;" > /dev/null 2>&1; do
  echo "⌛ Waiting for MariaDB to allow logins..."
  sleep 1
done

echo "✅ MariaDB is accepting connections!"

echo "📁 Checking if WordPress already exists..."
if [ ! -f /var/www/html/wp-config.php ]; then
  if [ ! -f /var/www/html/index.php ]; then
    echo "📥 Downloading WordPress..."
    curl -L -O https://wordpress.org/wordpress-latest.tar.gz > /dev/null 2>&1 && \
    echo "📦 Extracting..."
    tar -xzf wordpress-latest.tar.gz -C /var/www/html --strip-components=1 && \
    rm wordpress-latest.tar.gz || { echo '❌ Extract failed!'; exit 1; }
    chown -R www:www /var/www/html
  fi

  echo "⚙️ Generating wp-config.php..."
  cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

  sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" wp-config.php
  sed -i "s/username_here/${WORDPRESS_DB_USER}/" wp-config.php
  sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/" wp-config.php
  sed -i "s/localhost/mariadb/" wp-config.php
else
  echo "✅ WordPress already installed."
fi

echo "🚀 Starting php-fpm..."
exec php-fpm
