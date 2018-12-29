# If not running interactively, don't do anything
if [ `uname` != "Darwin" ]; then
    case $- in
        *i*) ;;
        *) return;;
    esac
fi

## TERMINAL TWEAKS
if [ -n "$INSIDE_ACME" ] ; then
  PS1="\$(awd)$ " export PS1;
  unset COLORTERM
elif [ -n "$INSIDE_EMACS" ] ; then
  unset COLORTERM
  PS1="\$(basename \$(pwd))$ " export PS1;
else
  PS1="\$(basename \$(pwd))$ " export PS1;
fi;


## TWEAKS
export NO_COLOR=1
export HISTCONTROL=ignoreboth
shopt -s histappend
export HISTSIZE=100000
export HISTFILESIZE=200000
shopt -s checkwinsize
if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi
stty -ixon
export MANPAGER=/usr/bin/less
export LC_ALL=en_US.UTF-8

## GPG AGENT
GPG_TTY=$(tty) export GPG_TTY
export GPG_AGENT_INFO=""

## PATHS
export GOPATH=$HOME/src/go
export PATSHOME=/usr/local/lib/ats2-postiats-0.3.8
export PATSCONTRIB=$PATSHOME
export OPENRESTY_PATH=/usr/local/openresty/bin
export OPENRESTY_NGINX_PATH=/usr/local/openresty/nginx/sbin

export PATH=/opt/texlive/2017/bin/x86_64-linux:\
$HOME/.local/bin:$HOME:$GOPATH/bin:$HOME/.rbenv/bin:\
$OPENRESTY_PATH:$OPENRESTY_NGINX_PATH:\
$PATH

## LANGUAGE OVERLAY MANAGERS
. ~/.erlangs/20/activate
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"
kiex use default > /dev/null

#. /home/p/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

eval "$(rbenv init -)"         # RUBY
# export NVM_DIR="/home/p/.nvm"  # NODE
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # NODE

## ALIASES, ETC.
export EDITOR=ema
dps() { docker ps; }
dimg() { docker images; }
drm() { docker ps -a | awk '{print $1}' | grep -v CONTAINER | xargs docker rm -f; }
drmi() { docker images | awk '{print $3}' | grep -v IMAGE | xargs docker rmi -f; }
nix?(){ nix-env -qa \* -P | fgrep -i "$1"; }

export WAL_SRC_=$HOME/w/wallaroo
wal() {
  (cd $WAL_SRC_/machida && find | grep '.pyc$' | xargs -L1 rm)
  export PYTHONPATH=$PYTHONPATH:$WAL_SRC_/machida:$WAL_SRC_/machida/lib:.
  ln -fs $WAL_SRC_/machida/build/machida $HOME/bin/machida
  ln -fs $WAL_SRC_/machida3/build/machida3 $HOME/bin/machida3
  ln -fs $WAL_SRC_/giles/sender/sender $HOME/bin/sender
  ln -fs $WAL_SRC_/utils/cluster_shutdown/cluster_shutdown $HOME/bin/cluster_shutdown
  ln -fs $WAL_SRC_/testing/tools/external_sender/external_sender $HOME/bin/external_sender
  (cd $WAL_SRC_ && echo "Using Machida $(git describe --all --long)")
}

build_wal(){
  (cd $WAL_SRC_ &&
	echo "Building Wallaroo $(git describe --all --long)")
  (cd $WAL_SRC_/machida && rm -f build/machida &&
	make build-machida debug=true)
  (cd $WAL_SRC_/machida3 && rm -f build/machida3 &&
	make build-machida3 debug=true)
  (cd $WAL_SRC_/giles/sender && make debug=true)
  (cd $WAL_SRC_/utils/cluster_shutdown && make debug=true)
  (cd $WAL_SRC_/testing/tools/external_sender && make debug=true)
}

pex() { python3 -c "exec(\"$*\")"; }

pev() { python3 -c "print(eval(\"$*\"))"; }

alias xbq='xbps-query -Rs'
alias xbi='sudo xbps-install -S'
alias w3='w3m https://duckduckgo.com'
alias mpl='mplayer -af scaletempo'
alias ghcit='ghci -XAllowAmbiguousTypes -XDataKinds -XGADTs -XKindSignatures -XMultiParamTypeClasses -XFlexibleInstances -XFunctionalDependencies -XTypeOperators -XUndecidableInstances -XTypeFamilies -XDataKinds -XPolyKinds -XTypeOperators'

#X=$(nmcli connection   | grep  SHAW-AA0149 | awk {print })
#nmcli connect up $X
export JAVA_HOME=/usr
export PATH=$PATH:$HOME/.pulumi/bin
