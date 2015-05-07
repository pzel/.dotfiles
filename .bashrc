# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

stty -ixon
. ~/erlang/activate
GHC_INSTALL=/opt/ghc
PLAN9=/usr/local/plan9 export PLAN9
LOCAL=/usr/local/bin:/usr/local/sbin

PATH=$HOME/.cabal/bin:$PATH:$HOME/bin:$PLAN9/bin export PATH

if [ "$INSIDE_ACME" = "true" ] ; then
  PS1="\$(awd)$ " export PS1;
  unset COLORTERM
else
    PS1="$ " export PS1;
fi
