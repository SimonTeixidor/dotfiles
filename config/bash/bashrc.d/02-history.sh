#!/bin/bash
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\C-[OA": history-search-backward'
bind '"\C-[OB": history-search-forward'

export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
