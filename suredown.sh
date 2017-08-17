#!/bin/sh

SCRIPT_DIR=/etc/suredown.d
NONE="\033[00m"
BOLD="\033[1m"
GREEN="\033[01;32m"

CMD=${0##*/}
ARGS=$*

clear

for SCRIPT in ${SCRIPT_DIR}/*
do
    if [ -f $SCRIPT -a -x $SCRIPT ]; then
        echo -e "${GREEN}${BOLD}${SCRIPT##*/}${NONE}"
        $SCRIPT
    fi
done

echo -n "Are you SURE you want ${CMD}? [y/n]: " 
read yn

case ${yn} in
    y|Y|yes|Yes|YES )
        echo "${CMD}"
        echo "args = ${ARGS}"
        eval "${CMD}_" $ARGS
        ;;
    * )
        echo "NO!"
        ;;
esac


