FROM php:8.3.8-cli

# Dépendances système
RUN apt-get update && apt-get install -y \
    libzip-dev \
    git \
    zip \
    curl \
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
    default-mysql-client \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Extensions PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd bz2 intl iconv bcmath opcache calendar pdo_mysql zip ldap pcntl

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Add user with same UID as host user
ARG uid
RUN useradd -G root -u $uid -d /home/devuser devuser
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
CMD ["php", "artisan", "queue:work", "--verbose", "--tries=3", "--timeout=90"]
