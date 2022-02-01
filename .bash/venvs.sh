alias activate="source .venv/bin/activate"

mkvenv () {
    name=$( basename $PWD )
    python -m venv --prompt "$name" .venv
    activate
}
