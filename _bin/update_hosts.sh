#!/bin/bash
set -x
set -e

FBLIST=https://raw.githubusercontent.com/jmdugan/blocklists/master/corporations/facebook/all
SWCLIST=http://someonewhocares.org/hosts/zero/hosts
BIGLIST=http://sbc.io/hosts/alternates/fakenews-gambling-porn-social/hosts
UNLOCK_HOSTS='static.licdn.com www.linkedin.com media.licdn.com platform.linkedin.com www.twitter.com twitter.com abs.twimg.com pbs.twimg.com content.twitter.com mobile.twitter.com api.twitter.com api2.twitter.com api4.twitter.com m.twitter.com static.twitter.com video.twitter.com t.co'

old_version() {
  /usr/bin/curl -q $SWCLIST |\
   /bin/sed -e "1,/shock-sites/d" > /tmp/hosts.new &&\
   /usr/bin/curl -q $FBLIST >> /tmp/hosts.new &&\
   /bin/cat /etc/hosts.local /tmp/hosts.new > /etc/hosts &&\
   echo "# Updated on $(/bin/hostname) at: $(/bin/date)" >> /etc/hosts
}

new_version() {
  /usr/bin/curl -q $BIGLIST > /tmp/hosts.new &&\
    /bin/cat /etc/hosts.local /tmp/hosts.new > /etc/hosts &&\
    for H in $UNLOCK_HOSTS; do sed -i "/0.0.0.0 ${H}/d" /etc/hosts; done
    echo "# Updated on $(/bin/hostname) at: $(/bin/date)" >> /etc/hosts
}

new_version
