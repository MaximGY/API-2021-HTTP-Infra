FROM php:7.2-apache

COPY conf/apache/sites/*        /etc/apache2/sites-available/
COPY conf/apache/templates/*    /etc/apache2/templates/
COPY conf/envsetup.sh           /usr/local/bin/

RUN a2enmod proxy proxy_http
RUN a2ensite 000-sinkhole.conf
RUN a2dissite 000-default.conf

CMD /usr/local/bin/envsetup.sh