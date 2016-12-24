#!/bin/sh

if [ -z "$PHP_PORT" ]; then PHP_PORT="9000"; fi
if [ -n "$PHP_HOST" ]; then export PHP_HOST=$(nslookup $PHP_HOST | awk '/^Address 1: / { print $3 }'); fi

sh ./create_gzip_files.sh >/dev/null 2>&1

dockerize \
-wait tcp://${PHP_HOST}:${PHP_PORT} \
-template /etc/nginx/conf.d/default.tmpl:/etc/nginx/conf.d/default.conf \
-template /etc/nginx/snippet/ssl.conf.tmpl:/etc/nginx/snippet/ssl.conf \
nginx
