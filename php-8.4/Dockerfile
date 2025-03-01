FROM php:8.4-fpm-alpine as base

ENV PHP_OPCACHE_ENABLE=1
ENV PHP_OPCACHE_CLI=0
ENV PHP_OPCACHE_VALIDATE_TIMESTAMP=1
ENV PHP_OPCACHE_REVALIDATE_FREQ=30

# Install system dependencies
RUN apk add --no-cache \
    linux-headers \
    curl \
    zip \
    unzip \
    git \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    oniguruma-dev \
    icu-dev \
    libpq-dev

# Configure and install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) \
    pdo_mysql \
    pdo_pgsql \
    gd \
    bcmath \
    zip \
    opcache \
    intl \
    pcntl

# Create a non-root user to run the application
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN addgroup -g ${GROUP_ID} laravel && \
    adduser -u ${USER_ID} -G laravel -s /bin/sh -D laravel

# Set working directory and permissions
WORKDIR /var/www/html
RUN chown -R laravel:laravel /var/www/html

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY php-fpm.conf /usr/local/etc/php-fpm.d/www.conf

# Configure PHP
COPY php.ini /usr/local/etc/php/conf.d/custom.ini

# Switch to non-root user
USER laravel

# Final slim image without build dependencies
FROM base as slim
LABEL maintainer="Francisco Barento "
LABEL description="PHP 8.4 base image for Laravel applications with MySQL and PostgreSQL support"

EXPOSE 9000
CMD ["php-fpm"]