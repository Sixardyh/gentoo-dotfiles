#!/bin/sh

while : ; do
herbstclient cycle_monitor
herbstclient list_monitors | grep -E 'FOCUS.*LOCKED' || break
sleep 0.01
continue
done
