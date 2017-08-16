#!/bin/sh

DEST_DIR=/usr/bin/
PROFILE_DIR=/etc/profile.d/
MAIN_FILE=./suredown.py
ALIAS_FILE=./00-suredown-alias.sh

function change() {
    echo "cp $MAIN_FILE to $DEST_DIR"
    test -d $DEST_DIR || mkdir -p $DEST_DIR && cp $MAIN_FILE ${DEST_DIR}suredown

    echo "cp $ALIAS_FILE to $PROFILE_DIR"
    cp $ALIAS_FILE $PROFILE_DIR

    echo "change shutdown commands"
    echo $PROFILE_DIR${ALIAS_FILE##./}
    source "$PROFILE_DIR${ALIAS_FILE##./}"
}

clear
echo "** suredown **"
echo "Are you sure you want to change shutdown file? [Y/N]: "
read yn

case ${yn} in
    Y|YES|Yes|y|yes )
        change
        ;;
    * )
        echo No
        ;;
esac

