#!/bin/sh

SCRIPT_DIR=/root/suredown/userscript
NONE='\033[00m'
BOLD='\033[1m'

for SCRIPT in ${SCRIPT_DIR}/*
do
    if [ -f $SCRIPT -a -x $SCRIPT ]; then
        echo ${BOLD}${SCRIPT##*/}${NONE}
        $SCRIPT
    fi
done
