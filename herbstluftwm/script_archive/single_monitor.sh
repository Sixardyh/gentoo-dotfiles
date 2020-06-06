#!/bin/sh
hc() {
	herbstclient "$@"
}

xrandr --output DP1 --off
xrandr --output HDMI2 --off
hc remove_monitor 1 2
sleep 0.1
xrandr --output eDP1 --mode 1600x900 --rate 60
hc set_monitors 1600x900+0+0
hc pad 0 0 "" ""
nitrogen --head=0 --set-zoom-fill /home/cyril/Pictures/Rainy_Night_City.jpg

