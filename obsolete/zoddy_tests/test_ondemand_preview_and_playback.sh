#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

wait_overall_boot_progress "$1"

preconditions "$0"

for ip in ${RACK[@]}; do $cmd $ip "$var od"; done; sleep 5
# Movies->Movies A-Z->ABCDE->asset MI
for ip in ${RACK[@]}; do $cmd $ip "$var d"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; sleep 7
for ip in ${RACK[@]}; do $cmd $ip "$var d"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; sleep 7
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; sleep 7
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; check_health; sleep 7

i=1
while true; do
echo "iteration=$i"
# preview start + ff 2x => preview is finished
for ip in ${RACK[@]}; do $cmd $ip "$var d"; done; sleep 5
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; sleep 10
for ip in ${RACK[@]}; do $cmd $ip "$var ff"; done; sleep 5
for ip in ${RACK[@]}; do $cmd $ip "$var ff"; done; check_health; sleep 35
# try to order and playback => ff 3x + stop
for ip in ${RACK[@]}; do $cmd $ip "$var d"; done; sleep 7
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; sleep 10
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; sleep 10
for ip in ${RACK[@]}; do $cmd $ip "$var 0,0,0,0"; done; check_health; sleep 13
for ip in ${RACK[@]}; do $cmd $ip "$var ff"; done; sleep 5
for ip in ${RACK[@]}; do $cmd $ip "$var ff"; done; check_health; sleep 5
for ip in ${RACK[@]}; do $cmd $ip "$var ff"; done; sleep 120
for ip in ${RACK[@]}; do $cmd $ip "$var stop"; done; check_health; sleep 15
# change to the next asset
for ip in ${RACK[@]}; do $cmd $ip "$var u"; done; sleep 7
for ip in ${RACK[@]}; do $cmd $ip "$var u"; done; sleep 7
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; check_health; sleep 10

check_power_status "$1" "2" "od"
i=$(($i+1))
done
