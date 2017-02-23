upstream $CHORSERV_DOMAIN {
	$CHORSERV_IPS
}

server {
	listen 80;
	listen [::]:80;
	server_name $CHORSERV_DOMAIN;

	add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
	location / {
		proxy_pass http://$CHORSERV_DOMAIN;
	}

	location ~ /.well-known {
		root /etc/letsencrypt/webroot;
		allow all;
        }
}
