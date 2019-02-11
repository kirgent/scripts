#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

wait_overall_boot_progress "$1"

preconditions "$0"

for box in ${RACK[@]}; do $cmd $box "$var 2"; done; check_health; sleep 10

i=1
while true; do
echo "iteration=$i"
for box in ${RACK[@]}; do $cmd $box "$var search"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var pwr"; done; check_health; sleep 5
for box in ${RACK[@]}; do $cmd $box "$var pwr"; done; check_health; sleep 30
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15

check_power_status "2"
i=$(($i+1))
done
