#!/bin/sh

cd ~/.config/herbstluftwm/

deactivate() {
	killall -15 compton
	touch .compositing_deactivated
}

activate() {
	compton -CGb
	rm .compositing_deactivated
}

test -e .compositing_deactivated && activate || deactivate
