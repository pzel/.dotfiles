#!/bin/bash
#set -x
set -e
set -o pipefail

FBLIST=https://raw.githubusercontent.com/jmdugan/blocklists/master/corporations/facebook/all
#SWCLIST=http://someonewhocares.org/hosts/zero/hosts
BIGLIST=https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn-social/hosts
UNLOCK_HOSTS='lobste.rs youtu.be youtube.com www.youtube.com static.licdn.com www.linkedin.com media.licdn.com platform.linkedin.com www.twitter.com twitter.com abs.twimg.com pbs.twimg.com content.twitter.com mobile.twitter.com api.twitter.com api2.twitter.com api4.twitter.com m.twitter.com static.twitter.com upload.twitter.com video.twitter.com t.co www.reddit.com reddit.com old.reddit.com'
#UNLOCK_HOSTS='static.licdn.com www.linkedin.com media.licdn.com platform.linkedin.com www.youtube.com youtube.com youtu.be'
REMOTE_FILE=/etc/hosts.remote

pull() {
  /usr/bin/curl -q $BIGLIST | sed -n '/^0.0.0.0/p' > $REMOTE_FILE
}

rewrite() {
    /bin/cat /etc/hosts.local $REMOTE_FILE > /etc/hosts &&\
    echo "# Updated on $(/bin/hostname) at: $(/bin/date)" >> /etc/hosts
}

unlock() {
    for H in $UNLOCK_HOSTS; do sed -i "/0.0.0.0 ${H}/d" /etc/hosts; done
}

case $1 in
  rewrite)
    rewrite ;;
  unlock)
    pull && rewrite && unlock  ;;
  *)
    pull && rewrite
esac

