# Return list of hostnames as matched by salt
shn () {
    salt "$@" test.version --out=txt | sort | cut -d: -f1
}

cmdrun () {
    local optstring opt cmd user OPTARG OPTIND

    optstring="hnu:"
    while getopts "$optstring" opt; do
	echo "handling >$opt<"
	case $opt in
	    n)
		dryrun=1
		;;
	    u)
		user="runas=$OPTARG"
		;;
	    h|*)
		cat <<EOF
Usage: cmdrun [-u USER] COMMAND SALT-MATCH-OPTIONS...
EOF
		;;
	esac
    done
    shift $(( $OPTIND - 1 ))
    cmd=$1; shift 1

    if [ -n "$dryrun" ]; then
	echo "salt $@ cmd.run \"$cmd\" $user"
    else
	salt "$@" cmd.run "$cmd" $user
    fi
}
