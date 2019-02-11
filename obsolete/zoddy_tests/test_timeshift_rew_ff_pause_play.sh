#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

wait_overall_boot_progress "$1"

preconditions "$0"

for ip in ${RACK[@]}; do $cmd $ip "$var 3"; done; check_health; timestamp=`TZ='America/New_York' date "+%d.%m.%Y %H:%M"`; sleep 25
wait_activation_timeshift_buffering "$timestamp.*key_released" " activation timeshift buffering" "$1"

i=1
while true; do
echo "iteration=$i"
# pause mode
for ip in ${RACK[@]}; do $cmd $ip "$var pause"; done; check_health; sleep 2
#playback mode
for ip in ${RACK[@]}; do $cmd $ip "$var play"; done; check_health; sleep 5
# stop mode
for ip in ${RACK[@]}; do $cmd $ip "$var stop"; done; check_health; sleep 2
# frame-by-frame f rward ->
for ip in ${RACK[@]}; do $cmd $ip "$var ff"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var ff"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var ff"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var ff"; done; check_health; sleep 2
# frame-by-frame rewind <-
for ip in ${RACK[@]}; do $cmd $ip "$var rew"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var rew"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var rew"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var rew"; done; check_health; sleep 2
# playback mode
for ip in ${RACK[@]}; do $cmd $ip "$var play"; done; check_health; sleep 5
# slow mo
for ip in ${RACK[@]}; do $cmd $ip "$var play"; done; check_health; sleep 5
# playback mode
for ip in ${RACK[@]}; do $cmd $ip "$var play"; done; check_health; sleep 5
# instant replay
for ip in ${RACK[@]}; do $cmd $ip "$var replay"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var replay"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var replay"; done; check_health; sleep 2
# live mode
for ip in ${RACK[@]}; do $cmd $ip "$var live"; done; check_health; sleep 30
# rewind mode
for ip in ${RACK[@]}; do $cmd $ip "$var rew"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var rew"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var rew"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var rew"; done; check_health; sleep 30
# fast ftoward mode
for ip in ${RACK[@]}; do $cmd $ip "$var ff"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var ff"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var ff"; done; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var ff"; done; check_health; sleep 30

for ip in ${RACK[@]}; do $cmd $ip "$var c+"; done; check_health; timestamp=`TZ='America/New_York' date "+%d.%m.%Y %H:%M"`; sleep 25
check_pattern "$timestamp.*key_released" "getInfoBarker - title:" "$1"

check_power_status "$1" "3"
i=$(($i+1))
done
