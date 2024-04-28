#!/bin/bash


OPTIONS="--dry-run"
if [ -n "$1" ] && [ "$1" = "--install" ]; then
  OPTIONS=""
fi

rm nginx.conf

set -o allexport
source .env set
set +o allexport

if [ -n "$1" ] && [ "$1" = "--prod" ]; then
  envsubst < "nginx.conf.test.tpl" > "nginx.conf"
else
  envsubst < "nginx.conf.setup.tpl" > "nginx.conf"
fi



docker compose down
docker compose up -d

if [ -n "$1" ] && [ "$1" = "--prod" ]; then
  echo "running"
else
  docker compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ -d $SERVER_DOMAIN $OPTIONS
  rm nginx.conf
fi




