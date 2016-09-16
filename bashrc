# If not running interactively, don't do anything
if [ `uname` != "Darwin" ]; then
    case $- in
        *i*) ;;
        *) return;;
    esac
fi


## TERMINAL TWEAKS
if [ "$INSIDE_ACME" = "true" ] ; then
  PS1="\$(awd)$ " export PS1;
  unset COLORTERM
else
    PS1="$ " export PS1;
fi;


## BASH TWEAKS
export HISTCONTROL=ignoreboth
shopt -s histappend
export HISTSIZE=100000
export HISTFILESIZE=200000
shopt -s checkwinsize
if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi
stty -ixon
export MANPAGER=/usr/bin/less


## GPG AGENT
GPG_TTY=$(tty) export GPG_TTY
export GPG_AGENT_INFO=""

## PATHS
export LC_ALL=en_US.UTF-8
export GUILE_LOAD_PATH=/usr/local/share/guile/site/2.0
export GUILE_LOAD_COMPILED_PATH=/usr/local/share/guile/site/2.0
LOCAL=/usr/local/bin:/usr/local/sbin
STACK=/home/p/.stack/programs/x86_64-linux/ghc-7.10.2/bin
RMQ=/opt/rabbitmq/sbin
export PATH=$HOME/.cabal/bin:$PATH:$HOME/.local/bin:$LOCAL:$HOME/.rbenv/bin:$STACK:$RMQ

## LANGUAGE OVERLAY MANAGERS
. ~/.erlangs/default/activate  # ERLANG
eval "$(rbenv init -)"         # RUBY
export NVM_DIR="/home/p/.nvm"  # NODE
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # NODE

## ALIA
EDITOR=ema export EDITOR
dps() { docker ps; }
dimg() { docker images; }
drm() { docker ps -a | awk '{print $1}' | grep -v ID | xargs docker rm -f; }
drmi() { docker images | awk '{print $3}' | grep -v IMAGE | xargs docker rmi -f; }
alias xbq='xbps-query -Rs'
alias xbi='sudo xbps-install -S'


