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
    for recipe in "$@"; do
	_tmux_$recipe
    done
}

tsk () {
    tmux send-keys "$@" C-j
}

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

_tmux_work () {
    tmux split-window -h
    tmux send-keys -t 1 sudo bash
    tmux send-keys -t 0 sudo bash
    tmux select-pane 0
}

_tmux_newhost () {
    # top right: small run shell
    tmux split-window -h -l 100 'ssh salt'
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

_tmux_test () {
    tmux new-window -n "test"
    tmux select-window -t test
    tmux send-keys C-l "ls -l" C-j
    tmux previous-window
    tmux send-keys C-l
}

_tmux_dev () {
    tmux new-window -n "Develop"
    tmux split-window -h -l 100 'ssh devel'
    tmux split-window -t 1 -v 'ssh devel'
    tmux select-pane -t 0
    tmk 'ssh devel'
}
