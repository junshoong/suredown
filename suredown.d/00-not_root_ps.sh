#!/bin/sh
ps -eo %U%p%P%c%a | grep -v '^[(root)(dbus)(nbpmon)(68)]'
# header="USER PID PPID NAME COMMAND"
# body=
# ps -eo %U%p%P%c%a --no-header | while read user pid ppid name command; do
#     case $user in
#         root|nbpmon|dbus) ;;
#         *)
#             body="$body $user $pid $ppid $name $command\n"
#             ;;
#     esac
# done
# echo $header
# echo $body

