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

# Just a vertical split to a named host (or salt by default)
_tmux_ssh () {
    tmux split-window -v "ssh ${1:salt}"
}

# Just 2 big root panes
_tmux_work () {
    tmux split-window -h
    tsk -t 1 sudo bash
    tsk -t 0 sudo bash
    tmux select-pane 0
}

# My nginx log session
# Win 1: cache-hit log
# Win 2: goaccess
_tmux_nginx () {
    [ -z "$TMUX" ] && tmux new-session -d -s nginx -n cache-hits 'ssh nginx'
    tsk -t nginx:cache-hits 'exec sudo bash'
    tsk -t nginx:cache-hits 'exec /usr/local/bin/cache-hits'

    tmux new-window -t nginx -n goaccess 'ssh nginx'
    tsk -t nginx:goaccess 'exec sudo bash'
    tsk -t nginx:goaccess 'cd /srv/goaccess'
    tsk -t nginx:goaccess 'exec ./runme'

    [ -z "$TMUX" ] && tmux attach -t nginx
}

# 4 Panes to work with saltstack
#   0. Major edit pane
#   1. run salt commands
#   2. ssh to target host (tm salt TARGET-HOST), also salt if empty
#   3. colortail on /var/log/messages, /var/log/salt/master & minion
_tmux_salt () {
    # top right: small shell on target host (or salt)
    tmux split-window -h -l 100 "ssh ${1:-salt}"
    tsk -t 1 'sudo bash'
    tsk -t 1 'cd /srv/salt'
    tsk -t 1 'ls'
    #tsk -t 1 C-l 'ls'

    # bottom right: logs
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

# Modified 'salt' layout with one window on the lxc host to handle container
# stuff
#   0. Major edit pane
#   1. shuttle:/srv/lxc
#   2. ssh to target host (tm salt TARGET-HOST), also salt if empty
#   3. colortail on /var/log/messages, /var/log/salt/master & minion
_tmux_newhost () {
    local host

    # top right: small run shell
    host=${1:-salt}
    tmux split-window -h -l 100 "ssh ${1:salt}"
    tsk -t 1 'sudo bash'
    tsk -t 1 'cd /srv/salt'
    tsk -t 1 C-l 'ls'

    # bottom right: logs
    tmux split-window -v 'ssh salt'
    tsk -t 2 'sudo bash'
    tsk -t 2 'ct messages'

    # bottom-left: work on shuttle
    tmux select-pane -t 0
    tmux split-window -v -l 25 'ssh shuttle'
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

# 3-pane layout on the dev host for free usage
_tmux_dev () {
    tmux new-window -n "Develop"
    tmux split-window -h -l 100 'ssh devel'
    tmux split-window -t 1 -v 'ssh devel'
    tmux select-pane -t 0
    tmk 'ssh devel'
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
