#!/bin/bash

# Create a GKE cluster and make sure kubectl is pointing to the cluster.
gcloud services enable container.googleapis.com  || exit 1 # local dev docs have wout PID

# Enable GCR on your GCP and configure the Docker CLI to authenticate to GCR:
gcloud services enable containerregistry.googleapis.com || exit 1

gcloud auth configure-docker -q || exit 1

