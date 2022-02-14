CCZEOPTS="-A -o nolookups"
alias ccze="ccze $CCZEOPTS"

ct () {
    local logs log

    for log in "$@"; do
	if [ -f "$log" ]; then
	    logs+=( "$log" )
	else
	    logs+=( "/var/log/$log" )
	fi
    done
    tail -F ${logs[@]} | ccze $CCZEOPTS
}

alias cj="journalctl -f $@ | ccze $CCZEOPTS"
