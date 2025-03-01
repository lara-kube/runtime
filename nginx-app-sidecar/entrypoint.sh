#!/bin/sh
set -e

echo "Using NGINX_ROOT=${NGINX_ROOT}"
echo "Using PHP_FPM_HOST=${PHP_FPM_HOST}"
echo "Using PHP_FPM_PORT=${PHP_FPM_PORT}"

# Process the template
envsubst "\${NGINX_ROOT} \${PHP_FPM_HOST} \${PHP_FPM_PORT}" < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf

# Start Nginx
exec "$@"