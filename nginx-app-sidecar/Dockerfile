FROM nginx:alpine

ENV NGINX_ROOT=/var/www/html/public

COPY nginx.conf.template /etc/nginx/templates/default.conf.template
COPY entrypoint.sh /usr/local/bin/custom-entrypoint.sh

RUN chmod +x /usr/local/bin/custom-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/custom-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
