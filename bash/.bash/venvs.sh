#alias venv='. ./bin/activate'

venv () {
    local v

    for d in venv .venv .; do
	[ -d "$d" ] && . $d/bin/activate && break
    done
}

mkv () {
    if [ $# == 1 ]; then
	python3 -m venv "$1/.venv" --prompt "$1"
	cd $1
	venv
    else
	python3 -m venv .venv --prompt $( basename $( readlink -f $PWD ) )
	venv
    fi
}
