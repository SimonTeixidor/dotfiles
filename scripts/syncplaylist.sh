#!/bin/bash
rm -r /tmp/playlists
scp -r $HOST:playlists /tmp/
mv /tmp/playlists/imported.m3u /tmp/playlists/imported-`date +%Y-%m-%d`.m3u
for f in /tmp/playlists/*m3u; do
	sed -i -e 's/^/\/mnt\/storage\/music\//' "$f"
	cp "$f" ~/playlists/
done
