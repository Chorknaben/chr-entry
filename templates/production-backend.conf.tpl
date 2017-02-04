upstream production-backend-site {
	$CHORSERV_PROD_BACKEND_IPS
}

server {
	listen 443 ssl http2;
	listen [::]:443 ssl http2;
	server_name backend.chorknaben-biberach.de;
	ssl_certificate certs/backend.chorknaben-biberach.de.cert.pem;
	ssl_certificate_key certs/backend.chorknaben-biberach.de.privkey.pem;
	ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
	ssl_ciphers HIGH:!aNULL:!MD5;
	client_max_body_size 2000M;

	add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;

	location / {
       		client_max_body_size 2000M;
		proxy_pass http://production-backend-site;
	}
}
