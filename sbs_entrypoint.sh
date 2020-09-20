#!/bin/sh

umask 0002
PUID=${PUID:-id -u squeezeboxserver}
PGID=${PGID:-id -g nogroup}

usermod -o -u "$PUID" squeezeboxserver
groupmod -o -g "$PGID" nogroup

umask 0002
exec squeezeboxserver "$@"