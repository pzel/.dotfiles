#!/bin/bash
exec 2>&1
exec > .xlog
set -x
set -e
export GTK_IM_MODULE=xim
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=xim
export GTK_OVERLAY_SCROLLING=0
#export GTK_IM_MODULE_FILE=/etc/gtk-2.0/gtk.immodules
#export GTK_IM_MODULE_FILE=/usr/lib/gtk-3.0/3.0.0/immodules.cache

cleanup() {
  TOKILL=redshift-gtk redshift xbindkeys \
  kbd_watch display_watch udiskie alttab xscreensaver emacs picom
  for PROC in ${TOKILL}; do (killall -9 ${PROC} || true); done
}

setup() {
	xss-lock -- pzel_lock &
	xscreensaver &
	nm-applet &
	kbd_watch &
	redshift-gtk -t 4000:3000 -l 51:19 &
	udiskie --tray &
	xbindkeys &
	xmodmap ~/.Xmodmap &
	xrdb -merge ~/.Xresources &
	ibus-daemon --xim -dr &
	kupfer --no-splash >/dev/null 2>&1 &
	amixer -q set Headphone 60% &
	amixer -q set PCM 100% &
	amixer -q set Speaker 100% &
	#stalonetray --dockapp-mode &
	xfce4-panel &
	(sleep 2 && touchsceen_disable) &
}
setup
xhost si:localuser:root
eval $(ssh-agent)
picom --backend=glx --window-shader-fg=/home/p/src/picom-grayscale-shader.glsl &
exec dbus-launch --sh-syntax --exit-with-x11 openbox-session
