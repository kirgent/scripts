#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)
# curl is required!
# psql is required!
# pg_restore is required!

database=unidata
host=localhost
port=5432
username=postgres
file=${1}


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

chown root:root ${file}
chmod 644 ${file}

HOMEUSER="/home/centuser"

echo "Restoring will be started in 5sec..."
sleep 3

systemctl stop tomcat && echo "---> tomcat is stopped OK"
systemctl restart postgresql-9.6 && echo "---> postgres is restarted OK"
echo "sleep for 5sec..."
sleep 5
systemctl restart postgresql-9.6 && echo "---> postgres is restarted OK"
echo "sleep for 5sec..."
sleep 5

sudo -u ${username} `which psql` -U ${username} <<'SQL'
DROP DATABASE unidata;
CREATE DATABASE unidata;
SQL
echo "$? ---> database unidata is recreated OK"

echo "sleep for 5sec..."
sleep 5

sudo -u ${username} pg_restore -h ${host} -p ${port} -U ${username} -C -d ${database} ${file}
#2> /dev/null
echo "$? ---> pg_restore code is $?"

echo "sleep for 5sec..."
sleep 5


cd $HOMEUSER/unidata/database
./update_database.sh && echo "$? ---> update_database(migrate) is done"
cd $HOMEUSER

sudo -u ${username} `which psql` -U ${username} <<'SQL'
\c unidata
SELECT script FROM schema_version ORDER BY installed_rank DESC LIMIT 5;
SQL
echo "$? ---> above are last 5 script migrations"

sudo -u ${username} `which psql` -U ${username} <<'SQL'
\c unidata
UPDATE s_password SET password_text = '$2a$10$S2owoJJrMr2TxzthaxtFVelPDyZGNuFE0xNkji8KJkdhtJ4CvUnR2';
SQL
echo "$? ---> admin password is reset OK"

sudo -u ${username} `which psql` -U ${username} <<'SQL'
\c unidata
REINDEX DATABASE unidata;
SQL
echo "$? ---> reindex database unidata is OK"

curl -X DELETE 'http://localhost:9200/_all' && echo -e "\n---> elasticsearch indexes are cleaned OK"
systemctl restart elasticsearch && echo "---> elasticsearch is restarted OK"

systemctl start tomcat && echo "---> tomcat is started OK"

echo "sleeping for 60sec..."
sleep 60

restAPI_JobsActions.sh
echo "---> Done"


echo -e "\n\n========= for dumping use: =========
systemctl stop tomcat
pg_dump -Fc unidata -h localhost -p 5432 -U postgres > unidata_\`date +%d%m%Y_%H%M%S\`.dump
systemctl start tomcat
ls -l *.dump
"
