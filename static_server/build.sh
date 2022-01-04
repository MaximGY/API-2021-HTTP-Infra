#/bin/bash

DIR=$(dirname $BASH_SOURCE)
docker build -t static_httpd $DIR

