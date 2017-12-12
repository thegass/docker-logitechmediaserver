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

The config directory must have the proper permissions. Otherwise lms will not start. You can set it with:
 ```
 mkdir -p /config_directory
 chown 101:65534 /config_directory
 ```
 
