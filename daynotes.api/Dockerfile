FROM php:8.3.8-apache

# Dépendances système + Node.js
RUN apt-get update && apt-get install -y \
    libzip-dev \
    git \
    zip \
    curl \
    sudo \
    unzip \
    libicu-dev \
    libbz2-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libgd-dev \
    libmcrypt-dev \
    libreadline-dev \
    libldap2-dev \
    gnupg2 \
    cron \
    default-mysql-client \
    procps \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

COPY ./config/sites-available/* /etc/apache2/sites-available/
COPY ./config/ports.conf /etc/apache2/ports.conf

# # Copy Apache config, create from example if it doesn't exist
# COPY ./config/sites-available/ /tmp/apache-config/
# RUN if [ ! -f /tmp/apache-config/000-default.conf ]; then \
#     cp /tmp/apache-config/000-default.conf.example /tmp/apache-config/000-default.conf; \
#     fi && \
#     cp /tmp/apache-config/000-default.conf /etc/apache2/sites-available/000-default.conf

# Activer modules utiles
RUN a2enmod rewrite ssl headers && \
    a2ensite 000-default.conf

# Le DocumentRoot sera géré par la config Apache directement

# Extensions PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd bz2 intl iconv bcmath opcache calendar pdo_mysql zip ldap pcntl

# Install Xdebug
RUN pecl install xdebug-3.3.2 && \
    docker-php-ext-enable xdebug

# Copy Xdebug configuration
COPY ./config/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Create xdebug log file
RUN touch /var/log/xdebug.log && chmod 666 /var/log/xdebug.log

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Add user with same UID as host user
ARG uid
RUN useradd -G www-data,root -u $uid -d /home/devuser devuser
RUN mkdir -p /home/devuser/.composer && \
    chown -R devuser:devuser /home/devuser

# Config PHP
RUN echo "upload_max_filesize = 50M" > /usr/local/etc/php/conf.d/uploads.ini && \
    echo "post_max_size = 50M" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "memory_limit = 20G" > /usr/local/etc/php/conf.d/docker-php-memory-limit.ini

# Configuration du timezone
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Dossier de travail
WORKDIR /var/www/html

# Le contenu sera monté via le volume Docker
# Les dépendances seront installées au démarrage via onLaunch.sh

# Les permissions seront définies au démarrage via onLaunch.sh car le volume sera monté

# Certbot
RUN apt update
RUN apt install -y certbot python3-certbot-apache