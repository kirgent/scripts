#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

wait_overall_boot_progress "$1"

preconditions "$0"

for box in ${RACK[@]}; do $cmd $box "$var 2"; done; check_health; sleep 5
#for box in ${RACK[@]}; do $cmd $box "$var g" 2>/dev/null|$logger; done; check_health; sleep 5

for box in ${RACK[@]}; do $cmd $box "$var pause"; done; check_health; sleep 5

while true; do

i=1
while [ $i -le 60 ]; do
echo "iteration=$i"
for box in ${RACK[@]}; do $cmd $box "$var rew"; done; check_health; sleep 1
i=$(($i+1))
done

i=1
while [ $i -le 60 ]; do
echo "iteration=$i"
for box in ${RACK[@]}; do $cmd $box "$var ff"; done; check_health; sleep 1
i=$(($i+1))
done

check_power_status "2"
i=$(($i+1))
done
