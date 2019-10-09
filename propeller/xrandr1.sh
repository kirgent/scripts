#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

master="eDP-1-1"
slave="DP-1-3"
xrandr --output $master --primary --auto --mode 1920x1080 --output $slave --off

xrandr|egrep "\*| connected"