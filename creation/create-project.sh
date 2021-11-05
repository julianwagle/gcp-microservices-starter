#!/bin/bash


CREATION_RESP=$(gcloud projects create $PROJECT_ID --set-as-default 2>&1)
echo "$CREATION_RESP"
if [[ $CREATION_RESP == *"ERROR:"* ]]; then
  echo -e "${LRED}Please try again with another name."
  exit 1 
else
    echo "$PROJECT_ID should be successfully created now. You should see it in the list below:"
    gcloud projects list

    echo "Here are the project details for $PROJECT_ID:"
    gcloud projects describe $PROJECT_ID
fi


