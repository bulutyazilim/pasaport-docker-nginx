#!/bin/sh

# default values
if [ -z "$PHP_HOST" ]; then PHP_HOST="127.0.0.1"; fi
if [ -z "$PHP_PORT" ]; then PHP_HOST="9000"; fi

if [ -z "$KONG_HOST" ]; then KONG_HOST="127.0.0.1"; fi
if [ -z "$KONG_PORT" ]; then KONG_PORT="8000"; fi

if [ -z "$KONG_ADMIN_HOST" ]; then KONG_ADMIN_HOST=$KONG_HOST; fi
if [ -z "$KONG_ADMIN_PORT" ]; then KONG_ADMIN_PORT="8001"; fi


sed -i -- "s/PHP_HOST/${PHP_HOST}/g; s/PHP_PORT/${PHP_PORT}/g" /etc/nginx/conf.d/default.conf
sed -i -- "s/KONG_HOST/${KONG_HOST}/g; s/KONG_PORT/${KONG_PORT}/g" /etc/nginx/conf.d/default.conf
sed -i -- "s/KONG_ADMIN_HOST/${KONG_ADMIN_HOST}/g; s/KONG_ADMIN_PORT/${KONG_ADMIN_PORT}/g" /etc/nginx/conf.d/default.conf
sed -i -- "s/#ENV_${ENV} //g" /etc/nginx/conf.d/default.conf

exec "$@"
