#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

wait_overall_boot_progress "$1"

preconditions "$0"

for ip in ${RACK[@]}; do $cmd $ip "$var 7,2,7"; done; check_health; timestamp=`TZ='America/New_York' date "+%d.%m.%Y %H:%M"`; sleep 20
wait_activation_timeshift_buffering "$timestamp.*key_released" " activation timeshift buffering" "$1"

i=1
while true; do
echo "iteration=$i"
for ip in ${RACK[@]}; do $cmd $ip "$var play"; done; sleep 4
for ip in ${RACK[@]}; do $cmd $ip "$var live"; done; check_health; sleep 4 

check_power_status "$1" "7,2,7"
i=$(($i+1))
done
