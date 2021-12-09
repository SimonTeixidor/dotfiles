#!/usr/bin/env zsh
ZSH_DATA_HOME="$XDG_DATA_HOME/zsh"
[ ! -d "$ZSH_DATA_HOME" ] && mkdir -p "$ZSH_DATA_HOME"
export HISTFILE="$ZSH_DATA_HOME/history"
export HISTSIZE=1000000000
export SAVEHIST=1000000000
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
