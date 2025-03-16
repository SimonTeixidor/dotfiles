#!/bin/bash
bind '"\e[A": history-search-backward' 2>/dev/null
bind '"\e[B": history-search-forward' 2>/dev/null
bind '"\C-[OA": history-search-backward' 2>/dev/null
bind '"\C-[OB": history-search-forward' 2>/dev/null

export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
