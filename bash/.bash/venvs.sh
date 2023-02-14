#alias venv='. ./bin/activate'

venv () {
    local v

    for d in venv .venv .; do
	if [ -d $d ]; then
	    . $d/bin/activate
	    break
	fi
    done
}

mkv () {
    if [ $# == 1 ]; then
	python -m venv "$1"
    else
	python -m venv .venv --prompt $( basename $( readlink -f $PWD ) )
    fi
}
