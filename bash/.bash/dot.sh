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
Usage: dot-update [OPTIONS...]

Options are

  -v		rsync verbose
  -h		This help
  -n		rsync dry-run
  -p		git pull before updating
  -d DEST_DIR	Update DEST_DIR instead of '$HOME'

Note: It's mandatory, that your cwd is the dotfile repo!
EOF
}

dot-update () {
    local OPTARG OPTIND opt optstring verbose dry_run dest

    optstring="vhnpd:"
    dest=$HOME

    while getopts "$optstring" opt; do
	case $opt in
	    v) verbose='-P' ;;
	    p) git pull ;;
	    d) dest=${$OPTARG%%/} ;;
	    n) dry_run='-n' ;;
	    h|*)
		_dot-update-usage
		return
		;;
	esac
    done
    shift $(( $OPTIND - 1 ))

    [ ! -f "MANIFEST" ] && _dot-update-usage && return 1

    rsync -auhHx $verbose $dry_run --recursive --files-from=MANIFEST ./ "$dest"/
}
