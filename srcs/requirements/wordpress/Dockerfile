FROM 	debian:bookworm

RUN		apt update && apt upgrade -y && apt install -y php-fpm \
		php-mysqli \
		curl
RUN 	mkdir -p /run/php /var/www/html && \
    	chown -R www-data:www-data /run/php /var/www/html && \
    	chmod -R 755 /var/www/html

COPY	www.conf /etc/php/7.4/fpm/pool.d/.
COPY	script.sh .
RUN		chmod +x script.sh

CMD		["./entry.sh"]

