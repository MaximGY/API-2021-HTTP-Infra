#!/bin/bash

docker run -d --rm -e STATIC_ADDR=$1 -e DYNAMIC_ADDR=$2 -p 8080:80 --name reverse_proxy reverse_proxy