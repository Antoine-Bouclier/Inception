FROM		debian:bookworm

LABEL		project="inception"

#		nginx	-> HTTP web server
#		openssl	-> lib that provide secure communications
RUN		apt-get update && apt-get install -y --no-install-recommends \
		nginx \
		openssl \
		curl \
		&& rm -rf /var/lib/apt/lists/*

#		We redirect Nginx access logs to /dev/stdout (Standard Output).
#		This allows 'docker logs <container>' to display real-time web traffic in your terminal.
RUN		ln -sf /dev/stdout /var/log/nginx/access.log

#		We redirect Nginx error logs to /dev/stderr (Standard Error).
#		This ensures that any server crashes or config errors are captured by the Docker log collector.
RUN		ln -sf /dev/stderr /var/log/nginx/error.log

#		Creation of the directory for security key. (SSL)
RUN		mkdir -p /etc/nginx/ssl

#		Generation of the certificate auto-signed
#		-x509 : create an auto-signed certificates
#		-nodes : no password
#		-out / -keyout : where to save the certificate and the key
#		-subj : information about the certificate : 
#		/C=FR -> country | /ST=ARA -> state | /L=Lyon -> locality | /O=42 -> Organization | /OU=42 -> Organizational Unit | /CN=abouclie.42.fr -> Common Name
RUN		openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=ARA/L=Lyon/O=42/OU=42/CN=abouclie.42.fr"

COPY		./conf/nginx.conf /etc/nginx/site-available/nginx.conf

#		Create a symbolic link to activate the configuration
RUN		ln -s /etc/nginx/site-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf

RUN		rm -f /etc/nginx/sites-enabled/default

EXPOSE		443

#		Graceful shutdown -> finish handling current requests when the container is shutdown 
STOPSIGNAL 	SIGQUIT

CMD 		["nginx", "-g", "daemon off;"]
