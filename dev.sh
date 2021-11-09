#!/bin/bash


export sh_dir=$(dirname "${BASH_SOURCE[0]}")
len=$(echo ${#sh_dir})
if [ "$len" -eq "1" ]; then
    echo -n -e "
    From Whence Thou Runneth Thine Commands Is Ghastly And
    Absolutely Out Of Keeping With All That Is Just And True, 
    Thou Dwelleth Too Close To Me! ... 
    Depart Backwards From Me At Least One Directory, At Once! 
    Let It Be Done As I Have Spoken It, According To My Words. 
    Then, And Only Then, Thou May Tryeth Once More, If Thou So Chooseth!\n
    "
fi

export parent_path="$(cd "$(dirname "$1")"; pwd -P)/$(basename "$1")$sh_dir"
export grandparent_path="$(cd "$(dirname "$1")"; pwd -P)/" || exit 1
export creation_path="$parent_path/creation" || exit 1
export development_path="$parent_path/development"
export utils_path="$parent_path/utils"

. $utils_path/colors.sh  || exit 1

echo -e "${LCYAN}RUNNING DEV.SH"

echo -e "${LPURPLE}===================================================================================="

echo -e "${LCYAN}GETTING PROJECT_ID"
PROJECT_ID="$(sed '1q;d' $parent_path/.env)"
PROJECT_ID=`echo $PROJECT_ID | sed 's/PROJECT_ID=//'`
export PROJECT_ID=`echo $PROJECT_ID | sed 's/ *$//g'`
len=$(echo ${#PROJECT_ID})
if [ "$len" -eq "0" ]; then
    echo -n -e "Enter your PROJECT_ID:\n"
    read PROJECT_ID
    export PROJECT_ID
fi

echo -e "${LPURPLE}===================================================================================="

ACCOUNT_EMAIL="$(sed '2q;d' $parent_path/.env)"
ACCOUNT_EMAIL=`echo $ACCOUNT_EMAIL | sed 's/ACCOUNT_EMAIL=//'`
ACCOUNT_EMAIL=`echo $ACCOUNT_EMAIL | sed 's/ *$//g'`
CURRENT_EMAIL="$(gcloud config get-value account)"
if [ "$ACCOUNT_EMAIL" == "$CURRENT_EMAIL" ]; then
    echo "LOGGED IN!"
else
    echo -e "${LCYAN}RUNNING GCLOUD AUTH LOGIN"
    gcloud auth login --brief
fi

echo -e "${LCYAN}RUNNING INSTALL KUBECTL"
gcloud components install kubectl

echo -e "${LCYAN}ENABLE-PROJECT.SH.SH"
bash $utils_path/enable-project.sh || exit 1

echo -e "${LPURPLE}===================================================================================="

echo -e "${LCYAN}EXPORTING CREDENTIALS"
export SERVICE_ACCOUNT="$PROJECT_ID-service-account" || exit 1
export certs_path="$grandparent_path/$PROJECT_ID/certs/" || exit 1
export cert_file_path="$certs_path/$SERVICE_ACCOUNT.json" || exit 1
export GOOGLE_APPLICATION_CREDENTIALS=$cert_file_path || exit 1

echo -e "${LPURPLE}===================================================================================="

echo -e "${LCYAN}STARTING MINICUBE"
minikube start --cpus=8 --memory 16000 --disk-size 64g || exit 1


echo -e "${LPURPLE}===================================================================================="

echo -e "${LCYAN}APPLY-MANIFESTS.SH"
bash $creation_path/apply-manifests.sh || exit 1

echo -e "${LCYAN}GET-PODS.SH"
bash $utils_path/get-pods.sh || exit 1


echo -e "${LPURPLE}===================================================================================="

echo -e "${LCYAN}RUNNING SETUP-DEV.SH"
bash $development_path/setup-dev.sh || exit 1

echo -e "${LCYAN}RUNNING GET-NODES.SH"
bash $utils_path/get-nodes.sh || exit 1

echo -e "${LPURPLE}===================================================================================="

echo -e "${LCYAN}HEADING INTO PROJECT ROOT"
cd $PROJECT_ID || exit 1

echo -e "${LCYAN}RUNNING SKAFFOLD RUN"
skaffold run --default-repo=gcr.io/$PROJECT_ID || exit 1

echo -e "${LPURPLE}===================================================================================="

echo -e "${LCYAN}RUNNING GET-PODS.SH"
bash $utils_path/get-pods.sh || exit 1

echo -e "${LCYAN}RUNNING MINICUDE SERVICE FRONT ..."
minikube service frontend-external || exit 1
