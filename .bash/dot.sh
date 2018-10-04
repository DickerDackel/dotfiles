dot () {
    local user rc

    user=$1; shift 1
    export HOME=$( getent passwd $user | cut -d: -f6 )

    for rc in $HOME/.bash_profile $HOME/.bash_login $HOME/.profile; do
	[ -f $rc ] && source $rc && return
    done
}

_dot-update-usage () {
    cat <<-EOF
Usage: dot-update [-v] [-p] [-d DEST]

  -v		Verbose
  -h		This help
  -p		git pull before updating
  -d DEST_DIR	Update DEST_DIR instead of '$HOME'

EOF
}

dot-update () {
    local OPTARG OPTIND opt optstring verbose dest

    optstring="vhpd:"
    dest=$HOME

    while getopts "$optstring" opt; do
	case $opt in
	    v) verbose='-P' ;;
	    p) git pull ;;
	    d) dest=${$OPTARG%%/} ;;
	    h|*)
		usage
		return
		;;
	esac
    done
    rsync "$@" -auhHx $verbose --recursive --files-from=MANIFEST ./ "$dest"/
}
