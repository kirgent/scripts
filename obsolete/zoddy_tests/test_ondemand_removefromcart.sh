#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

wait_overall_boot_progress "$1"

preconditions "$0"

for ip in ${RACK[@]}; do $cmd $ip "$var od"; done; sleep 5
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; sleep 5
for ip in ${RACK[@]}; do $cmd $ip "$var r"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; sleep 5
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; check_health; sleep 5

i=1
while true; do
for (( k=1; k<=300; k++ )); do
echo "iteration i=$i, k=$k"
# focus to Remove from Cart -> Select
for (( m=1; m<=3; m++ )); do for ip in ${RACK[@]}; do $cmd $ip "$var d"; done; check_health; done
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; check_health; sleep 5
# go back(left) to list
for ip in ${RACK[@]}; do $cmd $ip "$var l"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; check_health; sleep 5
done

check_power_status "$1" "2" "od"
i=$(($i+1))
done
