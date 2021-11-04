#!/bin/bash

pid_path="$(cd "$(dirname "$1")"; pwd -P)/$(basename "$1")gcp-sh/creation/project_id.txt"
PROJECT_ID=`cat $pid_path`

gcloud container clusters create-auto $PROJECT_ID \
    --project=${PROJECT_ID} --region=us-central1
