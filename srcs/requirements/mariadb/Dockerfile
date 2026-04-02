FROM		debian:bookworm

LABEL		maintainer="abouclie <abouclie@student.42lyon.fr>" 

RUN		apt-get update && \
		apt-get install -y --no-install-recommends mariadb-server mariadb-client && \
		rm -rf /var/lib/apt/lists/*

HEALTHCHECK 	--start-period=5m \
		CMD mariadb -e 'SELECT @@datadir;' || exit 1

COPY		conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY		tools/setup.sh /usr/local/bin/setup.sh
RUN		chmod +x /usr/local/bin/setup.sh

ENTRYPOINT	["/usr/local/bin/setup.sh"]

EXPOSE		3306

CMD		["mariadbd", "--user=mysql", "--bind-adress=0.0.0.0"]
