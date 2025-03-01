#!/bin/sh
set -e

echo "Using NGINX_ROOT=${NGINX_ROOT}"
echo "Using PHP_FPM_HOST=${PHP_FPM_HOST:-app}"
echo "Using PHP_FPM_PORT=${PHP_FPM_PORT:-9000}"

exit 0