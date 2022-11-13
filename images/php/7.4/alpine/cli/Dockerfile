FROM php:7.4-cli-alpine

RUN set -ex \
    && apk add --no-cache  \
    zip \
    gd \
    libzip-dev \
    mysql-client \
    ; \
    \
    apk add --no-cache --virtual .build-deps \
    autoconf \
    g++ \
    make \
    imagemagick-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libwebp-dev \
    freetype-dev \
    libxml2-dev \
    bzip2-dev \
    oniguruma-dev \
    sqlite-dev \
    icu-dev \
    ; \
    \
    docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp; \
    docker-php-ext-install gd; \
    docker-php-ext-install -j "$(nproc)" \
    zip \
    bcmath \
    exif \
    mysqli \
    pdo_mysql \
    sockets \
    pcntl \
    ; \
    apk del .build-deps


RUN curl -O https://getcomposer.org/download/latest-stable/composer.phar && \
    mv composer.phar /usr/bin/composer && \
    chmod +x /usr/bin/composer