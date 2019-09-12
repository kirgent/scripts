#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)
# pg_dump is required!

database=unidata
host=localhost
port=5432
username=postgres

if [[ ! -x "$(which pg_dump 2> /dev/null)" ]]; then echo "pg_dump is not found"; exit; fi

if [[ $(whoami) != "root" ]]; then
echo "you must be root to run"
exit 1
fi

echo "tomcat pid=$(ps aux|grep java|grep tomcat|awk '{print $2}')"
systemctl stop tomcat && echo "---> tomcat is stopped OK"
pg_dump -Fc ${database} -h ${host} -p ${port} -U ${username} > unidata_dump_`date +%Y%m%d_%H%M%S`.dump && echo "---> pg_dump is done OK"
systemctl start tomcat && echo "---> tomcat is started OK"
ls -l *.dump
echo "---> Done"


echo -e "\n\n========= for restoring use: =========
systemctl stop tomcat
su postgres
dropdb unidata
createdb unidata
pg_restore -h localhost -p 5432 -U postgres -C -d unidata <unidata.dump>
systemctl start tomcat"
