Static server configuration
===========================

This static server uses the default apache config of the `php5.6-apache` docker image.
Meaning all content is stored in `/var/www/html/` and VHosts configurations in `/etc/apache2/sites-enabled/` 

Scripts are provided to build and deploy the server.
The server is accessible on port 80.

This server fetches JSON payloads from the Dynamic Server on `/api/`, meaning Reverse Proxy HAS to be properly setup for this feature to work.
Dynamic payloads are handled using JS + jQuery, see `src/js/people.js/` for more information.