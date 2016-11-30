#!/bin/sh

if [ -z "$PHP_PORT" ]; then PHP_PORT="9000"; fi
if [ -z "$KONG_PORT" ]; then KONG_PORT="8000"; fi
if [ -z "$KONG_ADMIN_PORT" ]; then KONG_ADMIN_PORT="8001"; fi

dockerize \
-stdout /var/log/nginx/access.log \
-stderr /var/log/nginx/error.log \
-wait tcp://${KONG_HOST}:${KONG_PORT} \
-wait tcp://${PHP_HOST}:${PHP_PORT} \
-template /etc/nginx/conf.d/default.tmpl:/etc/nginx/conf.d/default.conf \
nginx
