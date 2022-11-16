#/bin/bash
if [ "$DOSBOXSLEEP" == "1" ]; then
 echo "DosBox auto-sleep enabled. DosBox put to coma now till VNC connected."
 pkill -STOP dosbox
 tail -n 0 -f ~/.vnc/*.log | awk -W interactive '/authentication passed/ {system ("pkill -CONT dosbox && echo `date` VNC connected : DosBox resumed")} /Client.*gone/ {system ("pkill -STOP dosbox && echo `date` VNC disconnected : DosBox paused")}'
else
 tail -n 0 -f ~/.vnc/*.log | awk -W interactive '/authentication passed/ {system ("echo `date` VNC connected")} /Client.*gone/ {system ("echo `date` VNC disconnected : DosBox sleep disabled CPU still used")}'
fi
