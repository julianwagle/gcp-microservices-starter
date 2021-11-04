#!/bin/bash


pid_path="$(cd "$(dirname "$1")"; pwd -P)/$(basename "$1")gcp-sh/creation/project_id.txt"
PROJECT_ID=`cat $pid_path`

aid_path="$(cd "$(dirname "$1")"; pwd -P)/$(basename "$1")gcp-sh/creation/account_id.txt"
ACCOUNT_ID=`cat $aid_path`

gcloud alpha billing accounts projects link $PROJECT_ID --billing-account=$ACCOUNT_ID
