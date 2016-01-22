XDEFAULTS="urxvt/Xdefaults"
USERCHROME="firefox/theme.css"
DWM="dwm-6.0/config.h"
COLOUR_REGEX="#[0-9,a-f,A-F]*"
BG=`grep "\*background: $COLOUR_REGEX" $XDEFAULTS | grep -o $COLOUR_REGEX`
SELECTED_FG=`grep "\*color15: $COLOUR_REGEX" $XDEFAULTS | grep -o $COLOUR_REGEX`
FG=`grep "\*color7: $COLOUR_REGEX" $XDEFAULTS | grep -o $COLOUR_REGEX`

sed -i 's/--bg-light: #[0-9,a-f,A-F]*;/--bg-light: '$BG';/g' $USERCHROME
sed -i 's/--bg-dark: #[0-9,a-f,A-F]*;/--bg-dark: '$BG';/g' $USERCHROME
sed -i 's/--fg-dark: #[0-9,a-f,A-F]*;/--fg-dark: '$FG';/g' $USERCHROME
sed -i 's/--fg-light: #[0-9,a-f,A-F]*;/--fg-light: '$SELECTED_FG';/g' $USERCHROME

sed -i 's/#define BG "#......"/#define BG "'$BG'"/g' $DWM
sed -i 's/#define FG "#......"/#define FG "'$FG'"/g' $DWM
sed -i 's/#define SELECTED_FG "#......"/#define SELECTED_FG "'$SELECTED_FG'"/g' $DWM
