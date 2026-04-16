FROM	debian:bookworm

LABEL	project="inception"

# Install dependencies in one layer
RUN	apt-get update && apt-get upgrade -y &&\
	apt-get -y install wget \
	php-fpm \
	php-mysql \
	php-curl \
	curl \
	mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

# Download the wp-cli.phar file
RUN	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	mkdir -p /run/php # PHP-FPM needs this directory to store its PID file

# Copy our custom configuration
COPY	./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

WORKDIR	/var/www/html

EXPOSE	9000

# Copy the setup script and set it as the entrypoint
COPY ./tools/auto-config.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/auto-config.sh

ENTRYPOINT ["/usr/local/bin/auto-config.sh"]

# Run PHP-FPM in the foreground to keep the container alive
CMD ["php-fpm8.2", "-F"]
