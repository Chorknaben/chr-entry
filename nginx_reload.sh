#!/bin/bash

echo "Generating config for production site"
export CHORSERV_IPS=$(dig +short chorserv-server-site-bundle | sed 's/\(.*\)/server \1:8000;/')
export CHORSERV_DOMAIN=chorknaben-biberach.de
envsubst < templates/production-site.conf.tpl > /etc/nginx/conf.d/production-site.conf

echo "Generating config for production backend"
export CHORSERV_IPS=$(dig +short chr-cms | sed 's/\(.*\)/server \1:8002;/')            
export CHORSERV_DOMAIN=backend.chorknaben-biberach.de
envsubst < templates/production-site.conf.tpl > /etc/nginx/conf.d/production-backend.conf

echo "Generating config for staging site"
export CHORSERV_IPS=$(dig +short chorserv-server-site-bundle-staging | sed 's/\(.*\)/server \1:8000;/')
export CHORSERV_DOMAIN=staging.chorknaben-biberach.de
envsubst < templates/production-site.conf.tpl > /etc/nginx/conf.d/staging-site.conf

echo "Generating config for staging backend"
export CHORSERV_IPS=$(dig +short chr-cms-staging | sed 's/\(.*\)/server \1:8002;/')            
export CHORSERV_DOMAIN=backend.staging.chorknaben-biberach.de
envsubst < templates/production-site.conf.tpl > /etc/nginx/conf.d/staging-backend.conf

if pgrep -x "nginx" > /dev/null
then
  /etc/init.d/nginx reload
fi
