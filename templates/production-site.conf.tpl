upstream site {
	$CHORSERV_IPS
}

ssl_session_cache shared:SSL:20m;
ssl_session_timeout 60m;

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
		proxy_pass http://site;
	}

	location ~ /.well-known {
		root /var/letsencrypt;
		allow all;
	}
}

server {
	listen 80 default_server;
	listen [::]:80 default_server;
	server_name _;

	add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
	return 301 https://$host$request_uri;
}
