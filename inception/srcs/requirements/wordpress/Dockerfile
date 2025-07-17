FROM php:8.3-fpm-alpine

# Install system dependencies & PHP extensions required by WordPress
RUN apk add --no-cache \
    bash \
    curl \
    mariadb-client \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    libxpm-dev \
    freetype-dev \
    libzip-dev \
    libxml2-dev \
    oniguruma-dev \
    tzdata \
    && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
        --with-webp \
        --with-xpm \
    && docker-php-ext-install -j$(nproc) gd pdo pdo_mysql zip mysqli xml opcache

# Create a user for PID 1 compliance and security
RUN adduser -D -u 1000 www

WORKDIR /var/www/html

# Download and unpack WordPress
#RUN curl -O https://wordpress.org/latest.tar.gz \
#    && tar -xzf latest.tar.gz --strip-components=1 \
#    && rm latest.tar.gz

# Copy entrypoint script
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Fix permissions
RUN chown -R www:www /var/www/html

USER www

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]

