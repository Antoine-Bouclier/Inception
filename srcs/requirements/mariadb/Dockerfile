FROM	debian:bookworm

LABEL	maintainer="abouclie <abouclie@student.42lyon.fr>" 

RUN	apt-get update && \
	apt-get install -y --no-install-recommends mariadb-server mariadb-client && \
	rm -rf /var/lib/apt/lists/*

COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
