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
for box in ${RACK[@]}; do $cmd $box "$var g"; done; check_health; sleep 10
for j in {1..15}; do
echo ====== iteration=$i, j=$j left iteration ======
for box in ${RACK[@]}; do $cmd $box "$var l"; done; check_health; sleep 5
done
for k in {1..730}; do
echo ====== iteration=$i, k=$k right iteration ======
for box in ${RACK[@]}; do $cmd $box "$var r"; done; check_health; sleep 5
done

for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; timestamp=`date "+%d.%m.%Y %H:%M"`; sleep 20
check_pattern "$timestamp.*key_released" "getInfoBarker - title:"
check_power_status "$1" "2"
i=$(($i+1))
done
