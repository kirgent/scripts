#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

#wait_overall_boot_progress "$1"

preconditions "$0"

while true; do
for ip in ${RACK[@]}; do $cmd $ip "$var search"; done; sleep 5
for ip in ${RACK[@]}; do $cmd $ip "$var e"; done
for ip in ${RACK[@]}; do $cmd $ip "$var e"; done
for ip in ${RACK[@]}; do $cmd $ip "$var e"; done; check_health
done 
