#!/bin/sh

DEST=$1

if [ "$DEST" == "" ]; then
	echo "You must provide a parameter!"
	exit -1
fi

cp mpd/mpdconf $DEST/.mpdconf
cp urxvt/Xdefaults $DEST/.Xdefaults

if [ ! -d "$DEST/.ncmpcpp" ]; then
	mkdir "$DEST/.ncmpcpp"
fi

if [ ! -d "$DEST/.vim/colors" ]; then
	mkdir -p "$DEST/.vim/colors"
fi

wget https://raw.githubusercontent.com/xero/sourcerer/master/sourcerer.vim -O $DEST/.vim/colors/sourcerer.vim

cd dwm-6.0
make
if [ ! -d "$DEST/bin" ]; then
	mkdir "$DEST/bin"
fi
cp dwm $DEST/bin
cd ..

cp misc/xinitrc $DEST/.xinitrc

cp scripts/startdwm $DEST/bin/

cp vim/vimrc $DEST/.vimrc

cp bash/dircolors $DEST/.dircolors

cp screen/screenrc $DEST/.screenrc

cp bash/profile $DEST/.profile

cp -r ncmpc $DEST/.ncmpc

if [ ! -d "$DEST/.vimperator" ]; then
	mkdir -p "$DEST/.vimperator/"
fi
cp -r vimperator/colors $DEST/.vimperator/
cp -r vimperator/ohsnap.vimp $DEST/.vimperator/
cp vimperator/vimperatorrc $DEST/.vimperatorrc


if [ ! -d "$DEST/.wall.jpg" ]; then
	wget http://i.imgur.com/SaDyvKE.jpg0 -O $DEST/.wall.jpg
fi

if [ ! -d "$DEST/.fonts" ]; then
	mkdir "$DEST/.fonts"
fi
wget https://github.com/koemaeda/gohufont-ttf/raw/master/gohufont-11.ttf -O "$DEST/.fonts/gohufont-11.ttf"
mkfontdir $DEST/.fonts
mkfontscale $DEST/.fonts

cp xmodmap/Xmodmap $DEST/.Xmodmap
cp xbindkeys/xbindkeysrc $DEST/.xbindkeysrc
