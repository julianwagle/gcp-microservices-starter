#!/bin/bash


function repeat () {
    color0=${COLORS[$(($RANDOM % $COLORS_LEN))]}
    color1=${COLORS[$(($RANDOM % $COLORS_LEN))]}
    echo -e "${color0}GCP is still provisioning the load balancer for you. ${color1}Please wait ..."
    sleep 5
    getFrontendIp
}

function printFrontendIp () {

    if [ "$1" == "<pending>" ]; then
        repeat
    fi

    echo "Go To" $1
}

function getFrontendIp () {

    output=$(kubectl get service frontend-external | awk '{print $4}')
    output=`echo $output | sed 's/EXTERNAL-IP//'`
    output=`echo $output | sed 's/ *$//g'`
    echo $output
    printFrontendIp $output
    # printFrontendIp 'ending' # For Testing

}


getFrontendIp