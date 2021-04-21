lxsession &
picom --experimental-backend &
sxhkd &
dunst &
unclutter --timeout 1 &
nm-applet &
mpd &

xrandr --output HDMI-0 --mode 1920x1080 --output HDMI-1-1 --mode 1920x1080 --right-of HDMI-0 &
hsetroot -root -full $HOME/.local/share/wall.jpg &
redshift -O 2500K &
nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }" &
xset r rate 300 40 &
setxkbmap -layout us &&

exec qtile
