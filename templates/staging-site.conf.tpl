upstream production-site {
	--UPSTREAM_IPS--
}

server {
	listen 443 ssl http2;
	listen [::]:443 ssl http2;
	server_name staging.chorknaben-biberach.de;
	ssl_certificate certs/staging.chorknaben-biberach.de.cert.pem;
	ssl_certificate_key certs/staging.chorknaben-biberach.de.privkey.pem;
	ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
	ssl_ciphers HIGH:!aNULL:!MD5;

	add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;

	location / {
		proxy_pass https://production-site;
	}
}

server {
	listen 80 default_server;
	listen [::]:80 default_server;
	server_name _;

	add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
	return 301 https://$host$request_uri;
}
