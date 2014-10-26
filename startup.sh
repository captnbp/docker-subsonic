#!/bin/sh
HOME=/subsonic
HOST=0.0.0.0
PORT=4040
CONTEXT_PATH=/
MAX_MEMORY=200
MUSIC_FOLDER=/music
PODCAST_FOLDER=/podcasts
PLAYLIST_FOLDER=/playlists


SUBSONIC_USER=downloads

export LANG=POSIX
export LC_ALL=en_US.UTF-8

/usr/bin/subsonic --home=$HOME \
                  --host=$HOST \
                  --port=$PORT \
                  --max-memory=$MAX_MEMORY \
                  --default-music-folder=$MUSIC_FOLDER \
		  --default-podcast-folder=$PODCAST_FOLDER \
                  --default-playlist-folder=$PLAYLIST_FOLDER
sleep 5
tail -f /subsonic/subsonic_sh.log
