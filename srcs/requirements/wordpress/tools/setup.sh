#!/bin/bash

# wait for mysql to start
sleep 10

cd /var/www/html

if [ ! -f /var/www/html/wp-config.php ]; then

	wp core download --allow-root

	wp config create \
		--dbname=${MYSQL_DATABASE} \
		--dbuser=${MYSQL_USER} \
		--dbpass=${MYSQL_PASSWORD} \
		--dbhost=mariadb:3306 \
		--allow-root

	wp core install \
		--url=${DOMAIN_NAME} \
		--title=${WORDPRESS_TITLE} \
		--admin_user=${WORDPRESS_ADMIN_USER} \
		--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
		--admin_email="${WORDPRESS_ADMIN_EMAIL}" \
		--allow-root

	wp user create \
		guest ${WORDPRESS_GUEST_EMAIL} \
		--user_pass=${WORDPRESS_GUEST_PASSWORD} \
		--role=author \
		--allow-root
fi

exec php-fpm8.2 -F
