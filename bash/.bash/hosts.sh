hosts () {
    while read -p "> " h; do host $h; done
}
