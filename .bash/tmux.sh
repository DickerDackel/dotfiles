tmh () {
    local layout optstring opt OPTIND OPTARG
    layout="tiled"

    optstring="hl:"
    while getopts "$optstring" opt; do
	case "$opt" in
	    l) layout="$OPTARG" ;;
	    *)
		cat <<-EOF
			Usage: tmh [-l layout]
			    creates tmux panes for all \$VHOSTS
			    Default layout is even-vertical
EOF
		return 1
		;;
	esac
    done
    shift $(( $OPTIND - 1 ))

    for h in $VHOSTS; do
	tmux split-window "ssh $h"
	tmux select-layout $layout
    done
}

[ -n "$SUDO_USER" ] && alias tmux="tmux -L $SUDO_USER"

tm () {
    [ -z "$TMUX" ] && echo "Not inside a tmux session.  Cancelled." && return 1

    local recipe
    recipe=$1; shift 1

    _tmux_$recipe "$@"
}

tsk () {
    tmux send-keys "$@" C-j
}

_monitor_host () {
    local host
    host=$1; shift 1

    tmux rename-window $host
    tmux split-window -v -p 20 "ssh root@$host"
    tsk "journalctl -f | ccze -A -o nolookups"
    tmux select-pane -t 0
    tmux split-window -h -p 45 "ssh root@$host"
    tsk "htop"
    tmux select-pane -t 0
    tsk "ssh root@$host"
    tsk "dstat -larm"
}

_tmux_bundle () {
    for recipe in "$@"; do
	tmux new-window -n "$recipe"
	tm "$recipe"
    done
}

_tmux_monitor () {
    _monitor_host "$@"
}

# Just a vertical split to a named host (or salt by default)
_tmux_ssh () {
    tmux split-window -v "ssh ${1:salt}"
}

# Just 2 big root panes
_tmux_work () {
    tmux split-window -h
    tsk -t 1 "sudo bash"
    tsk -t 0 "sudo bash"
    tmux select-pane 0
}

# Usage example
#   activate with "tm salt"
# 4 Panes to work with saltstack
#   0. Major edit pane
#   1. run salt commands
#   2. ssh to target host (tm salt TARGET-HOST), also salt if empty
#   3. colortail on /var/log/messages, /var/log/salt/master & minion
_tmux_salt () {
    tmux rename-window salt
    # top right: small shell on target host (or salt)
    tmux split-window -h -l 100 "ssh ${1:-salt}"
    tsk -t 1 'sudo bash'
    tsk -t 1 'cd /srv/salt'
    tsk -t 1 'ls'
    #tsk -t 1 C-l 'ls'

    # bottom right: logs (see ccze.sh)
    tmux split-window -v 'ssh salt'
    tsk -t 2 'sudo bash'
    tsk -t 2 'ct messages /var/log/salt/{minion,master}'

    # top right: small run shell
    tmux select-pane -t 0
    tmux split-window -v -l 25 'ssh salt'
    tsk -t 1 'sudo bash'
    tsk -t 1 'cd /srv/lxc'
    tsk -t 1 C-l ls C-j

    # top-left: work on salt
    tmux select-pane -t 0
    tsk -t 0 'ssh salt'
    tsk -t 0 'sudo bash'
    tsk -t 0 'cd /srv/salt'
    tsk -t 0 C-l 'ls'
}

_tmux_2 () {
    tmux split-window -h
    tmux select-pane -t 0
}

_tmux_4 () {
    tmux split-window -h
    tmux split-window -v
    tmux select-pane -t 0
    tmux split-window -v
    tmux select-pane -t 0
}

_tmux_3h () {
    tmux split-window -h -p66
    tmux split-window -h
}

_tmux_3v () {
    tmux split-window -v -p 66
    tmux split-window -v
}

_tmux_6 () {
    tmux split-window -h
    tm 3v
    tmux select-pane -t0
    tm 3v
    tmux select-pane -t0
}

_tmux_8 () {
    tmux split-window -h
    tmux split-window -v
    tmux split-window -v
    tmux select-pane -t 1
    tmux split-window -v

    tmux select-pane -t 0
    tmux split-window -v
    tmux split-window -v
    tmux select-pane -t 0
    tmux split-window
    tmux select-pane -t 0
}
