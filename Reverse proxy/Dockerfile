FROM php:7.2-apache

COPY conf/* /etc/apache2/sites-available/

RUN a2enmod proxy proxy_http
RUN a2ensite 001-reverse-proxy.conf 000-sinkhole.conf
RUN a2dissite 000-default.conf