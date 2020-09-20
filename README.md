# docker-logitechmediaserver

Docker image for Logitech Media Server (lms, SqueezeCenter, SqueezeboxServer, SlimServer).
This image includes the ssl libraries necessary for several plugins including youtube plugin.

Run with:
```
docker run -it \
      -p 3483:3483 \
      -p 3483:3483/udp \
      -p 9000:9000 \
      -v /etc/localtime:/etc/localtime:ro \
      -v /config_directory:/config \
      -v /music_directory:/music:ro \
      jboesl/logitechmediaserver
```


Or with docker-compose:
```
lms:
  image: jboesl/logitechmediaserver
  ports:
    - "3483:3483"     # slimproto
    - "3483:3483/udp" # slimproto
    - "9000:9000"     # http frontend
  volumes:
    - /etc/localtime:/etc/localtime:ro
    - /config_directory:/config
    - /music_directory:/music:ro
  restart: unless-stopped
```


Docker-compose variant with host networking and specified server address:
```
version: '2'

services:
  lms:
    image: jboesl/logitechmediaserver
    network_mode: "host"
    command:
      - "--prefsdir=/config/prefs"
      - "--logdir=/config/logs"
      - "--cachedir=/config/cache"
      - "--httpaddr=192.168.1.1"
      - "--cliaddr=192.168.1.1"
    #ports:
    #  - "1901:1900/udp" # ssdp
    #  - "3483:3483"     # slimproto
    #  - "3483:3483/udp" # slimproto
    #  - "9000:9000"     # http frontend
    #  - "9091:9090"     # cli
    #  - "49152:49152"   # upnp/dlna renderer
    volumes:
      - /config_directory:/config
      - /music_directory:/music:ro
    restart: unless-stopped
```

The config directory must have the proper permissions. Otherwise lms will not start. You can set it with:
 ```
 mkdir -p /config_directory
 chown 101:65534 /config_directory
 ```

Alternatively you can specify the user and group id to use. Example for the environment section in compose file:
```
environment:
  - PUID=1000
  - PGID=1000
 ```
