#!/bin/bash

colors[0]='\033[0;30m' # Black
colors[1]='\033[1;30m' # Dark Grey
colors[2]='\033[0;31m' # Red
colors[3]='\033[1;31m' # Light Red
colors[4]='\033[0;32m' # Green
colors[5]='\033[1;32m' # Light Green
colors[6]='\033[0;33m' # Yellow/Brown
colors[7]'\033[1;33m' # Yellow
colors[8]='\033[0;34m' # Blue
colors[9]='\033[1;34m' # Light Blue
colors[10]='\033[0;35m' # Purps
colors[11]='\033[1;35m' # Light Purple
colors[12]='\033[0;36m' # Cyan
colors[13]='\033[1;36m' # Light Cyan
colors[14]='\033[0;37m' # Light Grey
colors[15]='\033[1;37m' # White

len=${#colors[@]}
index=$(($RANDOM % $len))
echo ${colors[$(($RANDOM % $len))]}

echo -e "${colors[4]}Welcome to the create script. Let's get started creating your project!"

echo -n -e "Enter a PROJECT_ID (i.e. '${colors[13]}mydomain-com${colors[4]}'):\n${colors[2]}Rules: Enter only letters, numbers, or hyphens.\n${colors[6]}Recommendations: This should be the same as your domain with a hyphen or nothing instead of a dot.${colors[13]}\n"
read PROJECT_ID
echo -e "${colors[12]}Congrats on starting a new project!\nBy the way, '${colors[13]}$PROJECT_ID${colors[12]}' is an excellent name choice, I wish I had thought of it first!${colors[15]}\n"

creation_path="$(cd "$(dirname "$1")"; pwd -P)/$(basename "$1")gcp-sh/creation"

pid_path="$creation_path/project_id.txt"
echo $PROJECT_ID > $pid_path

bash $creation_path/clone-demo.sh

bash $creation_path/create-project.sh

bash $creation_path/get-account-id.sh

bash $creation_path/turn-on-billing.sh

bash $creation_path/start-project.sh

echo -e "${colors[2]}Fair Warning: ${colors[12]}These next steps may take a few minutes (est. 15 total) ... time to get some ${colors[11]}coffee${colors[12]} or play with the ${colors[11]}doge${colors[12]}."

bash $creation_path/create-auto.sh # Took about 10 minutes for me

bash $creation_path/apply-manifests.sh

bash $creation_path/get-pods.sh

bash $creation_path/get-frontend-ip.sh # Can take about 5 minutes

