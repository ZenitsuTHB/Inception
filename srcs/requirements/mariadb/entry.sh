#!/bin/sh

set -e

mysql_config_file()
{
	echo "Copying configuration file"
	cat << EOF > /etc/my.cnf
	[mysqld]
	user=mysql
	datadir=${MDB_DIR}
	port=${MDB_PORT}
	bind-address=0.0.0.0
	socket=/run/mysqld/mysqld.sock
EOF
}

create_database()
{
	db_password_file=/run/secrets/mdb_user_password
	db_root_password_file=/run/secrets/mdb_root_password

	if [ -f $db_password_file ] && [ -f $db_root_password_file ]; then

	db_password=$(cat $db_password_file)
	db_root_password=$(cat $db_root_password_file)

cat << EOF > ${MDB_DIR}/init-db.sql
	CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;

	CREATE USER IF NOT EXISTS "${MYSQL_ROOT}"@"%" IDENTIFIED BY "$db_root_password";
	ALTER USER 'root'@'localhost' IDENTIFIED BY "$db_root_password";
	GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO "${MYSQL_ROOT}"@"%" WITH GRANT OPTION;

	CREATE USER IF NOT EXISTS "${MYSQL_USER}"@"localhost" IDENTIFIED BY "$db_password";
	GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO "${MYSQL_USER}"@"localhost";
	CREATE USER IF NOT EXISTS "${MYSQL_USER}"@"%" IDENTIFIED BY "$db_password";
	GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO "${MYSQL_USER}"@"%";

	FLUSH PRIVILEGES;
EOF

	else
		echo "$db_password_file or $db_root_password_file not found..."
	fi
}


start_database()
{

	echo "Creating Database"
	if [ -d "${MDB_DIR}/mysql" ]; then
		echo "Database already initialized, starting MariaDB..."
	else

	mysql_install_db --user=mysql --datadir=${MDB_DIR} > /dev/null 2>&1

	mysqld --datadir=${MDB_DIR} &

	while ! mysqladmin ping --silent; do
	    echo "Waiting for Mariadb..."
	    sleep 1
	done

	create_database

	mysql -u root -p"$db_root_password" < ${MDB_DIR}/init-db.sql > /dev/null 2>&1
	mysqladmin shutdown -u root -p"$db_root_password"
fi
	
echo "Database Created!"

}

add_group()
{
	group=$1
	user=$2
	dir=$3

	if  ! getent group "$group" > /dev/null 2>&1; then
		addgroup -S $group; 
	fi 
	if  ! getent passwd "$user" > /dev/null 2>&1; then
		adduser -S -D -H -s /sbin/nologin -g $group $user;
	fi
	mkdir -p /run/mysqld
	chown -R $user:$group $dir	
	chown -R $user:$group /run/mysqld	
}

init_mdb() {
	add_group "mysql" "mysql" "/var/lib/mysql"
	mysql_config_file 
	start_database
	exec $@
}

if [ $1 = "mysqld" ];
then 
       init_mdb "$@"
else
 	exec "$@"	
fi
