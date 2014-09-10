#!/bin/sh

DEST=$1

cp mpd/mpdconf $DEST/.mpdconf

if [ ! -d "$DEST/.ncmpcpp" ]; then
	mkdir "$DEST/.ncmpcpp"
fi

cp ncmpcpp/config $DEST/.ncmpcpp/

cp urxvt/Xdefaults $DEST/.Xdefaults

cp vim/vimrc $DEST/.vimrc

cp screen/screenrc $DEST/.screenrc
