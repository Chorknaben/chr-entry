upstream production-site {
	--UPSTREAM_IPS--
}

server {
	listen 443 ssl http2;
	listen [::]:443 ssl http2;
	server_name backend.staging.chorknaben-biberach.de;
	ssl_certificate certs/backend.staging.chorknaben-biberach.cert.pem;
	ssl_certificate_key certs/backend.staging.chorknaben-biberach.privkey.pem;
	ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
	ssl_ciphers HIGH:!aNULL:!MD5;

	add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;

	location / {
		proxy_pass https://production-site;
	}
}
