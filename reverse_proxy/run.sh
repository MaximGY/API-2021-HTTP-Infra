#/bin/bash

docker run -d --rm -e STATIC_ADDR=172.17.0.2:80 -e DYNAMIC_ADDR=172.17.0.3:80 -p 8080:80 --name reverse_proxy reverse_proxy