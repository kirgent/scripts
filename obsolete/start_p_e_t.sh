#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

if [[ $(whoami) != "root" ]]; then
echo "you must be root to run"
exit 1
fi

systemctl start postgresql-9.6 && echo "postgres is started OK"
sleep 3
systemctl start elasticsearch && echo "elasticsearch is started OK"
sleep 3
systemctl start tomcat && echo "tomcat is started OK"
sleep 3

status_p_e_t.sh
