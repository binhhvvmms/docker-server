FROM php:7.4-fpm-alpine

RUN set -ex \
    && apk add --no-cache  \
    gcc \
    libzip-dev \
    gd \
    zip \
    mysql-client \
    imagemagick

RUN set -ex; \
    apk add --no-cache --virtual .build-deps \
    autoconf \
    g++ \
    make \
    freetype-dev \
    imagemagick-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libxml2-dev \
    bzip2-dev \
    oniguruma-dev \
    sqlite-dev \
    icu-dev \
    ; \
    \
    docker-php-ext-configure gd --with-freetype --with-jpeg; \
    docker-php-ext-install -j "$(nproc)" \
    bcmath \
    exif \
    mysqli \
    pdo_mysql \
    sockets \
    pcntl \
    ; \
    pecl install imagick; \
    docker-php-ext-enable imagick; \
    apk del .build-deps

STOPSIGNAL SIGQUIT

EXPOSE 9000
CMD ["php-fpm"]