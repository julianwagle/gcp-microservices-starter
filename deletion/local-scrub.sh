#!/bin/bash

docker system prune -af
docker volume prune -f
docker network prune -f
docker container ls
docker image ls
docker volume ls
docker network ls
