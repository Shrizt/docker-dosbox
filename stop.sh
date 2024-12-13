#/bin/bash
echo "`date` VNC disconnected : AUTOSLEEP STOP processes"
pkill -STOP dosbox
if pgrep pulseaudio >/dev/null 2>&1; then
pkill -STOP pulseaudio
fi