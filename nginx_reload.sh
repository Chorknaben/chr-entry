#!/bin/bash

function create {
	echo "Generating config for (docker-compose name $1, domain $2, internal port $3)"
	export CHORSERV_IPS=$(dig +short $1 | sed "s/\(.*\)/server \1:$3;/")
	export CHORSERV_DOMAIN=$2
	if [ ! -z "$CHORSERV_IPS" ]; then
		envsubst < /templates/production-site.conf.tpl > /etc/nginx/conf.d/$2.conf
		cat /etc/nginx/conf.d/$2.conf
	else
		echo "Will not create config for site; no upstreams"
	fi
}

function create-no-ssl {
	echo "NoSSL Config for (docker-compose name $1, domain $2, port $3)"
	export CHORSERV_IPS=$(dig +short $1 | sed "s/\(.*\)/server \1:$3;/")
	export CHORSERV_DOMAIN=$2
	if [ ! -z "$CHORSERV_IPS" ]; then
		envsubst < /templates/production-site-nossl.conf.tpl > /etc/nginx/conf.d/$2.conf
		cat /etc/nginx/conf.d/$2.conf
	else
		echo "Will not create config for site; no upstreams"
	fi
}

create chorserv-server-site-bundle chorknaben-biberach.de 8000
create chr-cms backend.chorknaben-biberach.de 8002

create chorserv-server-site-bundle-staging staging.chorknaben-biberach.de 8000
create chr-cms-staging backend.staging.chorknaben-biberach.de 8002

if pgrep -x "nginx" > /dev/null
then
  /etc/init.d/nginx reload
fi
