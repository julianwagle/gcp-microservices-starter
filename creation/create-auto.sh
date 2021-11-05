#!/bin/bash

gcloud container clusters create-auto $PROJECT_ID \
    --project=${PROJECT_ID} --region=us-central1 || exit 1
