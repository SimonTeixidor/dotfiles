#!/bin/bash
DEST=$1

if [ "$DEST" == "" ]; then
	echo "You must provide a parameter!"
	exit -1
fi

mkdir -p "$DEST/bin"

wget https://raw.githubusercontent.com/tlvince/prowler/master/prowler -O "$DEST/bin/prowler"
chmod +x "$DEST/bin/prowler"

cp -r prowler "$DEST/.config"

cp misc/xinitrc $DEST/.xinitrc

cp scripts/startdwm $DEST/bin/
cp scripts/status $DEST/bin/
cp scripts/search-order-by-deps.sh $DEST/bin/
cp scripts/mpdinfo.sh $DEST/bin/

if [ ! -d "$DEST/.config/vim" ]; then
	mkdir -p "$DEST/.config/vim/"
fi

cp vim/vimrc $DEST/.config/vim/
cp vim/xdg.vim $DEST/.config/vim/

if [ ! -d "$DEST/.config/dircolors" ]; then
	mkdir -p "$DEST/.config/dircolors"
fi
cp bash/dircolors $DEST/.config/dircolors/config

cp bash/profile $DEST/.bashrc
echo ". ~/.bashrc" > $DEST/.bash_profile
cp -r tmux $DEST/.config/

cp -r X11 $DEST/.config

if [ ! -d "$DEST/.config/readline" ]; then
	mkdir "$DEST/.config/readline"
fi
cp misc/inputrc $DEST/.config/readline/

mkdir -p "$DEST/.local/share"
wget https://www.toptal.com/designers/subtlepatterns/patterns/moroccan-flower.png -O "$DEST/.local/share/wall.png"
cp misc/user-dirs.dirs $DEST/.config/
cp -r misc/npm $DEST/.config
cp -r gtk-3.0 $DEST/.config/
cp -r deadbeef $DEST/.config/
cp -r gnupg $DEST/.config/
cp -r ncmpc $DEST/.config/
cp -r python $DEST/.config/
