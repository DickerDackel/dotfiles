TIER="prod"
[[ $HOSTNAME =~ -(stage|int)- ]] && TIER="int"
[[ $HOSTNAME =~ -(test|testing)- ]] && TIER="test"

if [ -t 1 ]; then
    BOLD="$(tput bold)"
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    MAGENTA="$(tput setaf 5)"
    CYAN="$(tput setaf 6)"
    WHITE="$(tput setaf 7)"
    NOCOLOR="$(tput sgr0)"

    HOSTCOLOR="${BOLD}${RED}"
    [ "$TIER" == "int" ] && HOSTCOLOR="${BOLD}${YELLOW}"
    [ "$TIER" == "test" ] && HOSTCOLOR="${BOLD}${GREEN}"

    USERCOLOR="${BOLD}${RED}"
    [[ ${EUID} != 0 ]] && USERCOLOR="${BOLD}${GREEN}"

    PS1="\\[${USERCOLOR}\\]\\u@\\[${HOSTCOLOR}\\]\\h\\[${NOCOLOR}\\]:\\w\\$ "
else
    PS1='\h:\w\$ '
fi
