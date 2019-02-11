#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

wait_overall_boot_progress "$1"

preconditions "$0"

timer=5
i=1
while true; do
echo "iteration=$i"
# 300 HBOD
for ip in ${RACK[@]}; do $cmd $ip "$var 3,0,0"; done; check_health; sleep $timer
# 320 SHOD
for ip in ${RACK[@]}; do $cmd $ip "$var 3,2,0"; done; check_health; sleep $timer
# 340 STZOD
for ip in ${RACK[@]}; do $cmd $ip "$var 3,4,0"; done; check_health; sleep $timer
# 350 STEOD
for ip in ${RACK[@]}; do $cmd $ip "$var 3,5,0"; done; check_health; sleep $timer
# 390 TMCOD
for ip in ${RACK[@]}; do $cmd $ip "$var 3,9,0"; done; check_health; sleep $timer
# 500 VOD
for ip in ${RACK[@]}; do $cmd $ip "$var 5,0,0"; done; check_health; sleep $timer
# 502 FOD
for ip in ${RACK[@]}; do $cmd $ip "$var 5,0,2"; done; check_health; sleep $timer
# Playboy
for ip in ${RACK[@]}; do $cmd $ip "$var 5,3,1"; done; check_health; sleep $timer
for ip in ${RACK[@]}; do $cmd $ip "$var 6,3,0"; done; check_health; sleep $timer
for ip in ${RACK[@]}; do $cmd $ip "$var 2"; done; check_health; sleep $timer

check_power_status "$1" "2" "od"
i=$(($i+1))
done
