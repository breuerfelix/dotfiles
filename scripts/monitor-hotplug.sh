#!/run/current-system/sw/bin/bash

export DISPLAY=:0
# change user
export XAUTHORITY=/home/felix/.Xauthority

function connect() {
    xrandr --output $1 --left-of eDP1 --auto
    i3 move workspace to output left
}

function disconnect() {
    xrandr --output $1 --off
}

function main() {
    # outputs to monitor
    for disp in 'DP2' 'HDMI2' ;
    do
        xrandr --query | grep "$disp connected" &> /dev/null && connect $disp || disconnect $disp
    done

    # restart wm and wallpaper
    i3 restart
    nitrogen --restore
}

# start it forked so the monitor is active
main &
