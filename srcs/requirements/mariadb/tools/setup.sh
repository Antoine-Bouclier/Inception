#!/bin/bash

# Save password from secrets
USER_PWD=$(cat /run/secrets/db_password)
USER_ROOT_PWD=$(cat /run/secrets/db_root_password)

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "First start: Initializing MariaDB."
	# Initializes the mariadb data directory and creates the system tables
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql
	mariadbd-safe --datadir=/var/lib/mysql --skip-networking &
	until mariadb-admin ping > /dev/null 2>&1; do
		sleep 2
	done

	echo "Database started successfully!"

	echo "Creation of the database..."
	mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

	echo "Creation of the user..."
	mariadb -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${USER_PWD}';"

	echo "Setting privileges..."
	mariadb -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"

	echo "Securing root user..."
	mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${USER_ROOT_PWD}';"

	echo "Flush piviliges..."
	mariadb -u root -p${USER_ROOT_PWD} -e "FLUSH PRIVILEGES;"

	mariadb-admin -u root -p${USER_ROOT_PWD} shutdown
fi

echo "MariaDB is ready."
chown -R mysql:mysql /var/lib/mysql
exec mariadbd --user=mysql --datadir=/var/lib/mysql --console
