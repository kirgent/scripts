#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

wait_overall_boot_progress "$1"

preconditions "$0"

FLOOR=250
RANGE=2000

i=0
while true; do
echo "iteration=$i"
number=0
#for box in ${RACK[@]}; do $cmd $box "$var c+"; check_health; done
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health
while [ "$number" -le $FLOOR ]
do
  number=$RANDOM
  let "number %= $RANGE"
done

if [ "$number" -lt 1000 ]; then
echo "number=$number ====== 1 ======"
sleep 0."$number"

elif [ "$number" -lt 1100 ]; then
let "a = number / 1000"
let "b = number % 1000"
echo "$number = $a + 0.0$b ====== 2 ======"
sleep $a 0.0$b

else
let "a = number / 1000"
let "b = number % 1000"
echo "$number = $a + 0.$b ====== 3 ======"
sleep $a 0.$b
fi

i=$(($i+1))

#bla=`echo "$iteration"|cut -c$((echo "$iteration"|wc -c-1))-`
#if [ $bla == "0" ]; then
#check_power_status "$1"
#fi
#if [ `date +%M|cut -c1` -eq "0" ]; then for box in ${RACK[@]}; do $cmd $box "dalagent status" >/dev/null 2>&1; if [ "$?" -ne "0" ]; then date; echo "box is down. exit."; exit; fi; done; fi
done
