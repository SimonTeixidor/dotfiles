#!/bin/bash

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
wget --quiet https://raw.githubusercontent.com/tlvince/prowler/master/prowler -O "$DEST/bin/prowler"
chmod +x "$DEST/bin/prowler"
cp scripts/* $DEST/bin/

# Copy bash config to home directory
cp -r bash/. $DEST/

# Download wallpaper
mkdir -p "$DEST/.local/share"
wget --quiet https://i.redd.it/pjvic9eq4vt41.jpg -O "$DEST/.local/share/wall.jpg"

# Copy keyboard bindings to system wide config
sudo cp -r xorg.conf.d /etc/X11/
