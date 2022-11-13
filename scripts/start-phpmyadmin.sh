#!/bin/sh

docker-compose -f docker-compose.yaml -f docker-compose.phpmyadmin.yaml up -d --build phpmyadmin
