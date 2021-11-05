#!/bin/bash


gcloud iam service-accounts create $SERVICE_ACCOUNT
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com" --role="roles/owner"

gcloud iam service-accounts keys create $cert_file_path --iam-account=$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com