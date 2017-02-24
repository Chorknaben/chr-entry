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
	ssl_session_cache shared:SSL:20m;
	ssl_session_timeout 180m;
	ssl_prefer_server_ciphers on;
	ssl_ciphers ECDH+AESGCM:ECDH+AES256:ECDH+AES128:DH+3DES:!ADH:!AECDH:!MD5;

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
