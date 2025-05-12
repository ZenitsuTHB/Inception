# Fichier : nginx/Dockerfile
# Nous choisissons Alpine pour sa légèreté
FROM alpine:3.18

# Installons NGINX et OpenSSL (pour TLS)
RUN apk update && apk add --no-cache nginx openssl

# Créons un dossier pour les certificats
RUN mkdir -p /etc/nginx/ssl

# Générons un certificat auto-signé (pour le test)
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/CN=localhost"

# Copions la configuration NGINX
COPY default.conf /etc/nginx/default.conf

# Exposons le port 443 (HTTPS)
EXPOSE 443

# Lançons NGINX au démarrage
CMD ["nginx", "-g", "daemon off;"]
