FROM debian
MAINTAINER Johannes Boesl <j.boesl@adito.de>

ENV LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"

RUN \
  apt-get update -qq && \
  apt-get install -qy curl lame faad flac sox libio-socket-ssl-perl libnet-ssleay-perl && \
  apt-get clean -qy && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install LMS
RUN /bin/bash -c '\
  export DEBIAN_FRONTEND="noninteractive" && \
  OUT=$(curl -skL "http://downloads.slimdevices.com/nightly/index.php?ver=8.1") && \
  REGEX=".*href=\".(.*logitechmediaserver_8.1.1~[0-9]{4,}_amd64.deb)\"" && \
  if [[ ${OUT} =~ ${REGEX} ]]; then URL="http://downloads.slimdevices.com/nightly${BASH_REMATCH[1]}"; else exit 42; fi && \
  curl -skL -o /tmp/lms.deb $URL && \
  dpkg -i /tmp/lms.deb && \
  rm /tmp/lms.deb \
  '

RUN \
  usermod -o -u 1000 squeezeboxserver && \
  groupmod -o -g 1000 nogroup && \ 
  mkdir /config /music && \
  chown squeezeboxserver:nogroup /config /music

VOLUME /config /music
EXPOSE 3483 3483/udp 9000 9090

COPY sbs_entrypoint.sh /usr/bin/sbs_entrypoint.sh
USER squeezeboxserver
ENTRYPOINT ["sbs_entrypoint.sh"]
CMD ["--prefsdir", "/config/prefs", "--logdir", "/config/logs", "--cachedir", "/config/cache"]
