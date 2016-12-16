FROM php:7.1.0-fpm

MAINTAINER igtulm@gmail.com

WORKDIR /work

RUN apt-get update && apt-get install -y \
        sudo \
        libpq-dev

RUN docker-php-ext-install pdo_pgsql

RUN rm -rf /var/lib/apt/lists/*