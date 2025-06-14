#!/bin/sh

set -e

mysql_config_file()
{
	echo "Copying configuration file"
	cat << EOF > /etc/my.cnf
	[mysqld]
	user=mysql
	datadir=${MYSQL_DATADIR}
	port=${MARIADB_PORT}
	bind-address=0.0.0.0
	socket=/run/mysqld/mysqld.sock
EOF
}

start_database()
{

	echo "Creating Database"
	if [ -d "${MYSQL_DATADIR}/mysql" ]; then
		echo "Database already initialized, starting MariaDB..."
	else

	mysql_install_db --user=mysql --datadir=${MYSQL_DATADIR} > /dev/null 2>&1

	mysqld --datadir=${MYSQL_DATADIR} &

	while ! mysqladmin ping --silent; do
	    echo "Waiting for Mariadb..."
	    sleep 1

	create_database

	mysql -u root -p"$db_root_password" < ${MYSQL_DATADIR}/init-db.sql > /dev/null 2>&1
	mysqladmin shutdown -u root -p"$db_root_password"
	done
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
	chown -R $user:$group $dir	
}

init_mdb() {
	add_group "mysql" "mysql" "/var/lib/mysql"
	mysql_config_file 
	exec $@ -f /dev/null
}

if [ $1 = "tail" ];
then 
       init_mdb "$@"
else
 	exec "$@"	
fi
