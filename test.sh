#!/bin/bash

DIR=$(dirname $BASH_SOURCE)
STATIC_PORT=80
DYNAMIC_PORT=80

STATIC_ADDR=$(docker inspect static_httpd | jq '.[].NetworkSettings.IPAddress' | tr -d '"'):$STATIC_PORT
DYNAMIC_ADDR=$(docker inspect dynamic_express | jq '.[].NetworkSettings.IPAddress' | tr -d '"'):$DYNAMIC_PORT

$DIR/reverse_proxy/run.sh $STATIC_ADDR $DYNAMIC_ADDR

