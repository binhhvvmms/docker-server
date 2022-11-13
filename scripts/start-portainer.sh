#!/bin/sh

docker-compose -f docker-compose.yaml -f docker-compose.portainer.yaml up -d --build portainer
