#!/bin/bash
set -e

# Load passwords from secrets
USER_PWD=$(cat /run/secrets/db_password)
USER_ROOT_PWD=$(cat /run/secrets/db_root_password)

# Check if the database is already initialized
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "First start: Initializing MariaDB..."

    # 1. Initialize data directory
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    # 2. Start MariaDB in background to configure it
    # We use --skip-networking for security during setup
    mariadbd-safe --datadir=/var/lib/mysql --skip-networking &
    
    # Wait for the server to be ready
    until mariadb-admin ping > /dev/null 2>&1; do
        echo "Waiting for MariaDB..."
        sleep 2
    done

    echo "Database started, running configuration..."

    # 3. Execute setup commands
    mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mariadb -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${USER_PWD}';"
    mariadb -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
    
    # Secure root and set password
    mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${USER_ROOT_PWD}';"
    
    # 4. Finalize
    mariadb -u root -p"${USER_ROOT_PWD}" -e "FLUSH PRIVILEGES;"

    # 5. Shutdown the background server to restart it normally later
    mariadb-admin -u root -p"${USER_ROOT_PWD}" shutdown
    
    echo "Initial configuration finished."
else
    echo "Database already initialized, skipping setup."
fi

# Ensure permissions are correct every time
chown -R mysql:mysql /var/lib/mysql

echo "Starting MariaDB normally..."
# 'exec' replaces the shell with the mariadbd process as PID 1
exec mariadbd --user=mysql --datadir=/var/lib/mysql --console
