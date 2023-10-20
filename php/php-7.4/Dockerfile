FROM php:7.4-fpm

# xdebug.ini file path
ARG xdebug_conf_file="/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini"

# Your application root path
ARG app_dir="/app"

RUN apt-get update \
    && apt-get install -y \
        libgmp-dev \
        libicu-dev \
        libpq-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install \
        bcmath \
        intl \
        pcntl \
        pdo \
        pdo_pgsql \
        pgsql \
    && docker-php-ext-enable \
        bcmath \
        intl \
        opcache \
        pcntl \
        pdo \
    && pecl update-channels \
    && pecl install xdebug-3.1.5 \
    && docker-php-ext-enable xdebug \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && rm -rf /var/lib/apt/lists/* /tmp/*

# Some suggested debug packages and other useful stuff
RUN apt-get update \
    && apt-get install -y \
        ca-certificates \
        curl \
        wget \
        git \
        vim \
        less \
        iputils-ping \
        inetutils-telnet \
    && rm -rf /var/lib/apt/lists/* /tmp/*

# Exposes ports 9000 (php-fpm) and 9003 (xdebug)
EXPOSE 9000 9903

COPY ./php.ini "$PHP_INI_DIR/php.ini"
COPY ./xdebug.ini ${xdebug_conf_file}

WORKDIR ${app_dir}

# Copy your application files/folders to the container
# COPY ./config ./config
# COPY composer.json composer.json
# COPY composer.lock composer.lock
# COPY ...
# COPY ...
COPY index.php index.php

# Run composer install
# RUN COMPOSER_MEMORY_LIMIT=4096M XDEBUG_MODE=off composer install --no-interaction


# CMD ./docker-cmd.sh
