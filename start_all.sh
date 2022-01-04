#!/bin/bash

DIR=$(dirname $BASH_SOURCE)
STATIC_PORT=80
DYNAMIC_PORT=80

echo "Building images..."

$DIR/static_server/build.sh
$DIR/dynamic_server/build.sh
$DIR/reverse_proxy/build.sh

echo "Images built."
echo "Starting content providers..."

$DIR/static_server/run.sh
$DIR/dynamic_server/run.sh

echo "Content providers started."
echo "Starting reverse proxy..."

STATIC_ADDR=$(docker inspect static_httpd | jq '.[].NetworkSettings.IPAddress' | tr -d '"'):$STATIC_PORT
DYNAMIC_ADDR=$(docker inspect dynamic_express | jq '.[].NetworkSettings.IPAddress' | tr -d '"'):$DYNAMIC_PORT

$DIR/reverse_proxy/run.sh $STATIC_ADDR $DYNAMIC_ADDR

echo "Reverse proxy started."

