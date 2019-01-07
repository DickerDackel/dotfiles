TIER="prod"
[[ $HOSTNAME =~ -(stage|int)- ]] && TIER="int"
[[ $HOSTNAME =~ -(test|testing)- ]] && TIER="test"

RED="\033[01;31m"
GREEN="\033[01;32m"
YELLOW="\033[01;33m"
BLUE="\033[01;34m"
NOCOLOR="\033[m"

HOSTCOLOR=$RED
[ "$TIER" == "int" ] && HOSTCOLOR=$YELLOW
[ "$TIER" == "test" ] && HOSTCOLOR=$GREEN

USERCOLOR=$RED
[[ ${EUID} != 0 ]] && USERCOLOR=$GREEN

PS1="${USERCOLOR}\\u${NOCOLOR}@${HOSTCOLOR}\\h${NOCOLOR}:\\w\\$ "
