#!/usr/bin/env zsh
for file in ~/.config/zsh/zshrc.d/*.sh; do
    [ -r "$file" ] && . "$file"
done
