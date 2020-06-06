#!/bin/sh

cd ~/.config/herbstluftwm/

toggleoff() {
	herbstclient set frame_transparent_width 0
	rm .frame_borders_are_visible
}

toggleon() {
	herbstclient set frame_transparent_width 3
	touch .frame_borders_are_visible
}

test -e .frame_borders_are_visible && toggleoff || toggleon

