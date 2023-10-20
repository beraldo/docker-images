#!/usr/bin/env bash
#
# Script used in the CMD os the docker image
# It runs the routines that must be executed on every startup of the container, such as database migrations, composer install/update etc

echo "***********************************************"
echo "     Initializing PHP-FPM container... "
echo "***********************************************"


# Install application dependencies using Composer
COMPOSER_MEMORY_LIMIT=4096M XDEBUG_MODE=off composer install --no-interaction

# Run database migrations
# php artisan migrate

# Clear cache
# php artisan cache:clear

# Keep php-fpm running
php-fpm
