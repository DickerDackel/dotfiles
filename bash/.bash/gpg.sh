secpack () {
    recipient=$1; shift 1
    find "$@" | cpio -ovH crc | pgpe -fast -r $recipient | bzip2 -9v
}

seccheck() {
    bzcat "$@" | pgpv -f | cpio -it
}

secunpack () {
    bzcat "$@" | pgpv -f | cpio -idmv
}
