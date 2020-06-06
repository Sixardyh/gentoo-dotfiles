#!/bin/sh
xrandr --output VIRTUAL1 --off --output eDP1 --primary --mode 1600x900 --pos 2048x0 --rotate normal --output DP1 --mode 2048x1152 --pos 0x0 --rotate normal --output HDMI2 --off --output HDMI1 --off --output DP2 --off

nitrogen --head=-1 --set-zoom-fill /home/cyril/Pictures/Rainy_Night_City.jpg
xset r rate 300 60

