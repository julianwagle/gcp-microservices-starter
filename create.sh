#!/bin/bash

# pre-reqs:
# =========
# Docker, Docker Desktop, # https://docs.docker.com/desktop/mac/install/
#   + Kubernetes # https://birthday.play-with-docker.com/kubernetes-docker-desktop/
# minicude # https://minikube.sigs.k8s.io/docs/start/
# Google Cloud account # https://cloud.google.com/
# gcloud cli # https://cloud.google.com/sdk/docs/install
# scaffold # https://skaffold.dev/docs/install/

export sh_dir=$(dirname "${BASH_SOURCE[0]}") || exit 1
len=$(echo ${#sh_dir})
if [ "$len" -eq "1" ]; then
    echo -n -e "
    From Whence Thou Runneth Thine Commands Is Ghastly And
    Absolutely Out Of Keeping With All That Is Just And True, 
    Thou Dwelleth Too Close To Me! ... 
    Depart Backwards From Me At Least One Directory, At Once! 
    Let It Be Done As I Have Spoken It, According To My Words. 
    And Then Thou May Treth Once More, If Thou So Chooseth!\n
    "
fi

export parent_path="$(cd "$(dirname "$1")"; pwd -P)/$(basename "$1")$sh_dir" || exit 1
export grandparent_path="$(cd "$(dirname "$1")"; pwd -P)/" || exit 1
export creation_path="$parent_path/creation" || exit 1
export development_path="$parent_path/development" || exit 1
export utils_path="$parent_path/utils" || exit 1

. $utils_path/colors.sh  || exit 1

echo -e "${LCYAN}RUNNING CREATE.SH"

echo -e "${LPURPLE}===================================================================================="

echo -e "${GREEN}Welcome to the create script. Let's get started creating your project!"
echo -n -e "Enter a PROJECT_ID (i.e. '${LCYAN}mydomain-com${GREEN}'):\n
${LRED}Rules: Enter only letters, numbers, or hyphens.\n
${LBROWN}Recommendations: This should be the same as your domain with a hyphen or nothing instead of a dot.${LCYAN}\n"

read PROJECT_ID || exit 1
export PROJECT_ID || exit 1

echo -e "${CYAN}Congrats on starting a new project!\n
By the way, '${LCYAN}$PROJECT_ID${CYAN}' is an excellent name choice, 
I wish I had thought of it first!${WHITE}\n"

echo -e "${LPURPLE}===================================================================================="

echo -e "${LCYAN}RUNNING GCLOUD AUTH LOGIN"
gcloud auth login 

echo -e "${LCYAN}CREATE-PROJECT.SH"
bash $creation_path/create-project.sh || exit 1

echo -e "${LCYAN}CLONE-DEMO.SH"
bash $creation_path/clone-demo.sh || exit 1

echo -e "${LCYAN}GET-ACCOUNT-ID.SH"
. $utils_path/get-account-id.sh

echo -e "${LCYAN}TURN-ON-BILLING.SH"
bash $creation_path/turn-on-billing.sh || exit 1

echo -e "${LCYAN}ENABLE-PROJECT.SH.SH"
bash $utils_path/enable-project.sh || exit 1

echo -e "${LRED}Fair Warning: ${CYAN}These next steps may take a few minutes (est. 20 total) ... 
time to get some ${LPURPLE}coffee${CYAN} or play with the ${LPURPLE}doge${CYAN}."

echo -e "${LCYAN}CREATE-AUTO.SH"
bash $creation_path/create-auto.sh || exit 1 # Took about 10 minutes for me

echo -e "${LPURPLE}===================================================================================="

echo -e "${LCYAN}CREATING CREDENTIALS"
export SERVICE_ACCOUNT="$PROJECT_ID-service-account" || exit 1
export certs_path="$grandparent_path/$PROJECT_ID/certs/" || exit 1
export cert_file_path="$certs_path/$SERVICE_ACCOUNT.json" || exit 1
mkdir $certs_path || exit 1
touch $certs_path/$SERVICE_ACCOUNT.json || exit 1

echo -e "${LCYAN}CREATE-SERVICE-ACCOUNT.SH"
bash $creation_path/create-service-account.sh || exit 1

echo -e "${LPURPLE}===================================================================================="

echo -e "${LCYAN}APPLY-MANIFESTS.SH"
bash $creation_path/apply-manifests.sh || exit 1

echo -e "${LCYAN}GET-PODS.SH"
bash $utils_path/get-pods.sh || exit 1

echo -e "${LCYAN}GET-FRONTEND-IP.SH"
bash $utils_path/get-frontend-ip.sh || exit 1 # Can take about 5 minutes

