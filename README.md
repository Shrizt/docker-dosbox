# DOSBox for Docker Server

Any feedback and ideas are higly appreciated and welcome to shrizt(9)gmail.c0m! :)

This image can be used standalone, or as a base for other images.

It provides a DOSBox environment and a VNC console for it, running on
port 5901 (no local X needed - fully virtual desktop).

DosBox default settings "cycles=auto" replaced to "cycles=25000" which is enough for most applications - but you free to adjust any configuration options in mounted /config folder.

# Super feature added
Now you may set ENV VAR DOSBOXSLEEP=1 - and DosBox will automatically go to sleep mode when VNC session disconnected and come back to live on connection. This really helps if you need to run few DosBox containers and will save you a lot of CPU usage/power.
Sleep/Restore logged in stdout.

# Install and run

Image is available and being updated on REPO https://hub.docker.com/r/shrizt/dosbox
Any network mode is supported.

You can install with:
    docker pull shrizt/dosbox

Simple command-line minimal run:
    docker run -d --name dosbox1 -p=55901:5901 -v /path/on/host:/config shrizt/dosbox

Best way to run container using docker compose stack
 Parameters for container in compose format:    
    
    environment:
      - VNCPASSWORD=333 #password for VNC connection
      - VNCGEOMETRY=1024x768 #resolution for VNC (1024x768 now is a max)
      - VNCDEPTH=16 #Bit color depth
      - DOSBOXSLEEP=1 #To enable auto-sleep of DosBox emu
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

 - `VNCGEOMETRY` resolution for VNC (1024x768 now is a maximum working one)

 - `VNCDEPTH` Bit color depth for VNC sessions. Any 8-32 should work fine.

 - `DOSBOXSLEEP` Auto-sleep feature enabled if ="1".

 All params using running vnc server are logged on container console.
 
# VNC-based console

VNC is exposed on port 5901.  You can connect to this port.  You will see, by default,
an xterm (white) and a DOSBox terminal (black) running here, though
child images may alter these defaults.  

You may put commands to execute on start up at the end of /config/dosbox.conf file.
Setting fullscreen=1 will launch DosBox as kiosk.

# Source / Ext links

Some logging and startup procedures improved, configuration made to be managed externaly with ease.
New source now here: https://github.com/Shrizt/docker-dosbox

Using DosBox inside: https://www.dosbox.com/
