#!/bin/bash

docker compose down
docker compose build
docker compose up -d --scale dynamic_content=2