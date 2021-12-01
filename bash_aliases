alias duh='du -h --max-depth=1 | sort -h'
alias g=git
alias ghcit='ghci -XAllowAmbiguousTypes -XDataKinds -XGADTs -XKindSignatures -XMultiParamTypeClasses -XFlexibleInstances -XFunctionalDependencies -XTypeOperators -XUndecidableInstances -XTypeFamilies -XDataKinds -XPolyKinds -XTypeOperators'
alias h=history
alias ht='history | tail -n 20'
alias l='ls -1'
alias la='ls -1A'
alias linked_in="sudo sed -ibak /etc/hosts -e 's/^0.0.0.0.*linkedin.com$//g'"
alias facebook="sudo sed -ibak /etc/hosts -e '/^0.0.0.0 0-act.channel.facebook.com$/,/^0.0.0.0 zh-tw.facebook.com$/{//!d}'"
alias segment="sudo sed -ibak /etc/hosts -e 's/^0.0.0.0.*segment.\(com\|io\)$//g'"
alias ll='ls -alF'
alias mpl='mplayer -af scaletempo'
alias o=open
alias tmx='(pgrep tmux >/dev/null 2>&1) && tmux a || tmux'
alias x='exec ssh-agent startx'
alias xbi='sudo xbps-install -S'
alias xbq='xbps-query -Rs'
alias xbr='sudo xbps-remove -R'

# DOCKER
alias dc=docker-compose
dps() { docker ps; }
dimg() { docker images; }
drm() { docker ps -a | awk '{print $1}' | grep -v CONTAINER | xargs docker rm -f; }
drmi() { docker images | awk '{print $3}' | grep -v IMAGE | xargs docker rmi -f; }
drmv() { docker volume rm $(docker volume ls -q); }
fv() {
  local r="$(fzf)"
  if [ -n "$r" ] ; then vi "$r"; fi
}
vethrm() { ifconfig | grep "^veth" | awk -F':' '{print $1}' | xargs -I% sudo ifconfig % down; }

# aws
alias awswn='aws --profile wn'
alias awsdev='aws --profile wn_dev'
alias awsprod='aws --profile wn_prod'

# kuberenetes aliases
#alias k=kubectl
#alias kd='kubectl describe'
#alias ke='kubectl exec -it'
#alias kg='kubectl get'
#alias kgdep='kubectl get deployment'
#alias kl='kubectl logs'
#alias krr='kubectl rollout restart'
#alias ksys='kubectl --namespace=kube-system'
