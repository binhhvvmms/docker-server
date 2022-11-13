#!/bin/sh

docker-compose -f docker-compose.yaml -f docker-compose.volume.yaml up -d --build
