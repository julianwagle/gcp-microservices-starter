#!/bin/bash

ACCOUNT_ID=$(gcloud alpha billing accounts list | awk '{print $1}')
ACCOUNT_ID=`echo $ACCOUNT_ID | sed 's/ACCOUNT_ID//'`
export ACCOUNT_ID=`echo $ACCOUNT_ID | sed 's/ *$//g'`
