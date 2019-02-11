#!/bin/bash

if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
if [ -z "$1" ]; then echo "no ip"; exit; else RACK=($@); fi

$cmd $1 "pwreg set timeShiftSleepTime 01:00-02:00"
exit

$cmd $1 "pwreg set timeShiftSleepTime 01:00-23:00"
$cmd $1 "pwreg set timeShiftSleepInitialPostpone 40"
$cmd $1 "pwreg set timeShiftSleepPopupDuration 60"
$cmd $1 "pwreg set timeShiftSleepKeysPostpone 100"

$cmd $1 "pwreg get timeShiftSleepTime"
$cmd $1 "pwreg get timeShiftSleepInitialPostpone"
$cmd $1 "pwreg get timeShiftSleepPopupDuration"
$cmd $1 "pwreg get timeShiftSleepKeysPostpone"

$cmd $1 "zs watchtv tsb testSleepMode"
