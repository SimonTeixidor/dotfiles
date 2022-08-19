#!/bin/sh
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/tmp/$(id -u)-runtime}" 
[ -d "$XDG_RUNTIME_DIR" ] || { 
    mkdir -p   "$XDG_RUNTIME_DIR" 
    chmod 0700 "$XDG_RUNTIME_DIR"
}
pipewire >/dev/null 2>&1 &
pipewire-pulse >/dev/null 2>&1 &
XDG_CURRENT_DESKTOP=river XKB_DEFAULT_OPTIONS=grp:shifts_toggle,caps:escape XKB_DEFAULT_LAYOUT=us,se dbus-run-session river
