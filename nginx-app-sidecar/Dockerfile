FROM nginx:alpine

ENV NGINX_ROOT=/var/www/html/public

COPY nginx.conf.template /etc/nginx/templates/default.conf.template
COPY entrypoint.sh /docker-entrypoint.d/40-set-nginx-root.sh

RUN chmod +x /docker-entrypoint.d/40-set-nginx-root.sh

EXPOSE 80
