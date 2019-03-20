#!/bin/sh
export GTK_IM_MODULE=ibus
export QT4_IM_MODULE=xim
export QT_IM_MODULE=xim
export XMODIFIERS=@im=ibus

killall -9 redshift-gtk || true
killall -9 redshift || true
killall -9 xbindkeys || true

redshift-gtk -t 6000:4000 -l 51:19 &
xbindkeys &
xmodmap ~/.Xmodmap
xset s 600 &
xss-lock  -- slock &
kupfer >/dev/null 2>&1 &
amixer -q set Headphone 70%
amixer -q set PCM 80%
amixer -q set Speaker 100%
exec startxfce4
