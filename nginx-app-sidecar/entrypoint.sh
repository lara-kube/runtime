#!/bin/sh
set -e

echo "Using NGINX_ROOT=${NGINX_ROOT}"
echo "Using PHP_FPM_HOST=${PHP_FPM_HOST:-app}"
echo "Using PHP_FPM_PORT=${PHP_FPM_PORT:-9000}"

# Process the template - using double quotes to allow variable expansion
envsubst "\${NGINX_ROOT} \${PHP_FPM_HOST} \${PHP_FPM_PORT}" < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf

# Start Nginx
exec "$@"