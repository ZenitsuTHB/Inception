#!/bin/sh

set -e

secret_pw_file="/run/secrets/mdb_user_password"
if [ ! -f "$secret_pw_file" ]; then
    echo "❌ Cannot find DB password secret!"
    exit 1
fi

WORDPRESS_DB_PASSWORD=$(cat "$secret_pw_file")

echo "🔎 DNS check: pinging mariadb..."
ping -c 3 mariadb || echo "❌ mariadb DNS resolution failed"

echo "🌐 Testing DB port 3306 reachability..."
nc -zv mariadb 3306 || echo "❌ mariadb:3306 not reachable"

echo "🔐 Testing login..."
mysql -h mariadb -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" -e "SELECT 1;" || echo "❌ MariaDB login failed"

echo "🔄 ENTRYPOINT: Starting WordPress setup..."

until mysql -h mariadb -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" -e "SELECT 1;" >/dev/null 2>&1; do
    echo "⌛ Waiting for MariaDB to allow logins..."
    sleep 1
done

echo "✅ MariaDB is accepting connections!"

# Rest of your WordPress setup logic...
