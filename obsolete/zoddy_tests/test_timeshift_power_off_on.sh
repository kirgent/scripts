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
# power off-on in live mode
for ip in ${RACK[@]}; do $cmd $ip "$var pwr"; done; sleep 10
for ip in ${RACK[@]}; do $cmd $ip "$var pwr"; done; check_health; sleep 30

# power off-on in pause mode
for ip in ${RACK[@]}; do $cmd $ip "$var pause"; done; sleep 3
for ip in ${RACK[@]}; do $cmd $ip "$var pwr"; done; sleep 10
for ip in ${RACK[@]}; do $cmd $ip "$var pwr"; done; check_health; sleep 60

# power off-on in slow motion mode
for ip in ${RACK[@]}; do $cmd $ip "$var play"; done; sleep 3
for ip in ${RACK[@]}; do $cmd $ip "$var pwr"; done; sleep 10
for ip in ${RACK[@]}; do $cmd $ip "$var pwr"; done; check_health; sleep 60

# power off-on in rewind mode
for ip in ${RACK[@]}; do $cmd $ip "$var rew"; done; sleep 3
for ip in ${RACK[@]}; do $cmd $ip "$var pwr"; done; sleep 10
for ip in ${RACK[@]}; do $cmd $ip "$var pwr"; done; check_health; sleep 30

# power off-on in fast forward mode
for ip in ${RACK[@]}; do $cmd $ip "$var pause"; done; sleep 30
for ip in ${RACK[@]}; do $cmd $ip "$var play"; done; sleep 3
for ip in ${RACK[@]}; do $cmd $ip "$var ff"; done; sleep 3
for ip in ${RACK[@]}; do $cmd $ip "$var pwr"; done; sleep 10
for ip in ${RACK[@]}; do $cmd $ip "$var pwr"; done; check_health; sleep 30

for ip in ${RACK[@]}; do $cmd $ip "$var c+"; done; check_health; timestamp=`TZ='America/New_York' date "+%d.%m.%Y %H:%M"`; sleep 25

check_pattern "$timestamp.*key_released" "getInfoBarker - title:" "$1"

check_power_status "$1" "3"
i=$(($i+1))
done
