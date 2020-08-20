#!/usr/bin/bash

export DISPLAY=:0
export XAUTHORITY=/home/felix/.Xauthority

function connect() {
    xrandr --output $1 --left-of eDP1 --auto
    i3 move workspace to output left
}

function disconnect() {
    xrandr --output $1 --off
}

function main() {
    for disp in 'DP2' 'HDMI2' ;
    do
        xrandr --query | grep "$disp connected" &> /dev/null && connect $disp || disconnect $disp
    done

    # restart window manager
    i3 restart
}

# start it forked so the monitor is active
main &
