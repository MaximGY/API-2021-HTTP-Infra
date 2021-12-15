FROM php:5.6-apache
COPY reverse-proxy.conf /etc/apache2/sites-available/

RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2ensite reverse-proxy.conf
RUN a2dissite 000-default.conf

RUN service apache2 restart