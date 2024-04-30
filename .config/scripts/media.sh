#!/bin/bash
# PLAYING_ICON=${icon: -$(xrescat i3xrocks.label.mediaplaying "some icon")}
if pgrep -x "spotify" > /dev/null; then
    song_info=$(playerctl metadata --format '{{artist}} - {{title}}')
    if [ -n "$song_info" ]; then
        echo "$song_info"
    else
        echo "No media"
    fi
else
    echo ""
fi
