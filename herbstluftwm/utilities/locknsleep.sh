#!/bin/bash

dir=$HOME/.config/herbstluftwm/misc

import -window root $dir/screenshot.png
screenshot="$dir/screenshot.png"
lock="$dir/lock.png"
convert "$screenshot" -scale 10% -scale 1000% "$screenshot"
 
if [[ -f $lock ]]
then
    # placement x/y
    PX=0
    PY=0
    # lockscreen image info
    R=$(file $lock | grep -o '[0-9]* x [0-9]*')
    RX=$(echo $R | cut -d' ' -f 1)
    RY=$(echo $R | cut -d' ' -f 3)
 
    SR=$(xrandr --query | grep ' connected' | sed 's/primary //' | cut -f3 -d' ')
    for RES in $SR
    do
        # monitor position/offset
        SRX=$(echo $RES | cut -d'x' -f 1)                   # x pos
        SRY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 1)  # y pos
        SROX=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 2) # x offset
        SROY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 3) # y offset
        PX=$(($SROX + $SRX/2 - $RX/2))
        PY=$(($SROY + $SRY/2 - $RY/2))
 
        convert "$screenshot" $lock -geometry +$PX+$PY -composite -matte "$screenshot"
        echo "done"
    done
fi
i3lock -e -f -c '#000000' -i "$screenshot"
systemctl suspend

