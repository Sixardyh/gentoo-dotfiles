#!/bin/sh
hc() {
	herbstclient "$@"
}

xrandr --output DisplayPort-0 --off
hc remove_monitor 0 1 2
sleep 0.1
xrandr --output HDMI-A-0 --mode 1920x1080 --rate 60
hc set_monitors 1920x1080+0+0
hc pad 0 20 "" ""


# replace with name of your last tag
tag="flt"

# change to match your resolution
res="1920x1080"

# change to match your padding
pad="20 0 0 0"

if [ "$a" == "" ]; then
	herbstclient floating $tag on

	herbstclient add_monitor $res $tag two

	herbstclient pad two $pad

	herbstclient lock_tag two
fi

nitrogen --head=0 --set-zoom-fill /home/cyril/Pictures/papes/dual/bridge_boat.jpg

