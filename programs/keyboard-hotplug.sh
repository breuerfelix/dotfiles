#!/usr/bin/bash

export DISPLAY=:0
export XAUTHORITY=/home/felix/.Xauthority

su felix -c "setxkbmap -option \"ctrl:nocaps,altwin:alt_win,grp:shifts_toggle\" -layout \"eu\"" &
