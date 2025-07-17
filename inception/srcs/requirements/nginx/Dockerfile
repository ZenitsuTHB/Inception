FROM alpine:3.20

RUN apk add --no-cache nginx openssl

# Create directories for TLS and runtime
RUN mkdir -p /etc/nginx/ssl /run/nginx /var/www/html

# Generate self-signed certificate (TLSv1.2+)
RUN openssl req -x509 -nodes -days 365 \
  -subj "/C=FR/ST=Paris/L=Paris/O=42/CN=avolcy.42.fr" \
  -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/nginx.key \
  -out /etc/nginx/ssl/nginx.crt

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

