#!/bin/sh

TERMINALS_LAUNCHED=$1

if [[ TERMINALS_LAUNCHED -lt 3 ]] ; then
  TERMINALS_LAUNCHED=$((TERMINALS_LAUNCHED+1))
  hc cycle_frame 1
  xfce4-terminal -e "$0 $TERMINALS_LAUNCHED"
fi

cd
$SHELL

