FROM debian:buster-slim
#REMOVED PACKAGES balance vim-tiny less wget xdotool telnet mtools 
RUN sed -i 's/main/main contrib/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y -u dist-upgrade && \
    apt-get -y --no-install-recommends install dosbox tightvncserver xfonts-base \
            lwm xterm procps curl ca-certificates \
            zip unzip nano pwgen inotify-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY start.sh startdosbox.sh startvnc.sh /usr/local/bin/

COPY stopcont.sh cont.sh stop.sh /usr/local/bin/

COPY setup.sh /
RUN /setup.sh

RUN apt-get -y --purge autoremove && rm /setup.sh

EXPOSE 5901
ENTRYPOINT /usr/local/bin/start.sh

