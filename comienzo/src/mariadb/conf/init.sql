CREATE DATABASE IF NOT EXISTS wordpress;/*${DB_NAME};*/

CREATE USER IF NOT EXISTS /*'${DB_USER}'*/'dbuser'@'%' IDENTIFIED BY 'dbpass';/*'${DB_PASS}';*/
GRANT ALL PRIVILEGES ON wordpress.* TO /*'${DB_USER}'*/'dbuser'@'%';

CREATE USER IF NOT EXISTS 'editor'@'%' IDENTIFIED BY 'editorpass';
GRANT ALL PRIVILEGES ON wordpress.* TO 'editor'@'%';/*for remote connetion*/

CREATE USER IF NOT EXISTS 'editor'@'localhost' IDENTIFIED BY 'editorpass';
GRANT ALL PRIVILEGES ON wordpress.* TO 'editor'@'localhost';

FLUSH PRIVILEGES;

