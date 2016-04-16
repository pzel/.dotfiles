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
elif [ "$TMUX" != "" ]; then
    PROMPT_COMMAND='tmux rename-window "$(basename $(pwd))" >/dev/null 2>&1'  export PROMPT_COMMAND
    PS1="$ " export PS1;
else 
    PS1="$ " export PS1;
fi;


## BASH TWEAKS
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=100000
HISTFILESIZE=200000
shopt -s checkwinsize
if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi
stty -ixon


## GPG AGENT
# Run this on login somewhere:
# gpg-agent --daemon
if pgrep gpg-agent >/dev/null 2>&1 ; then
  if [ -f "${HOME}/.gpg-agent-info" ]; then
  	. "${HOME}/.gpg-agent-info"
        export GPG_AGENT_INFO
	GPG_TTY=$(tty) export GPG_TTY
	gpg-connect-agent updatestartuptty /bye >/dev/null
  fi;
else
  echo 'NO GPG AGENT RUNNING'
fi;

## PATHS
export LC_ALL=en_US.UTF-8
export GUILE_LOAD_PATH=/usr/local/share/guile/site/2.0
export GUILE_LOAD_COMPILED_PATH=/usr/local/share/guile/site/2.0
export GUIX_LOCPATH=$HOME/.guix-profile/lib/locale

LOCAL=/usr/local/bin:/usr/local/sbin
STACK=/home/p/.stack/programs/x86_64-linux/ghc-7.10.2/bin
export PATH=$HOME/.cabal/bin:$PATH:$HOME/.local/bin:$LOCAL:$HOME/.rbenv/bin:$STACK



## LANGUAGE OVERLAY MANAGERS
. ~/.activate_erlang
eval "$(rbenv init -)"


## ALIA
EDITOR=ema export EDITOR
resolv () { 
  echo -e 'nameserver 8.8.8.8\nnameserver 8.8.4.4' |\
  sudo tee /etc/resolv.conf 
}
