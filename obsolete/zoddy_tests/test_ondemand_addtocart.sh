#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

wait_overall_boot_progress "$1"

preconditions "$0"

i=1
while true; do
#Movies A-Z: ABCDE, FGHIJ, KLMNO, PQRST
for (( j=0; j<=3; j++ )); do
for ip in ${RACK[@]}; do $cmd $ip "$var od"; done; check_health; sleep 5
for ip in ${RACK[@]}; do $cmd $ip "$var d"; done; check_health; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; check_health; sleep 5
for ip in ${RACK[@]}; do $cmd $ip "$var d"; done; check_health; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; check_health; sleep 5


for (( k=1; k<=$j; k++ )); do for ip in ${RACK[@]}; do $cmd $ip "$var r"; done; check_health; done


for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; check_health; sleep 5
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; check_health; sleep 5


for (( k=1; k<=300; k++ )); do
echo "iteration i=$i, j=$j, k=$k"

# move focus to Add to Cart -> Select
for (( m=1; m<=3; m++ )); do for ip in ${RACK[@]}; do $cmd $ip "$var d"; done; check_health; done
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; check_health; sleep 5
# go back(left) to list
for ip in ${RACK[@]}; do $cmd $ip "$var l"; done; check_health; sleep 2
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; check_health; sleep 5
# open the next asset
for ip in ${RACK[@]}; do $cmd $ip "$var sel"; done; check_health; sleep 1
done


check_power_status "$1" "2" "od"
i=$(($i+1))
done

done
