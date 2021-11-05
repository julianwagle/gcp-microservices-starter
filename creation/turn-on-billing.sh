#!/bin/bash

echo $PROJECT_ID
echo $ACCOUNT_ID
gcloud alpha billing accounts projects link $PROJECT_ID --billing-account=$ACCOUNT_ID || exit 1
