#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)
# pg_dump is required!

if [[ ! -x "$(which pg_dump 2> /dev/null)" ]]; then echo "pg_dump is not found"; exit; fi

if [[ $(whoami) != "root" ]]; then
echo "you must be root to run"
exit 1
fi

systemctl stop tomcat && echo "---> tomcat is stopped OK"
pg_dump -Fc unidata -h localhost -p 5432 -U postgres > unidata_`date +%d%m%Y_%H%M%S`.dump
ls -l *.dump
systemctl start tomcat && echo "---> tomcat is started OK"


echo -e "========= ========= =========
for restoring use:
systemctl stop tomcat
su postgres
dropdb unidata
createdb unidata
pg_restore -h localhost -p 5432 -U postgres -C -d unidata <unidata.dump>
systemctl start tomcat
========= ========= ========="
