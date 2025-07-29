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
export LESS=-isSXRF
export PAGER=less

for dir in \
    ~/.local/bin \
    /opt/*/bin \
    /usr/local/bin \
    /sbin \
    /usr/sbin
do
    [ -d $dir ] && PATH=$dir:$PATH
done
command -v path-cleanup >/dev/null 2>&1 && PATH=$( path-cleanup $PATH )
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

if command -v nvim >/dev/null 2>&1; then
    export EDITOR=nvim
    alias vi=nvim
    alias vimdiff='nvim -d'
else
    export EDITOR=vim
    alias vi=vim
fi

# Source all functions
for f in ~/.bash/*; do
    . $f
done

[ -f /usr/share/fzf/shell/key-bindings.bash ] && . /usr/share/fzf/shell/key-bindings.bash

[ -f ~/.settings.$HOSTNAME ] && . ~/.settings.$HOSTNAME
