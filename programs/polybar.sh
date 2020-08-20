#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# start polybar on all monitors
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload bar &
done
