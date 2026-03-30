FROM php:8.3.8-cli

# Dépendances système
RUN apt-get update && apt-get install -y \
    libicu-dev \
    procps \
    cron \
    && rm -rf /var/lib/apt/lists/*

# Extensions PHP
RUN docker-php-ext-install intl pdo_mysql opcache pcntl

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Config PHP
RUN echo "upload_max_filesize = 20M" > /usr/local/etc/php/conf.d/uploads.ini && \
    echo "post_max_size = 20M" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "memory_limit = 10G" > /usr/local/etc/php/conf.d/docker-php-memory-limit.ini


# Dossier de travail
WORKDIR /var/www/html

# Crontab setup
COPY crontab /etc/cron.d/laravel-scheduler
RUN chmod 0644 /etc/cron.d/laravel-scheduler && \
    crontab /etc/cron.d/laravel-scheduler

CMD ["cron", "-f"]