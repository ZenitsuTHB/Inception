FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    php-gd \
    php-curl \
    php-dom \
    php-mbstring \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Crear directorio antes de extraer WordPress
RUN mkdir -p /run/php && chown www-data:www-data /run/php

# Instalar WordPress
RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz -C /var/www/html --strip-components=1 \
    && rm latest.tar.gz \
    && chown -R www-data:www-data /var/www/html

COPY wp-config.php /var/www/html/wp-config.php

# Configurar PHP-FPM
RUN sed -i 's/;daemonize = yes/daemonize = no/' /etc/php/7.4/fpm/php-fpm.conf \
    && echo "listen = 9000" >> /etc/php/7.4/fpm/pool.d/www.conf \
    && echo "listen.owner = www-data" >> /etc/php/7.4/fpm/pool.d/www.conf \
    && echo "listen.group = www-data" >> /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]
