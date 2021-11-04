#!/bin/bash

pid_path="$(cd "$(dirname "$1")"; pwd -P)/$(basename "$1")gcp-sh/creation/project_id.txt"
PROJECT_ID=`cat $pid_path`

gcloud services enable container.googleapis.com --project ${PROJECT_ID}
gcloud services enable monitoring.googleapis.com \
    cloudtrace.googleapis.com \
    clouddebugger.googleapis.com \
    cloudprofiler.googleapis.com \
    --project ${PROJECT_ID}


