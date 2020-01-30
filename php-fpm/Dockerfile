FROM php:7.4-fpm-alpine

ENV APCU_VERSION 5.1.18
ENV TZ=Europe/Paris

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

RUN apk add --no-cache \
        ca-certificates \
        icu-libs \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libzip-dev \
        git \
        unzip \
        tzdata \
        imagemagick-dev \
        libtool  \
        libxml2-dev  \
        ghostscript  \
        imagemagick  \
	gmp gmp-dev \
        zlib-dev && \
    apk add --no-cache --virtual .build-deps  \
        $PHPIZE_DEPS \
        icu-dev \
         && \
    docker-php-ext-install \
        intl \
        zip && \
    pecl install apcu-${APCU_VERSION} && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    docker-php-ext-enable apcu && \
    docker-php-ext-enable opcache && \
    docker-php-ext-install mysqli pdo pdo_mysql && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd && \
    docker-php-ext-install gmp && \
    docker-php-ext-install soap && \
    pecl install xdebug && \
    pecl install imagick  && \
    docker-php-ext-enable imagick && \
    echo "short_open_tag = off" >> /usr/local/etc/php/php.ini && \
    echo "date.timezone = ${TZ}" >> /usr/local/etc/php/conf.d/symfony.ini && \
    echo "opcache.max_accelerated_files = 20000" >> /usr/local/etc/php/conf.d/symfony.ini && \
    echo "realpath_cache_size=4096K" >> /usr/local/etc/php/conf.d/symfony.ini && \
    echo "realpath_cache_ttl=600" >> /usr/local/etc/php/conf.d/symfony.ini && \
    echo "zend_extension=xdebug.so" >> /xdebug.ini && \
    echo "xdebug.remote_autostart=1" >> /xdebug.ini && \
    echo "xdebug.remote_connect_back=0" >> /xdebug.ini && \
    apk del .build-deps icu-dev $PHPIZE_DEPS zlib-dev  && \
    apk add gosu --update --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted && \
    wget https://get.symfony.com/cli/installer -O - | bash &&  \
    addgroup bar && \
    adduser -D -h /home -s /bin/sh -G bar foo

ADD entrypoint.sh /entrypoint
RUN chmod +x /entrypoint
WORKDIR /srv

ENTRYPOINT ["/entrypoint"]
