#!/bin/sh

docker-compose -f docker-compose.yaml -f extra/agent.yaml up -d --build agent
