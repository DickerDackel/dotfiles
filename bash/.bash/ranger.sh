ranger () {
    fname=$( mktemp )
    trap "rm $fname" EXIT

    command ranger --choosedir=$fname "$@"
    dst=$( cat $fname )
    [[ -n "$dst" && -d "$dst" ]] && cd "$dst"
}
