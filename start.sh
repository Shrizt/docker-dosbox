#!/bin/bash
#code to run on container startup

echo "dosbox container started, running start.sh"

echo "Creating /config/drive_d if not exist to mount into DOSBOX"
#make drive_d dir if not exist
mkdir -p /config/drive_d

echo "Loading dosbox.conf from /config/dosbox.conf (will create if not exist)"
#if no dosbox.conf in /config - copy one there - no overwrite
cp -n /dos/dosbox.conf /config/dosbox.conf
#than copy back with overwrite
cp -f /config/dosbox.conf /dos/dosbox.conf


