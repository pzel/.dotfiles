#!/bin/sh
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export QT4_IM_MODULE=ibus
export WMAKER_USER_ROOT=$HOME/.config/GNUstep
#export GTK_IM_MODULE_FILE=/etc/gtk-2.0/gtk.immodules
#export GTK_IM_MODULE_FILE=/usr/lib/gtk-3.0/3.0.0/immodules.cache

exec > $HOME/.xlog
exec 2>&1

cleanup() {
  TOKILL=redshift-gtk redshift xbindkeys \
  kbd_watch display_watch udiskie alttab xscreensaver
  for PROC in ${TOKILL}; do (killall -9 ${PROC} || true); done
}

setup() {
	wmsystemtray --windows 2 &
	bgc "#324542"
	connman-ui-gtk &
	kbd_watch &
	redshift-gtk -t 5000:3000 -l 51:19 &
	udiskie --tray &
	xbindkeys &
	xmodmap ~/.Xmodmap
	xrdb -merge ~/.Xresources
	ibus-daemon --xim -dr &
	xset s 600
	xss-lock -- pzel_lock &
	cbatticon &
	kupfer --no-splash >/dev/null 2>&1 &
	amixer -q set Headphone 60%
	amixer -q set PCM 100%
	amixer -q set Speaker 100%
  (xinput --list | grep ELAN | sed -e 's/.*id=\(.\+\)\t.*/\1/' | xargs xinput disable) &
}

cleanup
(sleep 1 && setup) &
exec dbus-launch --sh-syntax --exit-with-x11 wmaker
