#!/bin/bash

ACCOUNT_ID=$(gcloud alpha billing accounts list | awk '{print $1}')
ACCOUNT_ID=`echo $ACCOUNT_ID | sed 's/ACCOUNT_ID//'`
ACCOUNT_ID=`echo $ACCOUNT_ID | sed 's/ *$//g'`

creation_path="$(cd "$(dirname "$1")"; pwd -P)/$(basename "$1")gcp-sh/creation"

aid_path="$creation_path/account_id.txt"
echo $ACCOUNT_ID > $aid_path