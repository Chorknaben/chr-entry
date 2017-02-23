upstream $CHORSERV_DOMAIN {
	$CHORSERV_IPS
}

server {
	listen 443 ssl http2;
	listen [::]:443 ssl http2;
	server_name $CHORSERV_DOMAIN;
	ssl_certificate /etc/letsencrypt/live/$CHORSERV_DOMAIN/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/$CHORSERV_DOMAIN/privkey.pem;
	ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
	ssl_ciphers HIGH:!aNULL:!MD5;

	add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;

	location / {
		proxy_pass http://$CHORSERV_DOMAIN;
	}

	location ~ /.well-known {
		root /etc/letsencrypt/webroot;
		allow all;
	}
}

server {
	listen 80;
	listen [::]:80;
	server_name $CHORSERV_DOMAIN;

	add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
	return 301 https://$host$request_uri;
}
