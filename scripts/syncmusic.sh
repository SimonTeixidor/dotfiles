#!/bin/bash
rsync -av --progress --delete --rsh='ssh -c aes128-ctr -o Compression=no -x' \
	--rsync-path="ionice -c2 -n7 rsync" \
	$HOST:music \
	/mnt/storage/
syncplaylist.sh
