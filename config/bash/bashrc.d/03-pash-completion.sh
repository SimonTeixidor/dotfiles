#!/bin/bash

_pash() {
	local cur prev words cword split
	_init_completion -s || return
	case "$prev" in
		add|copy|del|show)
			COMPREPLY=($(compgen -W "$(pash list 2>/dev/null)" -- "$cur"))
			return
			;;
	esac
	[ "$prev" == "pash" ] && COMPREPLY=($(compgen -W "add copy del list show tree" -- "$cur")) 
}

complete -F _pash pash
