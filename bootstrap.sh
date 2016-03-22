# set up a fresh xubuntu
# run me with: `sudo sh ./bootstrap.sh`
set -x

# Disable gnome-keyring from taking over ssh-agent
chmod 000 /usr/bin/gnome-keyring*

TOINSTALL="tmux emacs git libreoffice-core libreoffice-writer libreoffice-calc libreoffice-impress mg rbenv ruby-build kupfer curl libncurses5-dev gcc libssl-dev libxml2-dev haskell-stack guile-2.0 tk xfwm4-themes autoconf automake libtool cpufrequtils xdotool gnome-terminal nodejs redshift-gtk zim"
TOREMOVE="fonts-guru fonts-guru-extra fonts-kacst fonts-kacst-one fonts-khmeros-core fonts-lao fonts-lklug-sinhala fonts-lohit-guru fonts-nanum fonts-sil-abyssinica fonts-sil-padauk fonts-stix fonts-thai-tlwg fonts-tibetan-machine fonts-tlwg-garuda fonts-tlwg-kinnari fonts-tlwg-laksaman fonts-tlwg-loma fonts-tlwg-mono fonts-tlwg-norasi fonts-tlwg-purisa fonts-tlwg-sawasdee fonts-tlwg-typewriter fonts-tlwg-typist fonts-tlwg-typo fonts-tlwg-umpush fonts-tlwg-waree ttf-indic-fonts-core"

apt-get remove $TOREMOVE
apt-get install -y $TOINSTALL --no-install-recommends
