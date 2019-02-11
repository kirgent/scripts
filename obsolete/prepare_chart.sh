#!/bin/bash
log="$1"

# getting all MAX values:
#grep --color=never -A2 "add for macaddress=" $log | grep --color=never "return data" | awk '{print $9}' | rev | cut -c 2- | rev > reminders_a_max.log
#grep --color=never -A2 "modify for macaddress=" $log | grep --color=never "return data" | awk '{print $9}' | rev | cut -c 2- | rev > reminders_m_max.log
#grep --color=never -A2 "delete for macaddress=" $log | grep --color=never "return data" |awk '{print $9}' | rev | cut -c 2- | rev > reminders_d_max.log
#grep --color=never -A2 "purge for macaddress=" $log | grep --color=never "return data" | awk '{print $9}' | rev | cut -c 2- | rev > reminders_p_max.log

# getting all currect "ms request":
grep --color=never -A1 "add for macaddress=" $log | grep --color=never "ms request" | awk '{print $2}' | rev | cut -c 3- | rev > reminders_a_current.log
grep --color=never -A1 "modify for macaddress=" $log | grep --color=never "ms request" | awk '{print $2}' | rev | cut -c 3- | rev > reminders_m_current.log
grep --color=never -A1 "delete for macaddress=" $log | grep --color=never "ms request" |awk '{print $2}' | rev | cut -c 3- | rev > reminders_d_current.log
grep --color=never -A1 "purge for macaddress=" $log | grep --color=never "ms request" | awk '{print $2}' | rev | cut -c 3- | rev > reminders_p_current.log
