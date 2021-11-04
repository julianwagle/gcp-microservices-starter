#!/bin/bash

pid_path="$(cd "$(dirname "$1")"; pwd -P)/$(basename "$1")gcp-sh/creation/project_id.txt"
PROJECT_ID=`cat $pid_path`

git clone https://github.com/GoogleCloudPlatform/microservices-demo.git $PROJECT_ID
cd $PROJECT_ID

