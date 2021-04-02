lxsession &
picom --experimental-backend &
xrandr --output HDMI-0 --mode 1920x1080 --output HDMI-1-1 --mode 1920x1080 --right-of HDMI-0 &
nitrogen --restore &
redshift -O 2500K &
nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }" &
sxhkd &
dunst &
unclutter --timeout 1 &
xset r rate 300 40 &
setxkbmap -layout us &
nm-applet &
mpd &
mpDris2 &

exec qtile
