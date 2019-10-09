#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

dev=/sys/class/backlight/intel_backlight/brightness

sudo chmod o+w $dev
current=$(cat /sys/class/backlight/intel_backlight/brightness)
if [ "$current" -lt 120000 ]
then
current=`expr $current + 10000`
echo $current > $dev
fi;

echo "$dev"
cat $dev