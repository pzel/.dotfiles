#!/bin/sh
#export GTK_IM_MODULE=ibus
export GTK_IM_MODULE=xim
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export QT4_IM_MODULE=ibus
#export GTK_IM_MODULE_FILE=/etc/gtk-2.0/gtk.immodules
#export GTK_IM_MODULE_FILE=/usr/lib/gtk-3.0/3.0.0/immodules.cache

cleanup() {
  TOKILL=redshift-gtk redshift xbindkeys kbd_watch display_watch udiskie alttab
  for PROC in ${TOKILL}; do (killall -9 ${PROC} || true); done
}

setup() {
	nm-applet &
	xfce4-panel --disable-wm-check &
	#pulseaudio &
	redshift-gtk -t 5000:3000 -l 51:19 &
	udiskie --tray &
	setxkbmap pl
	xbindkeys &
	xmodmap ~/.Xmodmap
	xrdb -merge ~/.Xresources
	ibus-daemon --xim -dr &
	xset s 300
	xss-lock -- slock &
	kupfer --no-splash >/dev/null 2>&1 &
	globaltime &
	amixer -q set Headphone 60%
	amixer -q set PCM 100%
	amixer -q set Speaker 100%
	# xfsettingsd &
	gsettings set org.gnome.desktop.a11y.keyboard bouncekeys-enable true
	gsettings set org.gnome.desktop.a11y.keyboard bouncekeys-delay 50
  ~/.screenlayout/laptop-lores.sh
	# Two alt-tabs, for switching with Left Super & Right Ctrl
	alttab -mk Control_R -kk Tab -s 0 -bg white -fg black >/dev/null 2>&1 &
	alttab -mk Super_L -kk Tab -s 0 -bg white -fg black >/dev/null 2>&1 &
}

cleanup
(sleep 3 && setup) &
exec dbus-launch --sh-syntax --exit-with-x11 xfwm4
