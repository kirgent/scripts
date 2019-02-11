#!/bin/bash
echo "`date` - $0 $1" >> log.log

# work pc
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg
# sun_server / home_pc
elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg
fi

if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi
for box in ${RACK[@]}; do $cmd $box "log set all 6" 2>/dev/null; done; sleep 1
for box in ${RACK[@]}; do $cmd $box "log_buffer 8192" 2>/dev/null; done; sleep 1
for box in ${RACK[@]}; do $cmd $box "onyxset set block" 2>/dev/null; done; sleep 1

echo "use rack: ${RACK[@]}"
for box in ${RACK[@]}; do $cmd $box "$var e" 2>/dev/null|$logger; done; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var 2" 2>/dev/null|$logger; done; sleep 10
while true; do
for box in ${RACK[@]}; do $cmd $box "$var record" 2>/dev/null|$logger; done; sleep 5
for box in ${RACK[@]}; do $cmd $box "$var r" 2>/dev/null|$logger; done; sleep 5
for box in ${RACK[@]}; do $cmd $box "$var sel" 2>/dev/null|$logger; done; sleep 5
for box in ${RACK[@]}; do $cmd $box "$var list" 2>/dev/null|$logger; done; sleep 5
for box in ${RACK[@]}; do $cmd $box "$var c+" 2>/dev/null|$logger; done; sleep 5

if [ `date +%M|cut -c1` -eq "0" ]; then for box in ${RACK[@]}; do $cmd $box "dal status" >/dev/null 2>&1; if [ "$?" -ne "0" ]; then date; echo "box is down. exit."; exit; fi; done; fi
done
