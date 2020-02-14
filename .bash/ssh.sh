ssh-identify () {
    local auth_keys optstring OPTIND OPTARG

    auth_keys=~/.ssh/authorized_keys

    optstring="a:h"
    while getopts "$optstring" opt; do
	case "$opt" in
	    a)
		auth_keys=$OPTARG
		;;
	    h|*)
		cat <<-EOF
		    Usage: ssh-identify [-a alternative-authorized_keys-file] keys...
		    
		    Identifies which key was used to login from the hash
		    provided by the /var/log/secure log message.

		    sshd[...]: Accepted publickey for ... from ... port ... ssh2: RSA SHA256:__THIS_STRING__
EOF
		return 1
		;;
	esac
    done
    shift $(( $OPTIND - 1 ))

    for key in "$@"; do
	cat "$auth_keys" | cut -d\  -f2,3 | while read key comment; do
	    echo -n "$comment: "
	    echo "$key"		| \
		base64 -d		| \
		sha256sum		| \
		awk '{ print $1 }'	| \
		xxd -r -p		| \
		base64; done	| \
		grep "$key"
    done
}
