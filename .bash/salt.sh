# Return list of hostnames as matched by salt
shn () {
    salt "$@" test.version --out=txt | sort | cut -d: -f1
}
