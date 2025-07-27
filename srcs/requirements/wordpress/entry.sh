#!/bin/sh
set -e

echo "🚀 Starting WordPress container..."

if [ ! -f ./wp-config.php ]; then
  echo "🔧 Downloading WordPress..."
  wp core download --allow-root

  echo "⚙️ Configuring WordPress..."
  dbpass=$(cat /run/secrets/mdb_user_password)
  wp config create \
    --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
	--dbpass=$dbpass \
    --dbhost=mariadb \
    --allow-root

  echo "🛠 Installing WordPress..."
  wp core install \
    --url=$DOMAIN_NAME \
    --title="$WORDPRESS_TITLE" \
    --admin_user=$WORDPRESS_ADMIN \
    --admin_password=$WORDPRESS_ADMIN_PASS \
    --admin_email=$WORDPRESS_ADMIN_EMAIL \
    --skip-email \
    --allow-root

  echo "👤 Creating additional user..."
  wp user create $WORDPRESS_USER $WORDPRESS_EMAIL \
    --role=author \
    --user_pass=$WORDPRESS_USER_PASS \
    --allow-root

  echo "🎨 Installing and activating theme..."
  wp theme install twentytwentytwo --activate --allow-root
fi

echo "✅ Starting PHP-FPM..."
exec /usr/sbin/php-fpm8.2 -F
