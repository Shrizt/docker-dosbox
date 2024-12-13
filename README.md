## DOSBox for Docker Server

This image provides a DOSBox environment and a VNC console for it, running on
port 5901 (no local X needed - fully virtual desktop).

# 2024-12-12 New push highlights:
- added autorun.sh to /config mounted dir, so you may easy add start-up commands, file will be created and +x if not exists on launch
- DosBox launch script added to infinite loop, so if your DOS game/app is halted - just press CTRL-F9 to close DosBox - it will restart promptly
- below added compose stack config example to run few DosBox hosts for network games
...more in release_notes on GitHub

Any feedback and ideas are highly appreciated and welcome to shrizt(9)gmail.c0m! :)

# Tags
* :latest - latest with no sound support (smaller, may be more stable for some DOS apps)
* :pa - with sound (pulseaudio) support - including wav and midi devices

# AUTOSLEEP feature 
You may set ENV VAR AUTOSLEEP=1 - and DosBox and pulseaudio will automatically go to sleep mode when VNC session disconnected and come back to live on connection. This really helps if you need to run few DosBox containers and will save you a lot of CPU/power usage.
Sleep/Restore logged in stdout.

# Install and run

Image is available and being updated on REPO https://hub.docker.com/r/shrizt/dosbox
Any network mode is supported. 

Simple command-line minimal run:
    docker run -d --name dosbox1 -p=55901:5901 -v /path/on/host:/config shrizt/dosbox

Connection password will be generated automatically and logged.

Best way to run container using docker compose stack
 Parameters for container in compose format:    
    
    environment:
      - VNCPASSWORD=333 #password for VNC connection
      - VNCGEOMETRY=1024x768 #resolution for VNC, 1024x768 is default (640x480 - 1024x768 works tested)
      - VNCDEPTH=16 #Bit color depth, 16 is default
      - DOSBOXSLEEP=1 #To enable auto-sleep of DosBox emu (0 by default)
    volumes:
      - /path/on/host:/config #dosbox.conf and drive_d folder will be created there and may be edited
    ports:
      - 5901:5901 #VNC port to expose


# Installed files

On first run in attached /config folder dosbox.conf file will be created (if not exist) and may be customized for future launch.
Also /config/drive_d will be created if not exist and mounted to drive D: in DosBox. Put your DOS apps there.
d:\start.bat file is executed by default on container start-up. Feel free to customize in /config/dosbox.conf

# Environment variables

 - `VNCPASSWORD` can set the password for the VNC console
   (maximum 8 characters, a limitation of tightvncserver).  If you do not set
   one, a random password will be assigned on each start of the container, and
   logged in the docker logs.

 - `VNCGEOMETRY` resolution for VNC (1024x768 default now and is a maximum working one)

 - `VNCDEPTH` Bit color depth for VNC sessions. Any 8-32 should work fine.

 - `DOSBOXSLEEP` Auto-sleep feature enabled if ="1".

 All params using running vnc server are logged on container console.
 
# VNC-based console

VNC is exposed on port 5901.  You can connect to this port.  You will see, by default,
an xterm (white) and a DOSBox terminal (black) running here, though
child images may alter these defaults.  

You may put commands to execute on start up at the end of /config/dosbox.conf file.
Setting fullscreen=1 will launch DosBox as kiosk.

# Network compose (few hosts example)

Check you have a bridge network with name my-bridge and ip addresses in range (or correct below)
```
---
version: "3.4"

x-common-variables: &common-variables
      PUID: 1002
      PGID: 100
      TZ: Europe/Moscow
      VNCPASSWORD: 12345678
      VNCGEOMETRY: 640x480
      VNCDEPTH: 16
      AUTOSLEEP: 0 #for stable networking both hosts may sleep simultaneously only, I use separate script for it
      VNCPORT: 5901

x-common-keys-core: &common-keys
  #image: shrizt/dosbox:pa
  image: shrizt/dosbox:latest
  security_opt:
    - no-new-privileges:true
  restart: unless-stopped

networks:
  my-bridge:
    external: true

     
services:
  dosnet1:
    <<: *common-keys
    container_name: dosnet1
    hostname: dosnet1
    healthcheck:
      test: ["CMD", "pgrep", "dosbox"]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 10s
    environment:
      <<: *common-variables            
      SOME_CUSTOM_VAR: 2
    volumes:
      - /path/on/host/dosnet1:/config
    networks:
     my-bridge:
      ipv4_address: 172.21.0.231

  dosnet2:
    <<: *common-keys    
    container_name: dosnet2
    hostname: dosnet2
    depends_on: #start this host after 1, so ipxnet server started first
      dosnet1:
        condition: service_healthy
    environment:
      <<: *common-variables    
      SOME_CUSTOM_VAR: 1
    volumes:
      - /path/on/host/dosnet2:/config
    networks:
     my-bridge:
      ipv4_address: 172.21.0.232
```

First host should execute (you may add it to /config/dosbox.conf)
>ipxnet startserver

Other hosts must exec
>ipxnet connect dosnet1

Have a happy networking!

# Source / Ext links

Some logging and startup procedures improved, configuration made to be managed externally with ease.
New source now here: https://github.com/Shrizt/docker-dosbox

Using DosBox inside: https://www.dosbox.com/
