#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

function check_capacity {
if [[ "$remaining_capacity" -gt "$warning_capacity" || "$charging_state" == "charging" ]]; then color="green"; else color="red"; fi

if [[ "$percent_remaining_capacity" -le "7" && "$charging_state" == "discharging" ]]; then
echo "percent_remaining_apacity is low, going to standby!"
~/scripts/gentoo/hibernate-ram_.sh
#else
#echo "percent_remaining_capacity=$percent_remaining_capacity"
fi
}

warning_capacity="`cat /proc/acpi/battery/BAT0/info|grep "design capacity warning"|awk '{print $+4}'`"

while true; do
last_full_capacity="`cat /proc/acpi/battery/BAT0/info|grep "last full capacity"|awk '{print $+4}'`"
remaining_capacity="`cat /proc/acpi/battery/BAT0/state|grep "remaining capacity"|awk '{print $+3}'`"
charging_state="`cat /proc/acpi/battery/BAT0/state|grep "charging state"|awk '{print $+3}'`"

#if [ "$charging_state" == "charging" ]; then
#battery_last_charge=`date +%s`
#echo "$battery_last_charge" > ~/scripts/gentoo/battery
#echo "0" > ~/scripts/gentoo/battery_minutes

#elif [ "$charging_state" == "discharging" ]; then
#battery_last_charge=`cat ~/scripts/gentoo/battery`
#fi

percent_remaining_capacity=$(($remaining_capacity * 100 / $last_full_capacity))
percent_warning_capacity=$(($warning_capacity * 100 / $last_full_capacity))

#battery_minutes=$(((`date +%s`-$battery_last_charge) / 60)))

#echo -e "persent_last_full_capacity=100%, last_full_capacity=$last_full_capacity\n\
#percent_remaining_capacity=$percent_remaining_capacity, remaining_capacity=$remaining_capacity\n\
#percent_warning_capacity=$percent_warning_capacity, warning_capacity=$warning_capacity\n---"

check_capacity

echo -e "$percent_remaining_capacity%\n$charging_state"|osd_cat --pos bottom --offset 10 --align right --color $color --delay 15 -f '-*-*-*-*-*-*-14-*-*-*-*-*-*'
done
