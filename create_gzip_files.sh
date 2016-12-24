#!/bin/sh

while [ ! -d "$ROOT_DIR" ]
do
  sleep 2
done
for file in `find ${ROOT_DIR} -name \*.css -o -name \*.js -o -name \*.html`
    do gzip	-9	-f	-c $file > $file.gz;
done
