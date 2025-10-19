#!/bin/sh

killall -q polybar

#polybar 2>&1 | tee -a /tmp/polybar.log & disown

for m in $(polybar --list-monitors | cut -d":" -f1); do
    #MONITOR=$m polybar topbar -c topbar &
    #MONITOR=$m polybar bottombar -c bottombar &
    MONITOR=$m polybar --reload example &
done
