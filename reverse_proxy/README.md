This folder handles the creation of a reverse proxy in the form of a docker container. It will "hide away" both Static and Dynamic server under the same server and be the new entrypoint for the application.

The reverse proxy listens exclusively to request for host `http-infra.api`. It redirects all requests to `/api/` to the Dynamic server and all other to the Static server.
The container's inner port is listening on port 80 and is mapped to its host on port 8080.

The default configuration `000-default.conf` is disabled and is replaced by `reverse-proxy.conf`, which is moved into the container at build time. Necessary apache setup, such as module and site enabling is done at build time in Dockerfile.

Default startup script is changed to `envsetup.h`, located in `/usr/local/bin/`. It will call apache2-foreground when finished, booting up Apache as per usual.
Its goal is to setup environnement variables to know what IP other content providers have.

N.B: For now, IP mapping between the containers is hardcoded. Use `docker inspect name` to read the properties of the run containers and find their IP.

