#!/bin/sh

docker network create webpress
docker volume create kongdb
docker volume create dbdata
