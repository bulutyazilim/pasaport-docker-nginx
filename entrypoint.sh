#!/bin/sh

if [ -z "$PHP_PORT" ]; then PHP_PORT="9000"; fi
if [ -z "$KONG_PORT" ]; then KONG_PORT="8000"; fi
if [ -z "$KONG_ADMIN_PORT" ]; then KONG_ADMIN_PORT="8001"; fi
if [ -z "$PG_PORT" ]; then PG_PORT="5432"; fi

export PG_HOST=$(nslookup $PG_HOST | awk '/^Address 1: / { print $3 }')
export KONG_HOST=$(nslookup $KONG_HOST | awk '/^Address 1: / { print $3 }')
export PHP_HOST=$(nslookup $PHP_HOST | awk '/^Address 1: / { print $3 }')

dockerize \
-stdout /var/log/nginx/access.log \
-stderr /var/log/nginx/error.log \
-wait tcp://${KONG_HOST}:${KONG_PORT} \
-wait tcp://${PHP_HOST}:${PHP_PORT} \
-wait tcp://${PG_HOST}:${PG_PORT} \
-template /etc/nginx/conf.d/default.tmpl:/etc/nginx/conf.d/default.conf \
nginx
