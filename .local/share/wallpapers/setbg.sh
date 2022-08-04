#!/bin/sh
file=$(readlink -f "$1")
ext="${file##*.}"
cp "$file" "$XDG_DATA_HOME/wallpapers/wall"
xwallpaper --focus "$XDG_DATA_HOME/wallpapers/wall"
