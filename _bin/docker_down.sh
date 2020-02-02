#!/bin/sh
BRIDGE=$(ip a | grep br-| grep  UP | awk '{print $2}' | sed -e 's/://')
sv down docker
ifconfig "$BRIDGE" down
ifconfig docker0 down

