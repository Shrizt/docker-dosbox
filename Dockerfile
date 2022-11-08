FROM debian:jessie
# VNC doesn't start without xfonts-base
RUN sed -i 's/main/main contrib/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y -u dist-upgrade && \
    apt-get -y --no-install-recommends install dosbox tightvncserver xfonts-base \
            lwm xterm vim-tiny less wget ca-certificates balance \
            dosemu zip unzip pwgen xdotool telnet mtools nano && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY startvnc.sh /usr/local/bin
COPY dosboxconsole /usr/local/bin
# COPY supervisor/ /etc/supervisor/conf.d/
COPY setup.sh /
COPY start.sh /usr/local/bin
RUN /setup.sh

# Dosemu was just used to grab FreeDOS stuff.
RUN dpkg --purge dosemu && apt-get -y --purge autoremove && rm /setup.sh

EXPOSE 5901
ENTRYPOINT /usr/local/bin/start.sh

