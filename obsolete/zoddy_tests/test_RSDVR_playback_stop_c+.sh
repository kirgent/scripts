#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

wait_overall_boot_progress "$1"

preconditions "$0"

if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi
for box in ${RACK[@]}; do $cmd $box "log_buffer 8192"; done; sleep 1
for box in ${RACK[@]}; do $cmd $box "onyxset set block"; done; sleep 1

for box in ${RACK[@]}; do $cmd $box "$var e"; done; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var 2"; done; check_health; sleep 10
while true; do
for box in ${RACK[@]}; do $cmd $box "$var list"; done; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var sel"; done; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var sel"; done; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var sel"; done; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var sel"; done; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var stop"; done; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var e"; done; sleep 10

for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 10
done
