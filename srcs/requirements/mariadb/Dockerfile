FROM		debian:bookworm

LABEL		project="inception"

RUN		apt-get update && \
		apt-get install -y --no-install-recommends mariadb-server mariadb-client && \
		rm -rf /var/lib/apt/lists/*

RUN		mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY		conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY		tools/setup.sh /usr/local/bin/setup.sh

RUN		chmod +x /usr/local/bin/setup.sh

HEALTHCHECK	--interval=30s --timeout=5s --start-period=30s --retries=3 \
    		CMD mysqladmin ping -u root -p$(cat /run/secrets/db_root_password) || exit 1

ENTRYPOINT	["/usr/local/bin/setup.sh"]

EXPOSE		3306
