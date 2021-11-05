#!/bin/bash

# ==========================================

export sh_dir=$(dirname "${BASH_SOURCE[0]}")
export parent_path="$(cd "$(dirname "$1")"; pwd -P)/$(basename "$1")$sh_dir"
export grandparent_path="$(cd "$(dirname "$1")"; pwd -P)/" || exit 1
export development_path="$parent_path/development"
export utils_path="$parent_path/utils"

. $utils_path/colors.sh  || exit 1

# ==========================================

exported_pid=$($PROJECT_ID | wc -c)  || exit 1
if [ "$exported_pid" -eq "0" ]; then
    echo -n -e "Enter your PROJECT_ID:\n"
    read PROJECT_ID
    export PROJECT_ID
fi

# ==========================================

gcloud auth login 
export SERVICE_ACCOUNT="$PROJECT_ID-service-account" || exit 1
export certs_path="$grandparent_path/$PROJECT_ID/certs/" || exit 1
export cert_file_path="$certs_path/$SERVICE_ACCOUNT.json" || exit 1
export GOOGLE_APPLICATION_CREDENTIALS=$cert_file_path || exit 1

# ==========================================

bash $development_path/setup-dev.sh || exit 1

bash $utils_path/enable-project.sh || exit 1

bash $utils_path/get-nodes.sh || exit 1

# ==========================================

cd $PROJECT_ID || exit 1

bash $development_path/skaffold-run.sh || exit 1

# ==========================================

bash $utils_path/get-pods.sh || exit 1

minikube service frontend-external || exit 1
