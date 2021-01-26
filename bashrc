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
  PS1="\
\$(TZ=America/Los_Angeles date +%H:%M) \
\$(TZ=America/New_York date +%H) \
\$(TZ=America/Buenos_Aires date +%H) \
\$(TZ=Europe/Warsaw date +%H:%M) \
\$(basename \"\$(pwd)\")$ " export PS1;
else
  PS1="\$(basename \$(pwd))$ " export PS1;
fi;


## TWEAKS
export NO_COLOR=1
export HISTCONTROL=ignoreboth
shopt -s histappend
export HISTSIZE=100000
export HISTFILESIZE=200000
stty -ixon
shopt -s checkwinsize
if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi
export LC_ALL=en_US.UTF-8
export LYNX_LSS="$HOME/.lynx.lss"

## GPG AGENT
GPG_TTY=$(tty) export GPG_TTY
export GPG_AGENT_INFO=""

## PATHS
export PATH=$PATH:$HOME/.cargo/bin:$HOME/bin:$HOME/.rbenv/bin

## ALIA
. "$HOME"/.alia

## LANGUAGE OVERLAY MANAGERS

## ASDF
test -s "$HOME/.asdf/asdf.sh" &&\
  . "$HOME/.asdf/asdf.sh"

rbenv_init() {
  eval "$(rbenv init -)"
}

nvm_init() {
  export NVM_DIR="/home/p/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
}

opam_init() {
  . /home/p/.opam/opam-init/init.sh > /dev/null 2> /dev/null
}

test -f /usr/share/bash-completion/completions/fzf &&\
  bash /usr/share/bash-completion/completions/fzf 

## ALIASES, ETC.
export EDITOR=emx
dps() { docker ps; }
dimg() { docker images; }
drm() { docker ps -a | awk '{print $1}' | grep -v CONTAINER | xargs docker rm -f; }
drmi() { docker images | awk '{print $3}' | grep -v IMAGE | xargs docker rmi -f; }

alias g=git
alias xbq='xbps-query -Rs'
alias xbi='sudo xbps-install -S'
alias xbr='sudo xbps-remove -R'
alias mpl='mplayer -af scaletempo'
alias ghcit='ghci -XAllowAmbiguousTypes -XDataKinds -XGADTs -XKindSignatures -XMultiParamTypeClasses -XFlexibleInstances -XFunctionalDependencies -XTypeOperators -XUndecidableInstances -XTypeFamilies -XDataKinds -XPolyKinds -XTypeOperators'
alias x='exec ssh-agent startx'
alias tmx='(pgrep tmux >/dev/null 2>&1) && tmux a || tmux'
alias h=history
alias o=open
alias ht='history | tail -n 20'

#X=$(nmcli connection   | grep  SHAW-AA0149 | awk {print })
#nmcli connect up $X
export JAVA_HOME=/usr
