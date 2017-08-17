#!/bin/sh

tmp=`which shutdown`
DEST_DIR=${tmp%/*}
BAK_DIR=${DEST_DIR}/old_suredown
SOURCE_FILE=./suredown.sh

function setup() {
    echo "1. setup"
    echo "cp $SOURCE_FILE to $DEST_DIR..."
    test -d $DEST_DIR || mkdir -p $DEST_DIR && cp $SOURCE_FILE ${DEST_DIR}/suredown

    echo "setup surdown files..."
    mv ${DEST_DIR}/shutdown ${DEST_DIR}/shutdown_ 
    mv ${DEST_DIR}/reboot ${DEST_DIR}/reboot_
    mv ${DEST_DIR}/halt ${DEST_DIR}/halt_
    mv ${DEST_DIR}/poweroff ${DEST_DIR}/poweroff_
    ln -s ${DEST_DIR}/suredown ${DEST_DIR}/shutdown
    ln -s ${DEST_DIR}/suredown ${DEST_DIR}/reboot
    ln -s ${DEST_DIR}/suredown ${DEST_DIR}/halt
    ln -s ${DEST_DIR}/suredown ${DEST_DIR}/poweroff

    echo "setup user script..."
    cp -r ./suredown.d /etc

    echo "Done!"
}

function remove(){
    echo "2. remove"
    if [ -h ${DEST_DIR}/shutdown ]; then
        mv ${DEST_DIR}/shutdown_ ${DEST_DIR}/shutdown
    fi
    if [ -h ${DEST_DIR}/reboot ]; then
        mv ${DEST_DIR}/reboot_ ${DEST_DIR}/reboot
    fi
    if [ -h ${DEST_DIR}/halt ]; then
        mv ${DEST_DIR}/halt_ ${DEST_DIR}/halt
    fi
    if [ -h ${DEST_DIR}/poweroff ]; then
        mv ${DEST_DIR}/poweroff_ ${DEST_DIR}/poweroff
    fi
    rmdir $BAK_DIR 
    rm ${DEST_DIR}/suredown
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

