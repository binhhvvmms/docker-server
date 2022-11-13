#!/bin/sh

docker-compose -f docker-compose.yaml -f docker-compose.php7.yaml -f docker-compose.volume.yaml up -d --build php
