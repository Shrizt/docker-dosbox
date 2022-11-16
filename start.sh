#!/bin/bash
#code to run on container startup

echo "### dosbox container started, running start.sh"
echo "cleaning up /tmp:"
ls -a /tmp
rm -r -f /tmp/* /tmp/.*

echo "DosBox pausing (auto-sleep) on VNC disconnect is..."
if [ "$DOSBOXSLEEP" == "1" ]; then
 echo "ENABLED (ENV DOSBOXSLEEP=1)"
else
 echo "DISABLED (set ENV DOSBOXSLEEP=1 to enable DosBox auto-sleep)"
fi

echo "starting vnc script..."
/usr/local/bin/startvnc.sh

echo "Creating /config/drive_d if not exist to mount into DOSBOX"
#make drive_d dir if not exist
mkdir -p /config/drive_d

DOSBOXCFG=/config/dosbox.conf
if [ -f "$DOSBOXCFG" ]; then
    echo "Using $DOSBOXCFG. If you need to load defaults - remove $DOSBOXCFG"
else 
    echo "$DOSBOXCFG does not exist. Creating from defaults..."
    cp -n /dos/dosbox.conf $DOSBOXCFG    
fi

export DISPLAY=:1

echo "Starting /usr/bin/xterm &"
/usr/bin/xterm &
echo "Starting dosbox... >/usr/bin/dosbox -conf $DOSBOXCFG &"
/usr/bin/dosbox -conf $DOSBOXCFG &>/config/dosbox.log &
echo "VNC connections watcher start"
/usr/local/bin/stopcont.sh
echo "### finished start.sh script"

