#!/bin/sh
# Adds user-level supervision to runit (debian)
set -x
set -e
USER="$1"

add_toplevel() {
  mkdir -p /etc/service/$USER-sv
  echo "#!/bin/sh
exec 2>&1
exec chpst -u$USER runsvdir /home/$USER/service
" > /etc/service/$USER-sv/run
  chmod +x /etc/service/$USER-sv/run
}

add_basic_template() {
  mkdir -p /home/$USER/service/example/log
  echo "#!/bin/sh
exec 2>&1
exec bash -c 'echo test_stdout; date; sleep 60'
" > /home/$USER/service/example/run

  mkdir -p /home/$USER/svlog/example
  echo "#!/bin/sh
exec 2>&1
exec svlogd -tt /home/$USER/svlog/example
" > /home/$USER/service/example/log/run

  chown -R $USER:$USER /home/$USER/service
  chown -R $USER:$USER /home/$USER/svlog

  chmod +x /home/$USER/service/example/log/run
  chmod +x /home/$USER/service/example/run
}

add_toplevel
add_basic_template

sv restart /etc/service/$USER-sv
