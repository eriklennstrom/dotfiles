#!/bin/sh
case "$1" in 
  DP) xrandr --output eDP-1 --off --output DP-3 --primary --mode 3440x1440 --rate 99Hz --output DP-1 --size 1920x1080 --rate 74Hz --rotate right --left-of DP-3 ;;
  LAPTOP) xrandr --output eDP-1 --primary --mode 1920x1200 --output DP-1 --off ;;
esac 
