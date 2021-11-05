#!/bin/bash

CLONE_RESP=$(git clone https://github.com/GoogleCloudPlatform/microservices-demo.git $PROJECT_ID 2>&1)
echo "$CLONE_RESP"
if [[ $CLONE_RESP == *"fatal:"* ]]; then
  echo -e "${LRED}Please either try again with another name or rm the dir with the name $PROJECT_ID."
  exit 1 
else
    cd $PROJECT_ID
fi

