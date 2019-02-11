#!/bin/bash
echo "`date` - $0 $1" >> log.log
# work pc
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg
# sun_server / home_pc
elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg
fi

wait_overall_boot_progress "$1"

wait_activation_timeshift_buffering

if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi
for box in ${RACK[@]}; do $cmd $box "dal status" 2>/dev/null|grep --color=always -i -E "DVBS_FIRMWARE_VERSION|SUPERVISOR_VERSION" >> log.log; done
for box in ${RACK[@]}; do $cmd $box "log set all 6" 2>/dev/null; done; check_health; sleep 1
for box in ${RACK[@]}; do $cmd $box "log_buffer 8192" 2>/dev/null; done; check_health; sleep 1
for box in ${RACK[@]}; do $cmd $box "onyxset set block" 2>/dev/null; done; check_health; sleep 1

for box in ${RACK[@]}; do $cmd $box "$var e" 2>/dev/null|$logger; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var 1,9,5"; done; check_health; timestamp=`date "+%d.%m.%Y %H:%M"`; sleep 20
check_pattern "$timestamp.*key_released" "getInfoBarker - title:"

i=1
while true; do
echo "iteration=$i"
for box in ${RACK[@]}; do $cmd $box "$var pause" 2>/dev/null|$logger; done; check_health; sleep 50
for box in ${RACK[@]}; do $cmd $box "$var play" 2>/dev/null|$logger; done; check_health; sleep 50
for box in ${RACK[@]}; do $cmd $box "$var rew" 2>/dev/null|$logger; done; check_health; sleep 50
for box in ${RACK[@]}; do $cmd $box "$var ff" 2>/dev/null|$logger; done; check_health; sleep 50

i=$(($i+1))
done
