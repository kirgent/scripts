#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

wait_overall_boot_progress "$1"

preconditions "$0"

function open_day_change {
for box in ${RACK[@]}; do $cmd $box "$var A"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var d"; done
for box in ${RACK[@]}; do $cmd $box "$var d"; done
for box in ${RACK[@]}; do $cmd $box "$var sel"; done; check_health; sleep 15
}

function confirm_change {
for box in ${RACK[@]}; do $cmd $box "$var sel"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var A"; done; check_health; sleep 15
}

for box in ${RACK[@]}; do $cmd $box "$var 2"; done; check_health; sleep 10

i=1
while true; do
echo "iteration=$i"
for box in ${RACK[@]}; do $cmd $box "$var g"; done; check_health; sleep 10
open_day_change; for box in ${RACK[@]}; do $cmd $box "$var d"; done; check_health; confirm_change

echo ====== i=$i global iteration, j=$j iteration ======
open_day_change; for j in {1..2}; do for box in ${RACK[@]}; do $cmd $box "$var d"; done; check_health; done; confirm_change

echo ====== i=$i global iteration, j=$j iteration ======
open_day_change; for j in {1..3}; do for box in ${RACK[@]}; do $cmd $box "$var d"; done; check_health; done; confirm_change

echo ====== i=$i global iteration, j=$j iteration ======
open_day_change; for j in {1..4}; do for box in ${RACK[@]}; do $cmd $box "$var d"; done; check_health; done; confirm_change

echo ====== i=$i global iteration, j=$j iteration ======
open_day_change; for j in {1..5}; do for box in ${RACK[@]}; do $cmd $box "$var d"; done; check_health; done; confirm_change

echo ====== i=$i global iteration, j=$j iteration ======
open_day_change; for j in {1..6}; do for box in ${RACK[@]}; do $cmd $box "$var d"; done; check_health; done; confirm_change

echo ====== i=$i global iteration, j=$j iteration ======
open_day_change; for j in {1..7}; do for box in ${RACK[@]}; do $cmd $box "$var d"; done; check_health; done; confirm_change

echo ====== i=$i global iteration, j=$j iteration ======
open_day_change; for j in {1..8}; do for box in ${RACK[@]}; do $cmd $box "$var d"; done; check_health; done; confirm_change

echo ====== i=$i global iteration, j=$j iteration ======
open_day_change; for j in {1..9}; do for box in ${RACK[@]}; do $cmd $box "$var d"; done; check_health; done; confirm_change

echo ====== i=$i global iteration, j=$j iteration ======
open_day_change; for j in {1..10}; do for box in ${RACK[@]}; do $cmd $box "$var d"; done; check_health; done; confirm_change

echo ====== i=$i global iteration, j=$j iteration ======
open_day_change; for j in {1..11}; do for box in ${RACK[@]}; do $cmd $box "$var d"; done; check_health; done; confirm_change

echo ====== i=$i global iteration, j=$j iteration ======
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 10
i=$(($i+1))

#if [ `date +%M|cut -c1` -eq "0" ]; then for box in ${RACK[@]}; do $cmd $box "dalagent status" >/dev/null 2>&1; if [ "$?" -ne "0" ]; then date; echo "box is down. exit."; exit; fi; done; fi
done
