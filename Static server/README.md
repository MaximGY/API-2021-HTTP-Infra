Static server configuration
===========================

This static server uses the default apache config of the `php5.6-apache` docker image.
Meaning all content is stored in `/var/www/html/` and VHosts configurations in `/etc/apache2/sites-enabled/` 

Scripts are provided to build and deploy the server.
The server is accessible on port 80.