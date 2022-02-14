#!/bin/bash

cleanpath () {
    local i_path o_path seen
    declare -A seen

    IFS=':' read -r -a i_path <<<"$PATH"

    for i in "${i_path[@]}"; do
	[ -z "$i" ] && continue
	[ -z "${seen[$i]}" ] && o_path+=( "$i" )
	seen[$i]=1
    done

    local IFS
    IFS=':'
    export PATH="${o_path[*]}"
}
cleanpath
