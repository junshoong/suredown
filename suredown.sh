#!/bin/sh

CMD=${0##*/}
ARGS=$*

clear
echo -n "Are you SURE you want ${CMD}? [y/n]: " 
read yn

case ${yn} in
    y|Y|yes|Yes|YES )
        echo "${CMD}"
        echo "args = ${ARGS}"
        eval "/usr/sbin/${CMD}_" $ARGS
        ;;
    * )
        echo "NO!"
        ;;
esac
