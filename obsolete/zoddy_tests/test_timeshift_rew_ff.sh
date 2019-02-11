#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

wait_overall_boot_progress "$1"

preconditions "$0"

for ip in ${RACK[@]}; do $cmd $ip "$var 7,2,7"; done; check_health; timestamp=`TZ='America/New_York' date "+%d.%m.%Y %H:%M"`; sleep 25
wait_activation_timeshift_buffering "$timestamp.*key_released" " activation timeshift buffering" "$1"

i=1
while true; do
echo "iteration=$i"
for ip in ${RACK[@]}; do $cmd $ip "$var rew,rew,rew,rew"; done; check_health; sleep 120
check_power_status "$1" "7,2,7"
for ip in ${RACK[@]}; do $cmd $ip "$var ff,ff,ff,ff"; done; check_health; sleep 120
check_power_status "$1" "7,2,7"

#i=`date +%M`
#while [ "$i" -ne 00 -o "$i" -ne 20 -o "$i" -ne 40 ]; do
#echo "poka ne 00 / 20 / 40, do: bla_bla_bla !!!"
#i=`date +%M`
#done

i=$(($i+1))
done
