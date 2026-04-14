#!/bin/bash

# Save password from secrets
MYSQL_PWD=$(cat /run/secrets/db_password)
WP_ADMIN_PWD=$(cat /run/secrets/wp_admin_password)
WP_USER_PWD=$(cat /run/secrets/wp_user_password)

# Give Mariadb some time to fully initialize
sleep 3

# Check if WordPress is already downloaded (to avoid overwriting every restart)
if [ ! -f /var/www/html/wp-config.php ]; then

	# Download WordPress core files
	wp core download --allow-root

	# Create the wp-config.php file using your secrets and .env variables
	wp config create \
		--dbname=$MYSQL_DATABASE \
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PWD \
		--dbhost=mariadb \
		--allow-root

	# Install WordPress and create the admin user
	wp core install \
		--url=$DOMAIN_NAME \
		--title=$SITE_TITLE \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PWD \
		--admin_email=$WP_ADMIN_EMAIL \
		--allow-root

	# Create an additional non-admin user (often required by the subject)
	wp user create $WP_USER_LOGIN $WP_USER_EMAIL \
		--role=author \
		--user_pass=$WP_USER_PWD \
		--allow-root
fi

exec "$@"
