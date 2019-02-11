#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else ip=$1; fi

wait_overall_boot_progress "$1"

preconditions2 "$0" "$1"

$cmd $ip "$var od"; check_health; sleep 5

i=1
while true; do

for j in {1..100}; do
echo "iteration: i=$i, j=$j"
$cmd $ip "$var d"; sleep 1
$cmd $ip "$var u"; sleep 1
$cmd $ip "$var d"; sleep 1
$cmd $ip "$var d"; check_health; sleep 1
check_power_status "$1" "2" "od"
done
inject_commands "$1"

#echo "sleep 300"
#sleep 300
i=$(($i+1))
done
