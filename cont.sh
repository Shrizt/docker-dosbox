#/bin/bash
echo "`date` VNC connected : AUTOSLEEP resuming processes"
pkill -CONT dosbox
if pgrep pulseaudio >/dev/null 2>&1; then
pkill -CONT pulseaudio
fi
