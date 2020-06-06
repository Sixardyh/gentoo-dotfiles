#!/bin/sh
cd ~/.config/herbstluftwm

backlight_off() {
	xbacklight -get > .backlight_level
	xbacklight -set 0
}

backlight_on() {
	level="$(cat .backlight_level)"
	xbacklight -set "$level"
	rm .backlight_level
}

test -e .backlight_level && backlight_on || backlight_off
