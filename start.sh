#!/bin/bash
#code to run on container startup

echo "### dosbox container started, running start.sh"
echo "cleaning up /tmp:"
ls -a /tmp
rm -r -f /tmp/* /tmp/.*

echo "DosBox pausing (auto-sleep) on VNC disconnect is..."
if [ "$AUTOSLEEP" == "1" ]; then
 echo "ENABLED (ENV AUTOSLEEP=1)"
else
 echo "DISABLED (set ENV AUTOSLEEP=1 to enable DosBox auto-sleep)"
fi

echo "starting vnc script..."
/usr/local/bin/startvnc.sh

echo "Creating /config/drive_d if not exist to mount into DOSBOX"
#make drive_d dir if not exist
export LOGDIR=/config/log
mkdir -p /config/drive_d
mkdir -p $LOGDIR
#create and +x autorun.sh file in config dir if not exist
touch /config/autorun.sh
chmod +x /config/autorun.sh 


export DOSBOXCFG=/config/dosbox.conf
if [ -f "$DOSBOXCFG" ]; then
    echo "Using $DOSBOXCFG. If you need to load defaults - remove $DOSBOXCFG"
else 
    echo "$DOSBOXCFG does not exist. Creating and using from defaults..."
    cp -n /dos/dosbox.conf $DOSBOXCFG    
fi

export DISPLAY=:1
echo "Container start `date`"
# Check if pulseaudio is installed
if command -v pulseaudio >/dev/null 2>&1; then
echo "Pulseaudio is installed - Cleaning old log and starting pulseaudio daemon..."
rm $LOGDIR/pulseaudio.log
/usr/bin/pulseaudio --disallow-module-loading -vvvv --disallow-exit --exit-idle-time=-1 &>$LOGDIR/pulseaudio.log &
else
    echo "PulseAudio is not installed."
fi

echo "Starting /usr/bin/xterm &"
/usr/bin/xterm &
echo "Executing startdosbox.sh..."
/usr/local/bin/startdosbox.sh &
echo "Executing /config/autorun.sh script..."
/config/autorun.sh &
echo "### Start-up finished. VNC connections watcher start"
/usr/local/bin/stopcont.sh


