#!/bin/bash

output="$(herbstclient list_monitors | grep LOCKED)"
if echo "$output" | grep "FOCUS" ; then
  herbstclient cycle_monitor
else
  echo "$output" | awk '{print $1}' | xargs herbstclient focus_monitor
fi
