#!/bin/bash
# Terminate already running bar instances
killall -q polybar
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --config=/home/e18m/.config/polybar/config.ini --reload main &
  done
else
  polybar --reload example &
fi
