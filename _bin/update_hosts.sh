#!/bin/bash
set -x
set -e
set -o pipefail

FBLIST=https://raw.githubusercontent.com/jmdugan/blocklists/master/corporations/facebook/all
SWCLIST=http://someonewhocares.org/hosts/zero/hosts
BIGLIST=http://sbc.io/hosts/alternates/fakenews-gambling-porn-social/hosts
UNLOCK_HOSTS='static.licdn.com www.linkedin.com media.licdn.com platform.linkedin.com'
REMOTE_FILE=/etc/hosts.remote

pull() {
  /usr/bin/curl -q $BIGLIST | sed -n '/^0.0.0.0/p' > $REMOTE_FILE
}

rewrite() {
    /bin/cat /etc/hosts.local $REMOTE_FILE > /etc/hosts &&\
    for H in $UNLOCK_HOSTS; do sed -i "/0.0.0.0 ${H}/d" /etc/hosts; done
    echo "# Updated on $(/bin/hostname) at: $(/bin/date)" >> /etc/hosts
}

case $1 in
  rewrite)
    rewrite ;;
  *)
    pull && rewrite;;
esac
