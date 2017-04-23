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
export PATH=/opt/texlive/2016/bin/x86_64-linux:\
$HOME/.local/bin:$HOME/.rbenv/bin:\
$PATH

## LANGUAGE OVERLAY MANAGERS
# . $HOME/.nix-profile/etc/profile.d/nix.sh # NIX
. ~/.erlangs/default/activate  # ERLANG
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex" #Elixir
kiex use 1.4.2 > /dev/null

# . /home/p/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
# eval "$(rbenv init -)"         # RUBY
# export NVM_DIR="/home/p/.nvm"  # NODE
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # NODE


## ALIA
EDITOR=ema export EDITOR
dps() { docker ps; }
dimg() { docker images; }
drm() { docker ps -a | awk '{print $1}' | grep -v ID | xargs docker rm -f; }
drmi() { docker images | awk '{print $3}' | grep -v IMAGE | xargs docker rmi -f; }
nix?(){ nix-env -qa \* -P | fgrep -i "$1"; }

alias xbq='xbps-query -Rs'
alias xbi='sudo xbps-install -S'
alias ns='nix-shell .'
alias mpl='mplayer -af scaletempo'

