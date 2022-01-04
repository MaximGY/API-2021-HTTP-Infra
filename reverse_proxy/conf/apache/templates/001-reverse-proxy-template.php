<VirtualHost *:80>
        ServerName http-infra.api
        ServerAdmin maxim.golay@ik.me

        # Reverse proxy to dynamic express server
        ProxyPass "/api/" "http://<?php print getenv('DYNAMIC_ADDR')?>/"
        ProxyPassReverse "/api/" "http://<?php print getenv('DYNAMIC_ADDR')?>/"

        # Reverse proxy to static server by default
        ProxyPass "/" "http://<?php print getenv('STATIC_ADDR')?>/"
        ProxyPassReverse "/" "http://<?php print getenv('STATIC_ADDR')?>/"

</VirtualHost>