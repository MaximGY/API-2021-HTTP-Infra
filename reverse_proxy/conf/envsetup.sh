#!/bin/bash

echo "Now creating apache conf files..."

echo "Static server at: $STATIC_ADDR"
echo "Dynamic server at: $DYNAMIC_ADDR"

# Creates apache conf files from a php template, injecting env vars
php /etc/apache2/templates/001-reverse-proxy-template.php > /etc/apache2/sites-available/001-reverse-proxy.conf
a2ensite 001-reverse-proxy.conf 

echo "Done! Starting Apache now..."

# Run apache2-foreground, which is standard on PHP apache images
exec apache2-foreground