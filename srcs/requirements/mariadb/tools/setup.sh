# Save password from secrets
USER_PWD=$(cat /run/secrets/db_password.txt)

USER_ROOT_PWD=$(cat /run/secrets/db_root_password.txt)

if [! -d "/var/lib/mysql/mysql"]; then
	echo "Initialization fo the database"
	# Initializes the mariadb data directory and creates the system tables
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql


