dot () {
    local user rc

    user=$1; shift 1
    export HOME=$( getent passwd $user | cut -d: -f6 )

    for rc in $HOME/.bash_profile $HOME/.bash_login $HOME/.profile; do
	[ -f $rc ] && source $rc && return
    done
}
