#!/bin/bash
FBLIST=https://raw.githubusercontent.com/jmdugan/blocklists/master/corporations/facebook/all
SWCLIST=http://someonewhocares.org/hosts/zero/hosts
BIGLIST=http://sbc.io/hosts/alternates/fakenews-gambling-porn-social/hosts
set -x
set -e

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
    sed -i '/0.0.0.0 static.licdn.com/d' /etc/hosts &&\
    sed -i '/0.0.0.0 www.linkedin.com/d' /etc/hosts &&\
    sed -i '/0.0.0.0 media.licdn.com/d' /etc/hosts &&\
    sed -i '/0.0.0.0 platform.linkedin.com/d' /etc/hosts &&\
    echo "# Updated on $(/bin/hostname) at: $(/bin/date)" >> /etc/hosts
}

new_version
