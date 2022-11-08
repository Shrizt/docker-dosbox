#!/bin/bash

set -e
set -x

mkdir -p /dos/drive_{c,d,e,f,g,y}
cp -r /usr/lib/dosemu/drive_z/bin /dos/drive_y/DOS
mkdir /dos/drive_y/SCRIPTS

DOSBOXCONF="`dosbox -printconf`"
mv "$DOSBOXCONF" /dos/dosbox.conf
for ASDF in c e f g y; do 
  echo "mount $ASDF /dos/drive_$ASDF" >> /dos/dosbox.conf
done
echo "mount d /config/drive_d" >> /dos/dosbox.conf
echo 'path %PATH%;Y:\DOS;Y:\SCRIPTS' >> /dos/dosbox.conf
echo "d:" >> /dos/dosbox.conf

# Fix an issue with the VNC console
sed -i 's/usescancodes=true/usescancodes=false/' /dos/dosbox.conf

# Convenience aliases
cd /usr/local/bin
ln -s /usr/bin/vim.tiny vim
ln -s /usr/bin/vim.tiny vi

