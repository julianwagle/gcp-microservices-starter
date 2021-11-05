#!/bin/bash

NAME='julianwagle'
REPO='gcp-microservices-starter'
DATE=$(date +"%Y-%b-%d")

git init
git rm -r --cached .
git add .
git commit -m "'$DATE'"
git branch -M main
git remote add origin https://github.com/$NAME/$REPO.git
git push -u origin main -f
