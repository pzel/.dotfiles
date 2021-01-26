#!/bin/sh
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export QT4_IM_MODULE=ibus
#export GTK_IM_MODULE_FILE=/etc/gtk-2.0/gtk.immodules
#export GTK_IM_MODULE_FILE=/usr/lib/gtk-3.0/3.0.0/immodules.cache

exec > $HOME/.xlog
exec 2&>1

cleanup() {
  TOKILL=redshift-gtk redshift xbindkeys \
  kbd_watch display_watch udiskie alttab xscreensaver
  for PROC in ${TOKILL}; do (killall -9 ${PROC} || true); done
}

setup() {
        # ~/.screenlayout/laptop-lores.sh
	xscreensaver -no-splash &
	stalonetray  -v &
	bgc "#324542"
	connman-ui-gtk &
	kbd_watch &
	#xfce4-panel --disable-wm-check &
	#pulseaudio &
	redshift-gtk -t 5000:3000 -l 51:19 &
	udiskie --tray &
	xbindkeys &
	xmodmap ~/.Xmodmap
	xrdb -merge ~/.Xresources
	ibus-daemon --xim -dr &
	xset s 600
	xss-lock -- pzel_lock &
	kupfer --no-splash >/dev/null 2>&1 &
	amixer -q set Headphone 60%
	amixer -q set PCM 100%
	amixer -q set Speaker 100%
	# xfsettingsd &
	# gsettings set org.gnome.desktop.a11y.keyboard bouncekeys-enable true
	# gsettings set org.gnome.desktop.a11y.keyboard bouncekeys-delay 50
        #xkbset exp -bell -sticky -twokey -latchlock -feedback -stickybeep -led 99999
        #xkbset sticky -twokey -latchlock feedback led stickybeep
	# disable dell touchscreen
        xinput --list | grep ELAN | sed -e 's/.*id=\(.\+\)\t.*/\1/' | xargs xinput disable
}

cleanup
(sleep 2 && setup) &
exec dbus-launch --sh-syntax --exit-with-x11 xfwm4

