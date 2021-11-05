#!/bin/bash

export BLACK='\033[0;30m' # Black
export DGREY='\033[1;30m' # Dark Grey
export RED='\033[0;31m' # Red
export LRED='\033[1;31m' # Light Red
export GREEN='\033[0;32m' # Green
export LGREEN='\033[1;32m' # Light Green
export LBROWN='\033[0;33m' # Yellow/Brown
export YELLOW='\033[1;33m' # Yellow
export BLUE='\033[0;34m' # Blue
export LBLUE='\033[1;34m' # Light Blue
export PURPLE='\033[0;35m' # Purps
export LPURPLE='\033[1;35m' # Light Purple
export CYAN='\033[0;36m' # Cyan
export LCYAN='\033[1;36m' # Light Cyan
export LGREY='\033[0;37m' # Light Grey
export WHITE='\033[1;37m' # White

export COLORS=(
    '\033[0;30m' # Black 0
    '\033[1;30m' # Dark Grey 1
    '\033[0;31m' # Red 2
    '\033[1;31m' # Light Red 3
    '\033[0;32m' # Green 4
    '\033[1;32m' # Light Green 5
    '\033[0;33m' # Yellow/Brown 6
    '\033[1;33m' # Yellow 7
    '\033[0;34m' # Blue 8
    '\033[1;34m' # Light Blue 9
    '\033[0;35m' # Purps 10
    '\033[1;35m' # Light Purple 11
    '\033[0;36m' # Cyan 12
    '\033[1;36m' # Light Cyan 13
    '\033[0;37m' # Light Grey 14
    '\033[1;37m' # White 15
) || exit 1

export COLORS_LEN=${#COLORS[@]} || exit 1
