FROM debian:bookworm


# Instalation of Nginx and  OpenSSL
RUN apt update && apt install -y nginx openssl

# Creation of the directory for security key. (SSL)
RUN mkdir -p /etc/nginx/ssl

# Generation of the certificate auto-signed
# req -x509 : create an auto-signed certificates
# -nodes : no password
# -out / -keyout : where to save the certificate and the key
# -subj : information about the certificate : 
# /C=FR -> country | /ST=ARA -> state | /L=Lyon -> locality | /O=42 -> Organization | /OU=42 -> Organizational Unit | /CN=abouclie.42.fr -> Common Name
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=ARA/L=Lyon/O=42/OU=42/CN=abouclie.42.fr"

# copy the file configuration from host to the image
COPY conf/nginx.conf /etc/mginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
