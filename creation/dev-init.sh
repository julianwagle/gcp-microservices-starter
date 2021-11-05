#!/bin/bash

# ==========================================

export GOOGLE_APPLICATION_CREDENTIALS=$cert_file_path || exit 1

# ==========================================

minikube start --cpus=8 --memory 16000 --disk-size 64g || exit 1

# ==========================================

echo -e "${LCYAN}RUNNING SETUP-DEV.SH"
bash $development_path/setup-dev.sh || exit 1

echo -e "${LCYAN}RUNNING ENABLE-PROJECT.SH"
bash $utils_path/enable-project.sh || exit 1

echo -e "${LCYAN}RUNNING GET-NODES.SH"
bash $utils_path/get-nodes.sh || exit 1

# ==========================================

cd $PROJECT_ID || exit 1

echo -e "${LCYAN}RUNNING SKAFFOLD-DEV.SH"
bash $development_path/skaffold-dev.sh || exit 1

# ==========================================

echo -e "${LCYAN}RUNNING GET-PODS.SH"
bash $utils_path/get-pods.sh || exit 1

echo -e "${LCYAN}RUNNING MINICUDE SERVICE FRONT ..."
minikube service frontend-external || exit 1