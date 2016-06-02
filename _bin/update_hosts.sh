#!/bin/bash
FBLIST=https://raw.githubusercontent.com/jmdugan/blocklists/master/corporations/facebook/all
SWCLIST=http://someonewhocares.org/hosts/zero/hosts
set -x
set -e
/usr/bin/curl -q $SWCLIST |\
 /bin/sed -e "1,/shock-sites/d" > /tmp/hosts.new &&\
 /usr/bin/curl -q $FBLIST >> /tmp/hosts.new &&\
 /bin/cat /etc/hosts.local /tmp/hosts.new > /etc/hosts &&\
 echo "# Updated on $(/bin/hostname) at: $(/bin/date)" >> /etc/hosts