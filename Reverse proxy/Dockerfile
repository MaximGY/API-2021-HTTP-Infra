FROM php:7.2-apache

COPY conf/*             /etc/apache2/sites-available/
COPY conf/envsetup.sh   /usr/local/bin/

RUN a2enmod proxy proxy_http
RUN a2ensite 001-reverse-proxy.conf 000-sinkhole.conf
RUN a2dissite 000-default.conf

CMD /usr/local/bin/envsetup.sh