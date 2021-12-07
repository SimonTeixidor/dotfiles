#!/bin/sh

set -eu

DEST=$1

if [ "$DEST" == "" ]; then
	echo "You must provide a parameter!"
	exit -1
fi

# Copy config directory
mkdir -p "$DEST/.config"
cp -r config/* "$DEST/.config"

# Copy scripts, and download prowler
mkdir -p "$DEST/bin"
cp scripts/* $DEST/bin/

# Download wallpaper
mkdir -p "$DEST/.local/share"
curl -L https://i.redd.it/pjvic9eq4vt41.jpg > "$DEST/.local/share/wall.jpg"
