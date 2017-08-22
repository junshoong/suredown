#!/bin/sh

DEST_DIR=
SOURCE_FILE=./suredown.sh
INIT=

check_init()
{
    if [ -d /lib/systemd ]; then
        INIT="systemd"
    else
        INIT="upstart"
    fi
}

setup()
{
    tmp=`which shutdown`
    DEST_DIR=${tmp%/*}
    echo "1. setup"
    echo "cp $SOURCE_FILE to $DEST_DIR..."
    test -d $DEST_DIR || mkdir -p $DEST_DIR && cp $SOURCE_FILE ${DEST_DIR}/suredown

    echo "setup surdown files..."
    if [ "$INIT" == "systemd" ]; then
        mv ${DEST_DIR}/shutdown ${DEST_DIR}/shutdown_ 
        mv ${DEST_DIR}/reboot ${DEST_DIR}/reboot_
        mv ${DEST_DIR}/halt ${DEST_DIR}/halt_
        mv ${DEST_DIR}/poweroff ${DEST_DIR}/poweroff_
        ln -s ${DEST_DIR}/suredown ${DEST_DIR}/shutdown
        ln -s ${DEST_DIR}/suredown ${DEST_DIR}/reboot
        ln -s ${DEST_DIR}/suredown ${DEST_DIR}/halt
        ln -s ${DEST_DIR}/suredown ${DEST_DIR}/poweroff
    elif [ "$INIT" == "upstart" ]; then
        mv ${DEST_DIR}/shutdown ${DEST_DIR}/shutdown_ 
        ln -s ${DEST_DIR}/suredown ${DEST_DIR}/shutdown
    else
        echo "this init system not supported"
        rm ${DEST_DIR}/suredown
        exit 1
    fi

    echo "setup user script..."
    cp -r ./suredown.d /etc

    echo "Done!"
}

remove()
{
    tmp=`which suredown`
    DEST_DIR=${tmp%/*}
    echo "2. remove"
    if [ -h ${DEST_DIR}/shutdown ]; then
        mv ${DEST_DIR}/shutdown_ ${DEST_DIR}/shutdown
    fi
    if [ "$INIT" == "systemd" ]; then
        if [ -h ${DEST_DIR}/reboot ]; then
            mv ${DEST_DIR}/reboot_ ${DEST_DIR}/reboot
        fi
        if [ -h ${DEST_DIR}/halt ]; then
            mv ${DEST_DIR}/halt_ ${DEST_DIR}/halt
        fi
        if [ -h ${DEST_DIR}/poweroff ]; then
            mv ${DEST_DIR}/poweroff_ ${DEST_DIR}/poweroff
        fi
    elif [ "$INIT" == "upstart" ]; then
        :
    else
        echo "this init system not supported"
        exit 1
    fi
    rm ${DEST_DIR}/suredown
}

clear
echo "** suredown **"
# echo "Are you sure you want to change shutdown file? [Y/N]: "
echo "1. setup"
echo "2. remove"
echo "3. cancel"
read num
check_init

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

