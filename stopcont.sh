#/bin/bash
if [ "$AUTOSLEEP" == "1" ]; then
 sleep 5
 echo "AUTOSLEEP is enabled. DosBox & pulseaudio (if exist) will be paused now till VNC connected."
 pkill -STOP dosbox
 if pgrep pulseaudio >/dev/null 2>&1; then
 pkill -STOP pulseaudio
 fi
 tail -n 0 -f ~/.vnc/*.log | awk -W interactive '/authentication passed/ {system ("/usr/local/bin/cont.sh")} /Client.*gone/ {system ("/usr/local/bin/stop.sh")}'
else
 tail -n 0 -f ~/.vnc/*.log | awk -W interactive '/authentication passed/ {system ("echo `date` VNC connected")} /Client.*gone/ {system ("echo `date` VNC disconnected : AUTOSLEEP disabled CPU still used")}'
fi
