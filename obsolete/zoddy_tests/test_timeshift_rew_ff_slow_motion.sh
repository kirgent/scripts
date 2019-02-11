#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

wait_overall_boot_progress "$1"

preconditions "$0"

for ip in ${RACK[@]}; do $cmd $ip "$var 3"; done; check_health; timestamp=`TZ='America/New_York' date "+%d.%m.%Y %H:%M"`; sleep 20
wait_activation_timeshift_buffering "$timestamp.*key_released" " activation timeshift buffering" "$1"

i=1
while true; do
echo "iteration=$i"
for ip in ${RACK[@]}; do $cmd $ip "$var rew,rew,rew,rew"; done; check_health; sleep 10

#for ip in ${RACK[@]}; do $cmd $ip "$var play"; done; check_health; sleep 1
for ip in ${RACK[@]}; do $cmd $ip "$var replay"; done; sleep 3
for ip in ${RACK[@]}; do $cmd $ip "$var replay"; done; sleep 3
for ip in ${RACK[@]}; do $cmd $ip "$var replay"; done; check_health; sleep 3

for ip in ${RACK[@]}; do $cmd $ip "$var replay"; done; sleep 3
for ip in ${RACK[@]}; do $cmd $ip "$var replay"; done; sleep 3
for ip in ${RACK[@]}; do $cmd $ip "$var replay"; done; check_health; sleep 3

for ip in ${RACK[@]}; do $cmd $ip "$var replay"; done; sleep 3
for ip in ${RACK[@]}; do $cmd $ip "$var replay"; done; sleep 3
for ip in ${RACK[@]}; do $cmd $ip "$var replay"; done; check_health; sleep 3

for ip in ${RACK[@]}; do $cmd $ip "$var ff,ff,ff,ff"; done; check_health; sleep 10

for ip in ${RACK[@]}; do $cmd $ip "$var live"; done; check_health;  sleep 5;

check_power_status "$1" "3"
i=$(($i+1))
done
