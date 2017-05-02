#!/bin/bash

set -e
set -x

# Generate the telnetbbs base.
#sed -e 's/serial1=dummy/serial1=modem listenport:__LISTEN_PORT__/' \
#    -e 's/frameskip=0/frameskip=30/' \
#  < /dos/dosbox.conf > /dos/dosbox-telnetbbs-template.conf

# Set up the DOSBox modem.
sed -i 's/serial1=dummy/serial1=modem listenport:5000/' /dos/dosbox.conf

# We don't want to run this.
rm /etc/supervisor/conf.d/telnetbbs.conf


