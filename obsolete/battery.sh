#!/bin/bash

BAT="/org/freedesktop/UPower/devices/battery_BAT0"


while true; do
state=`upower -i $BAT | egrep  "state:" | awk '{print $NF}'`
percent=`upower -i $BAT | egrep "percentage:" | awk '{print $NF}' | sed -e "s/%//"`
if [[ $percent -lt 10 && $state == "discharging" ]]; then
	color="red"
	echo "color: $color and state: $state"
else
	color="green"
	echo "color: $color and state: $state"
fi


echo "`upower -i $BAT | egrep 'state:|percentage:|time to empty:|time to full:'|sed -e 's/  //g'`" | osd_cat --pos bottom --offset 10 --align right --color $color --delay 5 -f '-*-*-*-*-*-*-14-*-*-*-*-*-*'
#echo -e "$percent_remaining_capacity%\n$charging_state"|osd_cat --pos bottom --offset 10 --align right --color $color --delay 15 -f '-*-*-*-*-*-*-14-*-*-*-*-*-*'
done
