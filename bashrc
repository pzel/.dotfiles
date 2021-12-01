
# If not running interactively, don't do anything
if [ `uname` != "Darwin" ]; then
    case $- in
        *i*) ;;
        *) return;;
    esac
fi

## TERMINAL TWEAKS
if [ -n "$INSIDE_EMACS" ] ; then
  unset COLORTERM
fi

if [ -n "$INSIDE_ACME" ] ; then
  export PS1="\$(awd)% " ;
  unset COLORTERM
else
  export PS1="\$(basename \$(pwd))\$(printf '[%c]' "\${IN_NIX_SHELL:-_}" )% ";
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
export LESS="-XF"

## GPG AGENT
GPG_TTY=$(tty) export GPG_TTY
export GPG_AGENT_INFO=""

## PATHS
export PATH=$PATH:$HOME/bin:$HOME/wn/bin/

## LANGUAGE OVERLAY MANAGERS
. /home/p/.nix-profile/etc/profile.d/nix.sh

## ANDROID
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export EDITOR=emx
eval "$(direnv hook bash)"
