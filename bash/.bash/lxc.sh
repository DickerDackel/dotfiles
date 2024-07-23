# lxc console monitor
lcons () {
    hostname=$1; shift 1
    while ! screen -x $hostname; do
        sleep 1
    done
}
