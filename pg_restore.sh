#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)
# curl is required!
# psql is required!
# pg_restore is required!

if [[ ! -x "$(which curl 2> /dev/null)" ]]; then echo "curl is not found"; exit; fi
if [[ ! -x "$(which psql 2> /dev/null)" ]]; then echo "psql is not found"; exit; fi
if [[ ! -x "$(which pg_restore 2> /dev/null)" ]]; then echo "pg_restore is not found"; exit; fi

if [[ $(whoami) != "root" ]]; then
echo "you must be root to run"
exit 1
fi

if [[ -z "$1" ]]; then
echo "No input dump specified!"
exit
fi

HOMEUSER="/home/centuser"

echo "Restoring will be started in 3 seconds..."
sleep 3

systemctl stop tomcat && echo "---> tomcat is stopped OK"
systemctl restart postgresql-9.6 && echo "---> postgres is restarted OK"
echo "sleep 5 sec..."
sleep 5
systemctl restart postgresql-9.6 && echo "---> postgres is restarted OK"
echo "sleep 5 sec..."
sleep 5

sudo -u postgres `which psql` -U postgres <<'SQL'
DROP DATABASE unidata;
CREATE DATABASE unidata;
SQL
echo "$? ---> database unidata is recreated OK"

sudo -u postgres pg_restore -h localhost -p 5432 -U postgres -C -d unidata $1 2> /dev/null
echo "$? ---> pg_restore code is $?"


cd $HOMEUSER/unidata/database
./update_database.sh && echo "$? ---> update_database(migrate) is done"
cd $HOMEUSER

sudo -u postgres `which psql` -U postgres <<'SQL'
\c unidata
SELECT script FROM schema_version ORDER BY installed_rank DESC LIMIT 10;
SQL
echo "$? ---> above are last 10 script migrations"


sudo -u postgres `which psql` -U postgres <<'SQL'
\c unidata
UPDATE s_password SET password_text = '$2a$10$S2owoJJrMr2TxzthaxtFVelPDyZGNuFE0xNkji8KJkdhtJ4CvUnR2';
SQL
echo "$? ---> admin password is reset OK"


sudo -u postgres `which psql` -U postgres <<'SQL'
\c unidata
REINDEX DATABASE unidata;
SQL
echo "$? ---> reindex database unidata is OK"


curl -X DELETE 'http://localhost:9200/_all' && echo -e "\n---> indexes are cleaned OK"
systemctl restart elasticsearch && echo "---> elasticsearch is restarted OK"

systemctl start tomcat && echo "---> tomcat is started OK"

echo -e "\n========= ========= =========
for dumping use:
systemctl stop tomcat
pg_dump -Fc unidata -h localhost -p 5432 -U postgres > unidata_\`date +%d%m%Y_%H%M%S\`.dump
ls -l *.dump
systemctl start tomcat
========= ========= ========="
