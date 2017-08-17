#!/bin/sh

DEST_DIR=/usr/sbin/
BAK_DIR=${DEST_DIR}old_suredown/
SOURCE_FILE=./suredown.sh

function setup() {
    echo "1. setup"
    echo "cp $SOURCE_FILE to $DEST_DIR..."
    test -d $DEST_DIR || mkdir -p $DEST_DIR && cp $SOURCE_FILE ${DEST_DIR}suredown

    echo "setup surdown files..."
    test -d $BAK_DIR || mkdir -p $BAK_DIR
    mv ${DEST_DIR}shutdown $BAK_DIR
    mv ${DEST_DIR}reboot $BAK_DIR
    mv ${DEST_DIR}halt $BAK_DIR
    mv ${DEST_DIR}poweroff $BAK_DIR
    ln -s ${DEST_DIR}suredown ${DEST_DIR}shutdown
    ln -s ${DEST_DIR}suredown ${DEST_DIR}reboot
    ln -s ${DEST_DIR}suredown ${DEST_DIR}halt
    ln -s ${DEST_DIR}suredown ${DEST_DIR}poweroff

    echo "Done!"

    # echo "cp $ALIAS_FILE to $PROFILE_DIR"
    # cp $ALIAS_FILE $PROFILE_DIR

    # echo "change shutdown commands"
    # echo $PROFILE_DIR${ALIAS_FILE##./}
    # source "$PROFILE_DIR${ALIAS_FILE##./}"
}
function remove(){
    echo "2. remove"
    if [ -h ${DEST_DIR}shutdown ]; then
        mv -f ${BAK_DIR}shutdown ${DEST_DIR}shutdown
    fi
    if [ -h ${DEST_DIR}reboot ]; then
        mv -f ${BAK_DIR}reboot ${DEST_DIR}reboot
    fi
    if [ -h ${DEST_DIR}halt ]; then
        mv -f ${BAK_DIR}halt ${DEST_DIR}halt
    fi
    if [ -h ${DEST_DIR}poweroff ]; then
        mv -f ${BAK_DIR}poweroff ${DEST_DIR}poweroff
    fi
    rmdir $BAK_DIR 
    rm ${DEST_DIR}suredown
}

clear
echo "** suredown **"
# echo "Are you sure you want to change shutdown file? [Y/N]: "
echo "1. setup"
echo "2. remove"
echo "3. cancel"
read num

case ${num} in
    1 )
        setup
        ;;
    2 )
        remove
        ;;
    * )
        echo "3. cancel"
        ;;
esac

