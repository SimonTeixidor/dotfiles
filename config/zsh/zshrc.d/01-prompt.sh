#!/usr/bin/env zsh
#
autoload -U colors && colors
PS1="%{$fg[green]%}%{%B%}%~ \$ %{$reset_color%}%{%b%}"
if [ -n "$SSH_CLIENT" ]; then
  PS1="%n@%m $PROMPT"
fi
