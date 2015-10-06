# If not running interactively, don't do anything
if [ `uname` != "Darwin" ]; then
    case $- in
        *i*) ;;
        *) return;;
    esac
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000
shopt -s checkwinsize
if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi

stty -ixon

SONAR_RUNNER_HOME=/opt/sonar-runner-2.4 export SONAR_RUNNER_HOME
GHC_INSTALL=/opt/ghc
PLAN9=/usr/local/plan9 export PLAN9
LOCAL=/usr/local/bin:/usr/local/sbin:/opt/rabbitmq/sbin:/usr/local/Gambit-C/bin
EDITOR=ema export EDITOR
PATH=$HOME/.cabal/bin:$PATH:$HOME/bin:$PLAN9/bin:$LOCAL:$GHC_INSTALL/bin:$SONAR_RUNNER_HOME/bin export PATH
export LC_ALL=en_US.utf-8

. ~/erlang/activate

if [ "$INSIDE_ACME" = "true" ] ; then
  PS1="\$(awd)$ " export PS1;
  unset COLORTERM
else
    PS1="$ " export PS1;
fi
