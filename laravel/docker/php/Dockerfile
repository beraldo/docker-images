FROM php:8.2-fpm

# xdebug.ini file path
ARG xdebug_conf_file="/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini"

# Your application root path
ARG app_dir="/app"

RUN apt-get update \
    && apt-get install -y \
        libpq-dev \
        libgmp-dev \
        libicu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install \
        bcmath \
        intl \
        opcache \
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
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && rm -rf /var/lib/apt/lists/* /tmp/*

# Some suggested debug packages and other useful stuff
# RUN apt-get update \
#     && apt-get install -y \
#         ca-certificates \
#         curl \
#         wget \
#         git \
#         vim \
#         less \
#         iputils-ping \
#         inetutils-telnet \
#     && rm -rf /var/lib/apt/lists/* /tmp/*



# Expose ports 9000 (php-fpm) and 9003 (xdebug)
EXPOSE 9000 9003

COPY ./docker/php/php.ini "$PHP_INI_DIR/php.ini"
COPY ./docker/php/xdebug.ini ${xdebug_conf_file}

WORKDIR ${app_dir}

# Copy your application files/folders to the container
COPY ./app ./app
COPY ./artisan ./artisan
COPY ./bootstrap ./bootstrap
COPY ./composer.json ./composer.json
COPY ./composer.lock ./composer.lock
COPY ./config ./config
COPY ./database ./database
COPY ./package.json ./package.json
COPY ./phpunit.xml ./phpunit.xml
COPY ./public ./public
COPY ./resources ./resources
COPY ./routes ./routes
COPY ./storage ./storage
COPY ./tests ./tests
COPY ./vendor ./vendor
COPY ./vite.config.js ./vite.config.js

COPY ./docker-cmd.sh docker-cmd.sh

# Run composer install
RUN XDEBUG_MODE=on composer install --no-interaction --prefer-dist

CMD ./docker-cmd.sh