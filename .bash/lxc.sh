lxcs () {
    container=$1; shift 1
    screen -dmS $container -- lxc-start -F -o /var/log/lxc/$container.log -l info -n $container
}

lxct () {
    container=$1; shift 1
    tmux new-session -s $container -d -- lxc-start -F -o /var/log/lxc/$container.log -l info -n $container
}

runsin () {
    local pid quiet

    while getopts "q" opt; do
	case $opt in
	    q) quiet=1 ;;
	    *)
		echo "Usage: runsin [-q] PID..."
		exit 1
		;;
	esac
    done
    shift $(( $OPTIND - 1 ))
    OPTIND=0

    for pid in "$@"; do
	[ -z "$quiet" ] && echo -n "Process $pid runs in "
	find /sys/fs/cgroup/cpuset/lxc -name 'cgroup.procs' | \
	    xargs grep $pid | \
	    cut -d/ -f7 || \
	    ( [ -z "$quiet" ] && echo "no container" )
    done
}
