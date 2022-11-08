# DOSBox for Docker Server

This image can be used standalone, or as a base for other images.

It provides a DOSBox environment and a VNC console for it, running on
port 5901.

# Install and run

You can install with:

    docker pull shrizt/dosbox

Best way to run container using docker compose stack
 Parameters for container in compose format:    
    
    environment:
      - VNCPASSWORD=333 #password for VNC connection
      - VNCGEOMETRY=1024x768 #resolution for VNC (1024x768 now is a max)
      - VNCDEPTH=16 #Bit color depth
    volumes:
      - /path/on/host:/config #dosbox.conf and drive_d folder will be created there and may be edited
    ports:
      - 5901:5901 #VNC port to expose


# Installed files

On first run in attached /config folder dosbox.conf file will be created and may be customized for future launch.
Also /config/drive_d will be created if not exist and mounted to drive D: in DosBox.
Put your DOS apps there.

This image will install FreeDOS commands into `Y:\DOS` (pulled from dosemu) and DOSBox
and FreeDOS commands are both included on the system's PATH.

This image uses supervisor; please see the supervisor/ directory for
examples.  Adding your own processes is very simple.

# Environment variables

 - `VNCPASSWORD` can set the password for the VNC console
   (maximum 8 characters, a limitation of tightvncserver).  If you do not set
   one, a random password will be assigned on each start of the container, and
   logged in the docker logs.

 - `VNCGEOMETRY` resolution for VNC (1024x768 now is a maximum working one)

 - `VNCDEPTH` Bit color depth for VNC sessions. Any 8-32 should work fine.

 All params using running vnc server are logged on container console.
 
# VNC-based console

VNC is exposed on port 5901.  You can connect to this port.  You will see, by default,
an xterm (white) and a DOSBox terminal (black) running here, though
child images may alter these defaults.  If you do not see a DOSBox terminal,
then the command `dosboxconsole` should get one for you.

You may put commands to execute on start up at the end of /config/dosbox.conf file.
Setting fullscreen=1 will launch DosBox as kiosk.

# Source / Ext links

Container forked from docker-bbs set by John Goerzen <jgoerzen@complete.org> 
(https://github.com/jgoerzen/docker-bbs/tree/master/dosbox)

Some logging and startup procedures improved, configuration made to be managed externaly with ease.
New source now here: https://github.com/Shrizt/docker-dosbox

Using DosBox inside: https://www.dosbox.com/
