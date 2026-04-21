FROM		debian:bookworm

LABEL		project="inception"

RUN		apt-get update && \
		apt-get install -y --no-install-recommends mariadb-server mariadb-client && \
		rm -rf /var/lib/apt/lists/*

RUN		mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY		conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY		tools/setup.sh /usr/local/bin/setup.sh

RUN		chmod +x /usr/local/bin/setup.sh

ENTRYPOINT	["/usr/local/bin/setup.sh"]

EXPOSE		3306
