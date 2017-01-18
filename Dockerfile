FROM php:7.1.0-fpm

MAINTAINER igtulm@gmail.com

WORKDIR /work

RUN apt-get update && apt-get install -y \
        sudo \
        libpq-dev \
        libcurl4-gnutls-dev \
        libexpat1-dev gettext \
        libz-dev \
        libssl-dev \
        git \
        zip \
        unzip

RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash - \
    && apt-get install -y nodejs

RUN ln -s "$(which nodejs)" /usr/sbin/node

RUN npm install gulp-cli -g

RUN docker-php-ext-install pdo_pgsql

RUN curl -sS https://getcomposer.org/installer -o ~/composer-setup.php \
    && php ~/composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && rm -rf ~/composer-setup.php

RUN rm -rf /var/lib/apt/lists/*