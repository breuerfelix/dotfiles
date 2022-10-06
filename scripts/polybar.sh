#!/run/current-system/sw/bin/bash

# Terminate already running bar instances
pkill polybar

# start polybar on all monitors
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar bar &
done
