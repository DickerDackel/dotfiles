shopt -s checkwinsize
shopt -s cdspell
shopt -s histappend
shopt -s histreedit
#shopt -s histverify
shopt -s hostcomplete
shopt -s huponexit
shopt -s no_empty_cmd_completion

export PS1='\h:\w\$ '
export HISTCONTROL=ignoreboth
export HISTSIZE=1073741824
export HISTFILESIZE=1073741824
export HISTTIMEFORMAT="%F %T "
export LESS=-isSXR
export PAGER=less
export EDITOR=vim

for dir in \
    /sbin \
    /usr/sbin \
    ~/.local/bin \
    ~/bin \
    /usr/local/bin \
    ~/opt/bin \
    /opt/*/bin
do
    [ -d $dir ] && PATH=$dir:$PATH
done
PATH=~/opt/bin:$PATH
export PATH

if [ -f ~/.dircolors ]; then
    eval `dircolors -b ~/.dircolors`
elif [ -f /etc/DIR_COLORS ]; then
    eval `dircolors -b /etc/DIR_COLORS`
else
    eval `dircolors -b`
fi

alias rm='rm -v'
alias mv='mv -v'
alias cp='cp -v'
alias ls='ls -F --color=tty'
alias ll='ls -lF --color=tty'
alias xls='ls -F --color=always'
alias xll='ls -lF --colors=always'
alias vi=vim
alias more=$PAGER
alias less=$PAGER
alias hd='hexdump -v -e "\"%06.6_ao  \"   16/1  \"%02x \" \"  \"" -e "16/1 \"%_p\" \"\n\""'

# for i in /etc/profile.d/*.sh; do
#     if [ -r "$i" ]; then
# 	if [ "${-#*i}" != "$-" ]; then
# 	    . "$i"
# 	else
# 	    . "$i" >/dev/null
# 	fi
#     fi
# done

# Source all functions
for f in ~/.bash/*; do
    . $f
done

[ -f ~/.settings.$HOSTNAME ] && . ~/.settings.$HOSTNAME
