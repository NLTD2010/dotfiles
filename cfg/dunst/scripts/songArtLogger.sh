#!/bin/bash

tmp_dir="$HOME/.cache/dunst"
tmp_cover_path=$tmp_dir/$DUNST_ID.png
tmp_temp_path=$tmp_dir/temp.png

if [ ! -d $tmp_dir ]; then
	mkdir -p $tmp_dir
fi

artlink="$(playerctl -p spotify,$any,mpd,firefox,chromium,brave metadata mpris:artUrl | sed -e 's/open.spotify.com/i.scdn.co/g')"
artFromBrowser=$(playerctl metadata mpris:artUrl | sed 's/file:\/\///g')

if [ $(playerctl -p spotify,%any,firefox,chromium,brave,mpd metadata mpris:artUrl) ]; then
	curl -s "$artlink" --output $tmp_temp_path
elif [[ -n $artFromBrowser ]]; then
	cp $artFromBrowser $tmp_temp_path
fi

cp $tmp_temp_path $tmp_cover_path