#!/bin/sh
export DISPLAY=:0
sleep 2

xrandr --output DVI-D-1 --mode 1920x1080 --rate 143.88 --pos 0x564 --primary
xrandr --output DP-2 --mode 1920x1080 --rate 59.96 --pos 1920x0 --rotate left
