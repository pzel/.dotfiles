#!/bin/sh
killall -9 redshift-gtk || true
killall -9 redshift || true
killall -9 xbindkeys || true

redshift-gtk -t 6000:4000 -l 51:19 &
xbindkeys &
xmodmap ~/.Xmodmap
xset s 600 &
xss-lock  -- slock &
kupfer >/dev/null 2>&1 &
exec startxfce4

