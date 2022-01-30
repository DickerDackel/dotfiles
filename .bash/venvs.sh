alias activate="source .venv/bin/activate"

mkvenv () {
    name=$( dirname $PWD )
    python -m venv --prompt "$name" .venv
    activate
}
