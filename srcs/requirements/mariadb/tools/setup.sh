#!bin/bash

service mariadb start

sleep 5

mariadb -e "CREATE DATABASE IF NOT EXISTS '${MYSQL_DATABASE}';"

mariadb -e "CREATE USER IF NOT EXIST '${MYSQL_USER}' IDENTIFIED BY '${MYSQL_PASSWORD}';"
