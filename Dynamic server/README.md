This folder handles the creation of a Docker container serving dynamic JSON payload on port 3000.
It will be used in conjunction with the Static server to serve a complete webpage integrating the both of them.

It will use a simple express.js applet, as this is the best thing to use for a proof of concept.
This applet will return randomly generated JSON using chance.js.
Sources under `src/` will me moved to `/opt/app/`.clear
