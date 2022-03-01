_activate_usage () {
    cat <<-EOF
	usage: activatet [venv]

	    venv		virtual env directory, default .venv or venv

	Activate virtualenv from venv
EOF
}

activate () {
    if [ $# == 1 ]; then
	venv=$1
    else
	for d in .venv venv; do
	    [ -d "$d" ] && venv="$d" && break
	done
	[ -z "$venv" ] && _activate_usage && return 1
    fi
    for d in bin Scripts; do
	[ -d "$venv/$d" ] && source "$venv/$d/activate" && break
    done
}
	
mkvenv () {
    name=$( basename $PWD )
    python -m venv --prompt "$name" .venv
    activate
}
