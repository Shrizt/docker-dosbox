#!/bin/bash

set -e
set -x

mkdir -p /dos/drive_{c,y}
mkdir /dos/drive_y/SCRIPTS

DOSBOXCONF="`/usr/bin/dosbox -printconf`"
mv "$DOSBOXCONF" /dos/dosbox.conf
for ASDF in c y; do 
  echo "mount $ASDF /dos/drive_$ASDF" >> /dos/dosbox.conf
done
echo "mount d /config/drive_d" >> /dos/dosbox.conf
echo 'path %PATH%;Y:\SCRIPTS' >> /dos/dosbox.conf
echo "d:" >> /dos/dosbox.conf
echo "@echo You may create start.bat in /config/drive_d directory to run app in DosBox on container start!" >>/dos/dosbox.conf
echo "d:\start.bat" >> /dos/dosbox.conf

# Fix an issue with the VNC console
sed -i 's/usescancodes=true/usescancodes=false/' /dos/dosbox.conf
# Limit cycles to 25000 to reduce CPU utilization
sed -i 's/cycles=auto/cycles=25000/' /dos/dosbox.conf

# Convenience aliases
cd /usr/local/bin
ln -s /usr/bin/vim.tiny vim
ln -s /usr/bin/vim.tiny vi

