#!/bin/bash
# /usr/local/bin/hlwm-monitor-setup...
# A simple bash script to set up external monitors for herbstluft
# Window Manager... Intended for use on a laptop.
# Different display configurations are handled via arguments.
# The first argument is the type of display in question (either
# square, widescreen-tv or widescreen-pc)
# The second argument is the display identifier used by "xrandr".
# This is generally "HDMI1" or "VGA1", however check the output of
# xrandr to see what displays are available. Also, previously, when I was
# still using siduction (based on Debian unstable), I had created a similar,
# more specialised script, which I had to alter after a pointless update changed
# the xrandr display identifier from "HDMI1" to "HDMI-1".
# Ah for flip's sake, would ya listen to me ramblin' on again! :)
if [[ -z $1 ]]; then
    echo "Error: Please emter the identifier assigned by
    xrandr to the display you wish to configure as the first argument."
    exit 1
fi
xrandr --output $1 --right-of LVDS1
case $2 in
    widescreen-tv)
        xrandr --output $1 --mode 1680x1050 ;;
    widescreen-pc)
        xrandr --output $1 --mode 1366x768 ;;
    square)
        xrandr --output $1 --mode 1024x768 ;;
    *)
        echo "Error: Please specify display type as the second argument...
        Available arguments are widescreen-tv (16:10),
        widescreen-pc (16:9) and square (4:3)"
        exit 1 ;;
esac
hc()
{
    herbstclient "$@"
}
hc detect_monitors
hc reload
