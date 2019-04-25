#!/bin/sh
DEST=$1

if [ "$DEST" == "" ]; then
	echo "You must provide a parameter!"
	exit -1
fi

cp mpd/mpdconf $DEST/.mpdconf

if [ ! -d "$DEST/.config/X11/" ]; then
	mkdir "$DEST/.config/X11/"
fi
cp urxvt/Xdefaults $DEST/.config/X11/Xresources

if [ ! -d "$DEST/.config/ncmpcpp/" ]; then
	mkdir "$DEST/.config/ncmpcpp/"
fi
cp -r ncmpcpp $DEST/.config/ncmpcpp

wget https://raw.githubusercontent.com/xero/sourcerer/master/sourcerer.vim -O $DEST/.config/vim/colors/sourcerer.vim

wget https://raw.githubusercontent.com/tlvince/prowler/master/prowler -O "$DEST/bin/prowler"
chmod +x "$DEST/bin/prowler"

cp -r prowler "$DEST/.config"

cp misc/xinitrc $DEST/.xinitrc

cp scripts/startdwm $DEST/bin/
cp scripts/status $DEST/bin/
cp scripts/search-order-by-deps.sh $DEST/bin/
cp scripts/adblock-update.sh $DEST/bin/

if [ ! -d "$DEST/.config/vim" ]; then
	mkdir -p "$DEST/.config/vim/"
fi
cp vim/vimrc $DEST/.config/vim/
cp vim/xdg.vim $DEST/.config/vim/

if [ ! -d "$DEST/.config/dircolors" ]; then
	mkdir -p "$DEST/.config/dircolors"
fi
cp bash/dircolors $DEST/.config/dircolors/config

cp bash/profile $DEST/.bash_profile
cp -r tmux $DEST/.config/

if [ ! -d "$DEST/.config/vimperator" ]; then
	mkdir -p "$DEST/.config/vimperator/"
fi
cp -r vimperator/colors $DEST/.config/vimperator/
cp -r vimperator/gohu.vimp $DEST/.config/vimperator/
cp vimperator/vimperatorrc $DEST/.config/vimperator/vimperatorrc

if [ ! -d "$DEST/.local/share/fonts" ]; then
	mkdir -p "$DEST/.local/share/fonts"
fi

wget https://github.com/koemaeda/gohufont-ttf/raw/master/gohufont-11.ttf -O "$DEST/.local/share/fonts/gohufont-11.ttf"

mkfontdir $DEST/.local/share/fonts
mkfontscale $DEST/.local/share/fonts

cp xmodmap/Xmodmap $DEST/.config/X11/Xmodmap

if [ ! -d "$DEST/.config/readline" ]; then
	mkdir "$DEST/.config/readline"
fi
cp misc/inputrc $DEST/.config/readline/

cp misc/wall.png $DEST/.local/share/
cp misc/user-dirs.dirs $DEST/.config/
cp -r misc/npm $DEST/.config
cp -r gtk-3.0 $DEST/.config/
