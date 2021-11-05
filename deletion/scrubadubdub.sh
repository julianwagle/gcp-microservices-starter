#!/bin/bash

export sh_dir=$(dirname "${BASH_SOURCE[0]}")
export parent_path="$(cd "$(dirname "$1")"; pwd -P)/$(basename "$1")$sh_dir"
export development_path="$parent_path/development"
export utils_path="$parent_path/utils"

echo -e "The first time you run this it may take quite while."

exported_pid=$($PROJECT_ID | wc -c)

if [ "$exported_pid" -eq "0" ]; then
    echo -n -e "Enter your PROJECT_ID:\n"
    read PROJECT_ID
    export PROJECT_ID
fi

PROJECT_ID_LOCAL="$PROJECT_ID-local"

docker system prune -af
docker volume prune -f
docker network prune -f
docker container ls
docker image ls
docker volume ls
docker network ls


gcloud container clusters delete ${PROJECT_ID} \
    --project=${PROJECT_ID} --region=us-central1

gcloud container clusters delete ${PROJECT_ID_LOCAL} \
    --project=${PROJECT_ID_LOCAL} --zone=us-west1-a