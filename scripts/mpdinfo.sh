#!/bin/sh

MUSICDIR=~/media/
COLS=51
IMG_WIDTH=$((COLS*6+1))
ROWS=$((IMG_WIDTH/12))
LINEBEGIN=`printf "\033[34m*\033[0m"`

info_text() {
	FILE="$1"
	if [ "$FILE" = "$MUSICDIR" ]; then
		return
	fi

	TAGS=`metaflac --show-tag=composer --show-tag=work \
		--show-tag=opus  --show-tag=conductor \
		--show-tag=ensemble --show-tag=performer --show-tag=label \
		--show-tag=recordingdate --show-tag=recordinglocation \
		--show-tag=rating "$FILE"`
	CURKEY=
	echo "$TAGS" | format_grouped
	tput civis
}

# Reads input in key=val format, and outputs in a format like:
# key1:
#   * val 1
#   * val 2
# key2:
#   * val 3
format_grouped() {
	CURKEY=
	while IFS='=' read -r key val; do
		KEY=`echo "$key" | tr a-z A-Z`
		[ "$CURKEY" = "$key" ] || { CURKEY="$key"; printf "\033[1;32m$key:\033[0m\n"; }
		echo "$LINEBEGIN $val" | fold -s -w $((COLS-4)) | while read l; do 
		case $l in
			"$LINEBEGIN"*)
				echo "  $l"
				;;
			*)
				echo "    $l"
				;;
		esac
	done
done
}

image_dimensions() {
	file "$1" | awk -v w=$IMG_WIDTH '{
		match($0, /, ([0-9]+) ?x ?([0-9]+)/, arr);
		printf("%dx%d", w, int(arr[2]*w/arr[1]));
	}'
}

update_image() {
	pgrep -s $PPID sxiv | while read pid; do kill $pid; done
	COVER_PATH="$1"
	echo $COVER_PATH
	[ "$COVER_PATH" = "" ] && return 0
	image_dimensions "$COVER_PATH" | {
		read dimensions
		sxiv -s w -g $dimensions+2+2 -e $WINDOWID -b "$COVER_PATH" &
	}
}

find_coverart() {
	FILE="$1"
	if [ "$FILE" = "$MUSICDIR" ]; then
		return
	fi

	DIR=${FILE%/*}
	for cover in "$DIR"/cover.jpg "$DIR"/cover*; do
		[ -e "$cover" ] || continue
		echo "$cover"
		return 0
	done
}

update() {
	FILE="$MUSICDIR"`mpc current --format='%file%'`
	find_coverart "$FILE" | { read cover; update_image "$cover"; }
	tmux resize-pane -t 0 -x $COLS -y $ROWS
	clear
	for i in `seq 0 $ROWS`; do echo; done
	tput lines | {
		read lines
		info_text "$FILE" | head -n $((lines - ROWS - 2))
	}
}

trap update WINCH

while true
do
	update
	mpc current --wait &
	MPC_PID=$!
	wait $MPC_PID || kill $MPC_PID
done
