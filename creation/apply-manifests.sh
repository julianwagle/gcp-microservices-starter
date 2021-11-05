#!/bin/bash


kubectl apply -f ./$PROJECT_ID/release/kubernetes-manifests.yaml || exit 1
