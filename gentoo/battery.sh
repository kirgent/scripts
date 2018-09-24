#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)
while true; do
cat /proc/acpi/battery/BAT0/{info,state}|grep -iE --color=always "(design|last full|remaining) capacity|(charging|capacity) state"
echo "====================================="
sleep 15
done
