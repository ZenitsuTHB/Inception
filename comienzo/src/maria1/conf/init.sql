CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER 'wp_admin'@'%' IDENTIFIED BY 'secure_wp_pass';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_admin'@'%';

CREATE USER 'superuser'@'%' IDENTIFIED BY 'very_secure_root_pass';
GRANT ALL PRIVILEGES ON *.* TO 'superuser'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;
