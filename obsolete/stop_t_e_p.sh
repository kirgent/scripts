#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

if [[ $(whoami) != "root" ]]; then
echo "you must be root to run"
exit 1
fi

systemctl stop tomcat && echo "tomcat is stopped OK"
sleep 3
systemctl stop elasticsearch && echo "elasticsearch is stopped OK"
sleep 3
systemctl stop postgresql-9.6 && echo "postgres is stopped OK"
sleep 3

status_p_e_t.sh
