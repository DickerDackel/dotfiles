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
	python3 -m venv "$1"
	cd $1
	venv
    else
	python3 -m venv .venv --prompt $( basename $( readlink -f $PWD ) )
	venv
    fi
}
