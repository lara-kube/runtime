FROM nginx:alpine

ENV NGINX_ROOT=/var/www/html/public
ENV PHP_FPM_HOST=app
ENV PHP_FPM_PORT=9000

COPY nginx.conf.template /etc/nginx/templates/default.conf.template
COPY entrypoint.sh /usr/local/bin/custom-entrypoint.sh

RUN chmod +x /usr/local/bin/custom-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/custom-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
