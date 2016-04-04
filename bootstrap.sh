#!/bin/sh
# set up a fresh xubuntu
# run me with: `sudo sh ./bootstrap.sh`
set -x

# Disable gnome-keyring from taking over ssh-agent
chmod 000 /usr/bin/gnome-keyring*

# Add upstream Stack PPA
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 575159689BEFB442
# echo 'deb http://download.fpcomplete.com/ubuntu wily main' |sudo tee /etc/apt/sources.list.d/fpco.list

TOINSTALL="tmux emacs git libreoffice-core libreoffice-writer libreoffice-calc libreoffice-impress libreoffice-gtk mg rbenv ruby-build kupfer curl libncurses5-dev gcc libssl-dev libxml2-dev haskell-stack guile-2.0 guile-2.0-libs guile-2.0-dev tk xfwm4-themes autoconf automake autogen libtool cpufrequtils xdotool gnome-terminal nodejs redshift-gtk zim midori chromium-browser xclip hplip gnupg gnupg-agent pinentry-curses libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev gimp xosview flac gstreamer1.0-plugins-bad virtualbox virtualbox-qt virtualbox-guest-additions-iso vde2 elinks mksh hasktags dhcpcd5 docker.io htop libsdl1.2-dev libsdl*1.2-dev libsqlite3-dev sqlite3 libqtwebkit-dev qtchooser imagemagick nodejs npm cleancss nmap ibus-anthy ibus-qt4 ibus-clutter arandr fonts-linuxlibertine"
TOREMOVE="fonts-guru fonts-guru-extra fonts-kacst fonts-kacst-one fonts-khmeros-core fonts-lao fonts-lklug-sinhala fonts-lohit-guru fonts-nanum fonts-sil-abyssinica fonts-sil-padauk fonts-stix fonts-thai-tlwg fonts-tibetan-machine fonts-tlwg-garuda fonts-tlwg-kinnari fonts-tlwg-laksaman fonts-tlwg-loma fonts-tlwg-mono fonts-tlwg-norasi fonts-tlwg-purisa fonts-tlwg-sawasdee fonts-tlwg-typewriter fonts-tlwg-typist fonts-tlwg-typo fonts-tlwg-umpush fonts-tlwg-waree ttf-indic-fonts-core nano"

apt-get remove $TOREMOVE
apt-get install -y $TOINSTALL --no-install-recommends
