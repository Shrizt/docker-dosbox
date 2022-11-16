FROM debian:buster-slim
#REMOVED PACKAGES balance vim-tiny less wget ca-certificates xdotool telnet mtools 
RUN sed -i 's/main/main contrib/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y -u dist-upgrade && \
    apt-get -y --no-install-recommends install dosbox tightvncserver xfonts-base \
            lwm xterm procps curl \
            zip unzip nano pwgen && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY startvnc.sh /usr/local/bin

COPY start.sh /usr/local/bin

COPY stopcont.sh /usr/local/bin

COPY setup.sh /
RUN /setup.sh

RUN apt-get -y --purge autoremove && rm /setup.sh

EXPOSE 5901
ENTRYPOINT /usr/local/bin/start.sh

