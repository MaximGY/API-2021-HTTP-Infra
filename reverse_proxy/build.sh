#/bin/bash

DIR=$(dirname $BASH_SOURCE)
docker build -t reverse_proxy $DIR