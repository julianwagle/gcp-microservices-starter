#!/bin/bash

pid_path="$(cd "$(dirname "$1")"; pwd -P)/$(basename "$1")gcp-sh/creation/project_id.txt"
PROJECT_ID=`cat $pid_path`


gcloud projects create $PROJECT_ID --set-as-default