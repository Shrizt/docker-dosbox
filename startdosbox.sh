#!/bin/bash

echo " *** startdosbox.sh script RUN"

while :
do
    echo "Starting dosbox... >/usr/bin/dosbox -conf $DOSBOXCFG"
    /usr/bin/dosbox -conf $DOSBOXCFG &>$LOGDIR/dosbox.log
    echo dosbox exited, restarting...
done


