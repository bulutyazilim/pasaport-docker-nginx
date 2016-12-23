#!/bin/sh

if [ -z "$PHP_PORT" ]; then PHP_PORT="9000"; fi
if [ -z "$KONG_PORT" ]; then KONG_PORT="8000"; fi
if [ -z "$KONG_ADMIN_PORT" ]; then KONG_ADMIN_PORT="8001"; fi
if [ -z "$PG_PORT" ]; then PG_PORT="5432"; fi

if [ -n "$KONG_HOST" ]; then export KONG_HOST=$(nslookup $KONG_HOST | awk '/^Address 1: / { print $3 }'); fi
if [ -n "$PG_HOST" ]; then export PG_HOST=$(nslookup $PG_HOST | awk '/^Address 1: / { print $3 }'); fi
if [ -n "$PHP_HOST" ]; then export PHP_HOST=$(nslookup $PHP_HOST | awk '/^Address 1: / { print $3 }'); fi
if [ -n "$KONG_ADMIN_HOST" ]; then export KONG_ADMIN_HOST=$(nslookup $KONG_ADMIN_HOST | awk '/^Address 1: / { print $3 }'); fi

dockerize \
-stdout /var/log/nginx/access.log \
-stderr /var/log/nginx/error.log \
-template /etc/nginx/conf.d/default.tmpl:/etc/nginx/conf.d/default.conf \
-template /etc/nginx/snippet/ssl.conf.tmpl:/etc/nginx/snippet/ssl.conf \
nginx
