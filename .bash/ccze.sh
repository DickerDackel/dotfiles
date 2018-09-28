alias ccze='ccze -A -o nolookups'

ct () {
    local logs log

    for log in "$@"; do
	if [ -f "$log" ]; then
	    logs+=( "$log" )
	else
	    logs+=( "/var/log/$log" )
	fi
    done
    tail -F ${logs[@]} | ccze -A
}
