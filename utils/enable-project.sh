#!/bin/bash

echo -e "Enabling services for $PROJECT_ID"
gcloud services enable container.googleapis.com --project ${PROJECT_ID} || exit 1
gcloud services enable monitoring.googleapis.com \
    cloudtrace.googleapis.com \
    clouddebugger.googleapis.com \
    cloudprofiler.googleapis.com \
    --project ${PROJECT_ID} || exit 1


