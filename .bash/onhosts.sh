#!/bin/bash

onhosts () {
    local login host prompt verbose key opt logpfx sparse OPTARG OPTIND

    while getopts "f:u:psv" opt; do
	case $opt in
	    f) logpfx="${OPTARG}" ;;
	    u) login="${OPTARG}@" ;;
	    p) prompt=1 ;;
	    s) sparse=1 ;;
	    v) verbose=1 ;;
	    *)
		echo "Usage: onhosts [-f log-prefix] [-u user] [-p] [-v] [command params...]"
		return 1
		;;
	esac
    done
    shift $(( $OPTIND - 1 ))

    for host in $VHOSTS; do
	[ -v verbose ] && echo -e "${login}${host} - $@\n--------------------------------"

	if [ -v sparse ]; then
	    echo -ne "${login}${host}\t->\t"
	    term=''
	else
	    term="-t"
	fi

	if [ -n "$logpfx" ]; then
	    ssh $term "${login}${host}" "$@" | tee ${logpfx}.${host}
	else
	    ssh $term "${login}${host}" "$@"
	fi

	[ -v verbose ] && echo "--------------------------------"
	[ -v prompt ] && read -p "Press <return> to continue... " key
    done
}

cphosts () {
    for h in $VHOSTS; do
	scp "$@" $h:$PWD/
    done
}

pullhosts () {
    for h in $VHOSTS; do
	for f in "$@"; do
	    scp $h:$f $( basename $f )-$h
	done
    done
}

pcmd () {
    ssh $PEER "$@"
}

pcp () {
    scp "$@" $PEER:$PWD/
}

psync () {
    rsync -ahHxP "$@" ./ $PEER:$PWD/
}

async () {
    for h in $VHOSTS; do
	rsync -ahHxP "$@" ./ $h:$PWD/
    done
}

vh () {
    local n t
    t=()
    for n in "$@"; do
	eval "t+=( \$$n )"
    done
    VHOSTS="${t[@]}"
}
