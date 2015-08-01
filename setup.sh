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
	wget https://presentingsweden.si.se/wp-content/uploads/sites/7/2013/07/palme_castro.jpg -O $DEST/.wall.jpg
fi

if [ ! -d "$DEST/.fonts" ]; then
	mkdir "$DEST/.fonts"
fi
if [ ! -d "$DEST/.config/fontconfig" ]; then
	mkdir "$DEST/.config/fontconfig"
fi
cp fonts/fonts.conf $DEST/.config/fontconfig
wget http://www.bok.net/MonteCarlo/downloads/MonteCarlo-PCF.tgz -O $DEST/.fonts/MonteCarlo-PCF.tgz
wget http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/crosextrafonts-carlito-20130920.tar.gz -O  $DEST/.fonts/carlito.tar.gz
wget http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/croscorefonts-1.23.0.tar.gz -O $DEST/.fonts/croscore.tar.gz
tar zxfv $DEST/.fonts/MonteCarlo-PCF.tgz -C $DEST/.fonts/
tar zxfv $DEST/.fonts/croscore.tar.gz -PCF.tgz -C $DEST/.fonts/
tar zxfv $DEST/.fonts/carlito.tar.gz -PCF.tgz -C $DEST/.fonts/
mv $DEST/.fonts/MonteCarlo-PCF/* $DEST/.fonts/
mv $DEST/.fonts/crosextrafonts-carlito-20130920/* $DEST/.fonts/
mv $DEST/.fonts/croscorefonts-1.23.0/* $DEST/.fonts/
rm -rf $DEST/.fonts/MonteCarlo-PCF $DEST/.fonts/MonteCarlo-PCF.tgz $DEST/.fonts/croscorefonts-1.23.0/ \
	$DEST/.fonts/crosextrafonts-carlito-20130920/ $DEST/.fonts/carlito.tar.gz $DEST/.fonts/croscore.tar.gz
mkfontdir $DEST/.fonts
mkfontscale $DEST/.fonts

cp xmodmap/Xmodmap $DEST/.Xmodmap
cp xbindkeys/xbindkeysrc $DEST/.xbindkeysrc
