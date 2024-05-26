alias duh='du -h --max-depth=1 | sort -h'
alias facebook="sudo sed -ibak /etc/hosts -e '/^0.0.0.0 0-act.channel.facebook.com$/,/^0.0.0.0 zh-tw.facebook.com$/{//!d}'"
alias ghcit='ghci -XAllowAmbiguousTypes -XDataKinds -XGADTs -XKindSignatures -XMultiParamTypeClasses -XFlexibleInstances -XFunctionalDependencies -XTypeOperators -XUndecidableInstances -XTypeFamilies -XDataKinds -XPolyKinds -XTypeOperators'
alias emb='emacs -Q --batch --script'
alias ht='history | tail -n 20'
alias ir='irb --nocolorize --noautocomplete --noprompt --singleline'
alias l='ls -1'
alias la='ls -1A'
alias linked_in="sudo sed -ibak /etc/hosts -e 's/^0.0.0.0.*linkedin.com$//g' && sudo sed -ibak /etc/hosts -e 's/^0.0.0.0.*licdn.com$//g'"
alias ll='ls -alF'
alias mpl='mplayer -af scaletempo'
alias o=open
alias segment="sudo sed -ibak /etc/hosts -e 's/^0.0.0.0.*segment.\(com\|io\)$//g'"
alias tmx='(pgrep tmux >/dev/null 2>&1) && tmux a || tmux'
alias x='exec ssh-agent startx'
alias xbi='sudo xbps-install -S'
alias xbq='xbps-query -Rs'
alias xbr='sudo xbps-remove -R'
alias yt-dlp-lo='yt-dlp -S ext -f 17/18'
alias v4l='modprobe v4l2loopback video_nr=4 exclusive_caps=1'

# DOCKER
alias dc=docker-compose
dps() { docker ps; }
dimg() { docker images; }
drm() { docker ps -a | awk '{print $1}' | grep -v CONTAINER | xargs docker rm -f; }
drmi() { docker images | awk '{print $3}' | grep -v IMAGE | xargs docker rmi -f; }
drmv() { docker volume rm $(docker volume ls -q); }
dlayers() {  docker image inspect "$1" | jq .[].RootFS.Layers ; }
drip() { docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$1" ; }
fv() {
  local r="$(fzf)"
  if [ -n "$r" ] ; then vi "$r"; fi
}

upmount() {
  pmount | grep '^/dev/' | awk '{print $3}' | xargs -I% sudo umount '%'
}

off_work() {
	pkill -f '/home/p/WN';
	pkill -f zoom;
}


vethrm() { ifconfig | grep "^veth" | awk -F':' '{print $1}' | xargs -I% sudo ifconfig % down; }

aws_profile ()
{
    if [ -n "$INSIDE_EMACS" ]; then
        grep profile ~/.aws/config | awk '{print $2}' | tr -d ']';
        echo "export AWS_PROFILE=";
    else
        export AWS_PROFILE=$(grep profile ~/.aws/config  | awk '{print $2}' | tr -d ']' | fzf);
    fi
}
a_pod ()
{
    kubectl exec -ti $(kubectl get pods | grep -v NAME | awk '{print $1}' | fzf) -- /bin/sh
}
# aws
alias awswn='aws --profile wn'
alias awsdev='aws --profile wn_dev'
alias awsprod='aws --profile wn_prod'

# kuberenetes aliases
alias minik='minikube kubectl --'
#alias k=kubectl
#alias kd='kubectl describe'
#alias ke='kubectl exec -it'
#alias kg='kubectl get'
#alias kgdep='kubectl get deployment'
#alias kl='kubectl logs'
#alias krr='kubectl rollout restart'
#alias ksys='kubectl --namespace=kube-system'

alias sixel_term='xterm -ti vt340'
alias ir='irb --nocolorize --noautocomplete --noprompt'
alias atari='urxvt -fn xft:atarist -rv'
