y () {
    local tmp="$( mktemp -t "yazi-cwd.XXXXXX" )"
    local cwd

    yazi "$@" --cwd-file="$tmp"
    cwd=$( cat "$tmp" )
    rm "$tmp"

    [[ -n "$cwd" && "$cwd" != "$PWD" ]] && cd -- "$cwd"
}
