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
