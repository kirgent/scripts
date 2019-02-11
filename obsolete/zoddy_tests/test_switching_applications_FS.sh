#!/bin/bash
echo "`date` - $0 $1" >> log.log
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

wait_overall_boot_progress "$1"

preconditions "$0"

# Full Settings
app=s,s
timer=15

i=1
while true; do
echo "iteration=$i"
for box in ${RACK[@]}; do $cmd $box "$var 2"; done; check_health; sleep 15

# over LiveTV
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10

# over Guide
for box in ${RACK[@]}; do $cmd $box "$var g"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
# start Guide
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var g"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
check_power_status "$1"
inject_commands "$1"

# over menu
for box in ${RACK[@]}; do $cmd $box "$var menu"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
# start menu
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var menu"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10

# over Quick Settings
for box in ${RACK[@]}; do $cmd $box "$var s"; done; check_health; sleep 5
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
check_power_status "$1"
inject_commands "$1"

# over Full Settings
for box in ${RACK[@]}; do $cmd $box "$var s"; done; check_health; sleep 5
for box in ${RACK[@]}; do $cmd $box "$var s"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10

# over shortcuts
for box in ${RACK[@]}; do $cmd $box "$var C"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
# start shortcuts
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var C"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
check_power_status "$1"
inject_commands "$1"

# over Search
for box in ${RACK[@]}; do $cmd $box "$var search"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
# start Search
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var search"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10

# over ondemand
for box in ${RACK[@]}; do $cmd $box "$var od"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
# start ondemand
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var od"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
check_power_status "$1"
inject_commands "$1"

# over RSDVR
for box in ${RACK[@]}; do $cmd $box "$var list"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
# start RSDVR
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var list"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10


# over 92-95 PPV channels
for box in ${RACK[@]}; do $cmd $box "$var 9,2"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
check_power_status "$1"
inject_commands "$1"

# over VW 195-197 channels
for box in ${RACK[@]}; do $cmd $box "$var 1,9,5"; done; check_health; sleep 60
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10

# SDV 400 --
#for box in ${RACK[@]}; do $cmd $box "$var 4,0,0"; done; check_health; sleep 60
#for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
#for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
#for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 60
#for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
#for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
#for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 60
#for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
#for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10

# over 500-505 VOD channel
for box in ${RACK[@]}; do $cmd $box "$var 5,0,0"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
check_power_status "$1"
inject_commands "$1"

# over 600-610? SDV channels
for box in ${RACK[@]}; do $cmd $box "$var 6,0,0"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var c+"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
check_power_status "$1"
inject_commands "$1"

# over 630 CallerID channel
for box in ${RACK[@]}; do $cmd $box "$var 6,3,0"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10

# over 1001 DVR channel (splash screen)
for box in ${RACK[@]}; do $cmd $box "$var 1,0,0,1"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10

# over DVR over 1001 DVR channel
for box in ${RACK[@]}; do $cmd $box "$var list"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10

# start RSDVR playback + QS/FS over
for box in ${RACK[@]}; do $cmd $box "$var list"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var sel"; done; check_health; sleep 3
for box in ${RACK[@]}; do $cmd $box "$var sel"; done; check_health; sleep 3
for box in ${RACK[@]}; do $cmd $box "$var sel"; done; check_health; sleep 3
for box in ${RACK[@]}; do $cmd $box "$var sel"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var $app"; done; check_health; sleep $timer
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
for box in ${RACK[@]}; do $cmd $box "$var stop"; done; check_health; sleep 15
for box in ${RACK[@]}; do $cmd $box "$var e"; done; check_health; sleep 10
check_power_status "$1"
inject_commands "$1"

i=$(($i+1))
done
