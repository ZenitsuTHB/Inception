FROM debian:bookworm

# Install dependencies
RUN apt update && apt upgrade -y && \
    apt install -y \
        php php-fpm php-mysql php-curl php-xml php-mbstring \
        php-zip php-gd php-cli curl less mariadb-client unzip && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Setup directories
RUN mkdir -p /run/php /var/www/html && \
    chown -R www-data:www-data /run/php /var/www/html && \
    chmod -R 755 /var/www/html

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY entry.sh /entry.sh
RUN chmod +x /entry.sh

WORKDIR /var/www/html
ENTRYPOINT ["/entry.sh"]
