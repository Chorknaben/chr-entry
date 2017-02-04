FROM nginx
MAINTAINER Georg Grab

RUN apt-get -y update
RUN apt-get -y install dnsutils

COPY templates /templates
COPY nginx_reload.sh /nginx_reload.sh
ENTRYPOINT /bin/bash /nginx_reload.sh && nginx -g 'daemon off;'
