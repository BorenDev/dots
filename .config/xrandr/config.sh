#!/bin/sh

monitor_count=$(xrandr -d :0 | grep " connected" | wc -l)

if [ $monitor_count -gt 1 ]; then
    #xrandr --output DP3 --auto --right-of eDP1
    #xrandr --output eDP1 --primary
    xrandr --output eDP1 --primary --mode 3840x2160 --pos 1920x0 --rotate normal --output DP1 --off --output DP2 --off --output DP3 --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
fi
