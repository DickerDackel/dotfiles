if [ -n "$SUDO_USER" ]; then
    alias tmux="tmux -2 -L $SUDO_USER"
else
    alias tmux='tmux -2'
fi

tmnew () {
    name=$( mktemp -u -p ./ -t tmux-${USER}-XXX )
    local=${name##./}
    tmux -L ${name}
}

tmhs () {
    for h in "$@"; do
	tmux split-window "ssh $h"
	tmux select-layout tiled
    done
    tmux select-pane -t0
    tsk "exit"
    tmux select-layout tiled
}

tmh () {
    local optstring opt user OPTIND

    optstring="r"
    user=''
    while getopts "$optstring" opt; do
	case $opt in
	    r)
		user='root@'
		;;
	    h|*)
		cat <<-EOF
Usage: $0 [-r] HOSTNAME COMMANDS...
    Connects to HOSTNAME via ssh, optionally as root (-r)

EOF
		return 1
		;;
	esac
    done
    shift $(( $OPTIND - 1 ))
    host=$1; shift 1
    command="$@"

    tsk "ssh ${user}$host"
    for cmd in "$@"; do
	tsk "$cmd"
    done
} 


tm () {
    local recipe

    if [ $# = 0 ]; then
	tmux a || tmux
    else
	[ -z "$TMUX" ] && echo "Not inside a tmux session.  Cancelled." && return 1

	recipe=$1; shift 1
	_tmux_$recipe "$@"
    fi
}

tsk () {
    tmux send-keys "$@" C-j
}

_monitor_host () {
    local host
    host=$1; shift 1

    tmux rename-window $host
    tmux split-window -v -p 20 "ssh -t root@$host 'journalctl -f | ccze -A -o nolookups'"

    if [[ $# != 0 ]]; then
	tmux select-pane -t 0
	width=$(( 100 / $# ))

	tmux split-window -v -l 50% "ssh -t root@$host $1"
	shift 1
	for cmd in "$@"; do
	    tmux split-window -h -l $width% "ssh -t root@$host $cmd"
	done
    fi

    tmux select-pane -t 0
    tmux split-window -h -p 45 "ssh -t root@$host htop"
    tmux select-pane -t 0
    exec ssh -t root@$host "dstat -larm"
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

_tmux_4h () {
    host=$1; shift 1
    tm 4
    for pane in $( seq 0 3 ); do
	tmux select-pane -t$pane
	tsk "ssh $host"
    done
    tmux select-pane -t0
}

_tmux_3 () {
    tmux split-window -h
    tmux select-pane -t1
    tmux split-window -v
    tmux select-pane -t0
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

connect () {
    tmux set-window-option synchronize-panes on
    tsk "ssh $@"
    tsk C-l
    tmux set-window-option synchronize-panes off
    tmux select-pane -t0
}

tmgrid () {
    for h in "$@"; do
	tmux split-window "exec ssh $h"
	tmux select-layout tiled
    done
    tmux select-pane -t0
    tmux setw synchronize-panes on
    exit
}
