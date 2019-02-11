#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

wait_overall_boot_progress "$1"

preconditions "$0"

i=1
while true; do
echo "iteration i=$i"
for ip in ${RACK[@]}; do $cmd $ip "$var od"; done; check_health; sleep 3
for ip in ${RACK[@]}; do $cmd $ip "$var c+"; done; check_health; sleep 3
check_power_status "$1" "2" "od"
i=$(($i+1))
done
