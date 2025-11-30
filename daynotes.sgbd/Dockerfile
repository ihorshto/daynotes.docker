FROM mysql:8.4.0

MAINTAINER me

# Setup the custom configuration
ADD mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

# Add security initialization script
ADD init-security.sql /docker-entrypoint-initdb.d/

ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}

EXPOSE ${DB_PORT}
