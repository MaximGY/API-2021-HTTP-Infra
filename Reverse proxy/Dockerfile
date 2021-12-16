FROM php:7.2-apache

COPY conf/* /etc/apache2/sites-available/

RUN a2enmod proxy proxy_http
RUN a2ensite reverse-proxy.conf sinkhole.conf
RUN a2dissite 000-default.conf

RUN service apache2 restart