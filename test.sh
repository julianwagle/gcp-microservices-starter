
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
