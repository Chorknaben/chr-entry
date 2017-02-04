#!/bin/bash
export CHORSERV_PROD_IPS=$(dig +short chorserv-server-site-bundle | sed 's/\(.*\)/server \1:8000;/')
export CHORSERV_PROD_BACKEND_IPS=$(dig +short chr-cms | sed 's/\(.*\)/server \1:8002;/')            

envsubst < templates/production-site.conf.tpl > /etc/nginx/conf.d/production-site.conf
envsubst < templates/production-backend.conf.tpl > /etc/nginx/conf.d/production-backend.conf

if pgrep -x "nginx" > /dev/null
then
  /etc/init.d/nginx reload
fi
