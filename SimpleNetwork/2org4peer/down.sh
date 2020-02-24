#!/bin/bash

docker-compose down --volumes --remove-orphans
docker ps -aq | xargs docker rm
docker images | grep dev-p | awk '{print $3}' | xargs docker rmi -f
