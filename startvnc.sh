#!/bin/bash

echo " *** startvnc.sh script RUN"
set -e

if [ -z "$VNCPASSWORD" ]; then
  VNCPASSWORD=`pwgen 8`
fi

export USER="`whoami`"
mkdir -p ~/.vnc

echo "$VNCPASSWORD" | tightvncpasswd -f > ~/.vnc/passwd
chmod 0600 ~/.vnc/passwd

echo " *** VNC password for this session is: '$VNCPASSWORD'"

if [ -z "$VNCGEOMETRY" ]; then
  VNCGEOMETRY="1024x768"
fi

if [ -z "$VNCDEPTH" ]; then
  VNCDEPTH="16"
fi

echo "*** Starting VNC: tightvncserver -geometry $VNCGEOMETRY -depth $VNCDEPTH :1"
tightvncserver -geometry $VNCGEOMETRY -depth $VNCDEPTH :1
#sleep 3
#tail -f ~/.vnc/*.log

