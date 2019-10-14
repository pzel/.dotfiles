#!/bin/sh
#export GTK_IM_MODULE=ibus
export GTK_IM_MODULE=xim
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export QT4_IM_MODULE=ibus
#export GTK_IM_MODULE_FILE=/etc/gtk-2.0/gtk.immodules
#export GTK_IM_MODULE_FILE=/usr/lib/gtk-3.0/3.0.0/immodules.cache

cleanup() {
  killall -9 redshift-gtk || true
  killall -9 redshift || true
  killall -9 xbindkeys || true
  killall -9 kbd_watch || true
}

setup() {
	kbd_watch &
	nm-applet &
	xfce4-panel --disable-wm-check &
	#pulseaudio &
	redshift-gtk -t 5000:3000 -l 51:19 &
	setxkbmap pl &
	xbindkeys &
	xmodmap ~/.Xmodmap
	xrdb -merge ~/.Xresources
	ibus-daemon --xim -dr &
	xset s 600 &
	xss-lock -- slock &
	kupfer --no-splash >/dev/null 2>&1 &
	amixer -q set Headphone 80%
	amixer -q set PCM 80%
	amixer -q set Speaker 80%
	xsetroot -def -solid olivedrab
}

cleanup
(sleep 1 && setup) &
exec cwm

