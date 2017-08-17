#!/bin/sh

CMD=${0##*/}
echo "Are you SURE you want ${CMD}?"
read yn

case ${yn} in
    y|Y|yes|Yes|YES )
        echo "${CMD}"
        ;;
    * )
        echo "NO!"
        ;;
esac
