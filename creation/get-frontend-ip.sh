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


function repeat () {
    color0=${colors[$(($RANDOM % $len))]}
    color1=${colors[$(($RANDOM % $len))]}
    echo -e "${color0}GCP is still provisioning the load balancer for you. ${color1}Please wait ..."
    sleep 5
    getFrontendIp
}

function printFrontendIp () {

    if [ "$1" == "Pending" ]; then
        repeat
    fi

    echo "Go To" $1
}

function getFrontendIp () {

    output=$(kubectl get service frontend-external | awk '{print $4}')
    output=`echo $output | sed 's/EXTERNAL-IP//'`
    output=`echo $output | sed 's/ *$//g'`
    printFrontendIp $output
    # printFrontendIp 'Pending' # For Testing

}


getFrontendIp