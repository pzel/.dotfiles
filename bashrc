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
  export PS1="\$(date +'%H:%M:%S') \$(basename \"\$(pwd)\")\$(printf '[%c]' "\${IN_NIX_SHELL:-_}" )% ";
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
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

## GPG AGENT
GPG_TTY=$(tty) export GPG_TTY
export GPG_AGENT_INFO=""


## LANGUAGE OVERLAY MANAGERS
export JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/jre
export GERBIL_HOME=$HOME/src/gerbil
export FLYCTL_INSTALL=$HOME/.fly


## PATHS
export PATH="$PATH:$HOME/bin:$HOME/wn/bin/"

export EDITOR=emx
. /home/p/.nix-profile/etc/profile.d/nix.sh
eval "$(direnv hook bash)"
# eval $(opam env --switch=default)
export PYTHONSTARTUP=~/.pyrc

