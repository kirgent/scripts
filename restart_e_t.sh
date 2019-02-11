#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

if [[ $(whoami) != "root" ]]; then
echo "you must be root to run"
exit 1
fi

echo "Restarting will be started in 3 seconds..."
sleep 3

systemctl restart elasticsearch && echo "elasticsearch is restarted OK"
systemctl restart tomcat && echo "tomcat is restarted OK"

status_all.sh
