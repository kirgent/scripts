#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

wait_overall_boot_progress "$1"

preconditions "$0"

for ip in ${RACK[@]}; do $cmd $ip "$var 2"; done; check_health; sleep 10
for ip in ${RACK[@]}; do $cmd $ip "$var g"; done; check_health; sleep 10

i=1
while true; do
echo "iteration=$i"
for ip in ${RACK[@]}; do $cmd $ip "$var d"; done; check_health; sleep 3
#for ip in ${TEST_RACK[@]}; do $cmd $ip "$var r"; done; check_health; sleep 10
#for ip in ${TEST_RACK[@]}; do $cmd $ip "$var l"; done; check_health; sleep 10
i=$(($i+1))
done
