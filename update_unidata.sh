#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)
# tar   is required!
# unzip is required!
# psql  is required!
# sed   is required!
# awk   is required!

# copy all new tomcat/conf/* files to target tomcat/conf?
UPDATE_CONF=true

# update symbolic links to configs/logs/files(recommended)?
UPDATE_LINKS=true

# where tomcat lives
TOMCAT="/usr/share/tomcat"

# where elasticsearch lives
ELASTICSEARCH="/usr/share/elasticsearch"

# service names
SERVICE_POSTGRES=postgresql-9.6.service
SERVICE_TOMCAT=tomcat.service
SERVICE_ELASTICSEARCH=elasticsearch.service

# unidata will be unpacked to this folder:
HOMEUSER="/home/centuser"

# dot't change
FILE="$1"
PARAM="$2"


if [[ ! -x "$(which tar 2> /dev/null)" ]]; then echo "tar is not found"; exit; fi
if [[ ! -x "$(which unzip 2> /dev/null)" ]]; then echo "unzip is not found"; exit; fi
if [[ ! -x "$(which psql 2> /dev/null)" ]]; then echo "psql is not found"; exit; fi
if [[ ! -x "$(which sed 2> /dev/null)" ]]; then echo "sed is not found"; exit; fi
if [[ ! -x "$(which awk 2> /dev/null)" ]]; then echo "awk is not found"; exit; fi

if [[ $(whoami) != "root" ]]; then
echo "You must be root to run"
exit 1
fi


if [[ -z "$FILE" ]]; then
echo "No input tar.gz file specified!"
echo "update_unidata.sh file.tar.gz [drop]"
echo "[drop] - drop DB unidata and create new empty DB unidata"
exit
else
if [[ ! -e "$FILE" ]]; then echo "File $FILE not exist!"
exit
else
TARGZ="$(ls -x $FILE)"
if [[ $(echo "$TARGZ" | rev |  cut -f1-2 -d. | rev) != "tar.gz" ]]; then echo "File is not tar.gz!"
exit
fi
fi
fi








# get rX.X prefix (unidata-rX.X-yyyyyyy)
PREFIX="$(ls -x ${TARGZ}|cut -f2 -d-)"

#get yyyyyyy postfix (unidata-rX.X-yyyyyyy)
POSTFIX="$(ls -x ${TARGZ}|cut -f3 -d-|cut -f1 -d.)"

UNIDATA="unidata-$PREFIX"


echo "UPDATE_CONF=$UPDATE_CONF"
echo "UPDATE_LINKS=$UPDATE_LINKS"
echo "FILE=$FILE"
echo "PARAM=$PARAM"
echo "$UNIDATA-$POSTFIX will be deployed in 5sec..."
sleep 5


###############################################
#### REMOVING OLD
#rm -rf ${TOMCAT}/webapps/unidata-backend/ && echo "---> old tomcat/webapps/unidata-backend is removed OK"
#rm -rf ${TOMCAT}/webapps/unidata-frontend/ && echo "---> old tomcat/webapps/unidata-frontend is removed OK"
#rm -rf ${TOMCAT}/webapps/unidata-frontend-admin/ && echo "---> old tomcat/webapps/unidata-frontend-admin is removed OK"
rm -rf "$UNIDATA" && echo "---> old $UNIDATA is removed OK"

###############################################
#### UNPACKING NEW
tar -xf "$TARGZ" && echo "---> $TARGZ is unpacked OK"

systemctl restart $SERVICE_POSTGRES && echo "---> postgresql is restarted OK"
systemctl stop $SERVICE_ELASTICSEARCH && echo "---> elasticsearch is stopped OK"
echo "tomcat pid=$(ps aux|grep java|grep tomcat|awk '{print $2}')"
systemctl stop $SERVICE_TOMCAT && echo "---> tomcat is stopped OK"


###############################################
#### REMOVING OLD
rm -rf ${TOMCAT}/webapps/unidata-backend/ && echo "---> old tomcat/webapps/unidata-backend is removed OK"
rm -rf ${TOMCAT}/webapps/unidata-frontend/ && echo "---> old tomcat/webapps/unidata-frontend is removed OK"
rm -rf ${TOMCAT}/webapps/unidata-frontend-admin/ && echo "---> old tomcat/webapps/unidata-frontend-admin is removed OK"


if [[ "$PARAM" == "drop" ]]; then 
cd /
sudo -u postgres `which psql` -U postgres <<'SQL'
drop database unidata;
create database unidata;
SQL
echo "---> database unidata is recreated OK"
cd $HOMEUSER
fi


sed -i 's/export JAVA_HOME/#\0/' ${UNIDATA}/database/init_env.sh
cd ${UNIDATA}/database
#./update_database.sh > /dev/null && echo "---> update_database(migration) is OK"
./update_database.sh && echo "---> update_database(migrate) is OK"
cd ${HOMEUSER}


sudo -u postgres `which psql` -U postgres <<'SQL'
\c unidata
SELECT script FROM schema_version ORDER BY installed_rank DESC LIMIT 5;
SQL
echo "---> above are last 5 script migrations"


unzip -o ${UNIDATA}/ThirdParty/ElasticSearch/plugins/analysis-morphology/elasticsearch-analysis-morphology-*.zip -d ${ELASTICSEARCH}/plugins/analysis-morphology/ && echo "---> elasticsearch plugins are unzipped OK"
mv ${ELASTICSEARCH}/plugins/analysis-morphology/elasticsearch/* ${ELASTICSEARCH}/plugins/analysis-morphology/ && echo "---> elasticsearch plugins are moved OK"
rmdir ${ELASTICSEARCH}/plugins/analysis-morphology/elasticsearch

###############################################
#### COPIYNG NEW
cp -r ${UNIDATA}/Tomcat/lib/* ${TOMCAT}/lib/ && echo "---> tomcat/lib are copied OK"

#if [[ ! -d "$TOMCAT/conf/unidata" ]]; then
#cp -r ${UNIDATA}/Tomcat/conf/* ${TOMCAT}/conf/ && echo "---> tomcat/conf are copied OK"
#else
if [[ "$UPDATE_CONF" == "true" ]]; then
cp -r ${UNIDATA}/Tomcat/conf/* ${TOMCAT}/conf/ && echo "---> tomcat/conf are copied OK"
cp d/unidata-conf.xml ${TOMCAT}/conf/unidata/
fi
#fi

cp -r ${UNIDATA}/Tomcat/webapps/* ${TOMCAT}/webapps/ && echo "---> tomcat/webapps are copied OK"

chown -R tomcat:tomcat ${TOMCAT}/webapps/ ${TOMCAT}/conf/ ${TOMCAT}/logs/ && echo "---> tomcat/* are chowned OK"

systemctl start $SERVICE_ELASTICSEARCH && echo "---> elasticsearch is started OK"

###############################################
#### patching
sed -i 's/unidata.password.policy.expiration.email.notification.period.days=.*/unidata.password.policy.expiration.email.notification.period.days=1/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.password.policy.admin.expiration.days=.*/unidata.password.policy.admin.expiration.days=2/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.password.policy.user.expiration.days=.*/unidata.password.policy.user.expiration.days=2/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.password.policy.check.last.repeat=.*/unidata.password.policy.check.last.repeat=0/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.password.policy.regexp=.*/unidata.password.policy.regexp=((?=.*[0-9])(?=.*[a-z])).{1,}/' ${TOMCAT}/conf/unidata/backend.properties

sed -i 's/unidata.notification.enabled=.*/unidata.notification.enabled=true/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.activiti.task.mailServerHost=.*/unidata.activiti.task.mailServerHost=smtp.gmail.com/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.activiti.task.mailServerPort=.*/unidata.activiti.task.mailServerPort=465/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.activiti.task.mailServerUseSSL=.*/unidata.activiti.task.mailServerUseSSL=true/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.activiti.task.mailServerDefaultFrom=.*/unidata.activiti.task.mailServerDefaultFrom=kirill.grushin@unidata-platform.ru/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.activiti.task.mailServerUsername=.*/unidata.activiti.task.mailServerUsername=kirill.grushin@unidata-platform.ru/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.activiti.task.mailServerPassword=.*/unidata.activiti.task.mailServerPassword=xxx/' ${TOMCAT}/conf/unidata/backend.properties
echo -e "\nunidata.frontend.url=http://127.0.0.1:8080/unidata-frontend/" >> ${TOMCAT}/conf/unidata/backend.properties

sed -i 's/unidata.security.token.ttl=.*/unidata.security.token.ttl=7200/' ${TOMCAT}/conf/unidata/backend.properties

echo "---> custom patching is done OK"
systemctl start $SERVICE_TOMCAT && echo "---> tomcat is started OK"


ln -sfvn "$UNIDATA" unidata
ln -sfv "$TARGZ" unidata--
ln -sfv "$TARGZ" unidata-${PREFIX}- && echo "---> symlinks are updated OK"

if [[ "$UPDATE_LINKS" == "true" ]]; then
ln -sf ${TOMCAT}/conf/unidata/backend.properties backend.properties
ln -sf ${TOMCAT}/conf/unidata/logback.xml logback.xml
ln -sf ${TOMCAT}/conf/server.xml server.xml
ln -sf ${TOMCAT}/conf/Catalina/localhost/unidata-backend.xml unidata-backend.xml
ln -sf ${TOMCAT}/conf/unidata/unidata-conf.xml unidata-conf.xml
ln -sf ${TOMCAT}/logs/unidata_backend.log unidata_backend.log
ln -sf ${TOMCAT}/webapps/unidata-frontend/customer.json customer.json
ln -sf ${TOMCAT}/webapps/unidata-frontend-admin/customer.json customer-.json
ln -sf /etc/elasticsearch/elasticsearch.yml elasticsearch.yml
ln -sf /var/log/elasticsearch/elasticsearch.log elasticsearch.log
ln -sf /var/lib/pgsql/9.6/data/postgresql.conf postgresql.conf
echo "---> config symlinks are updated OK"
fi


if [[ "$PARAM" == "drop" ]]; then
sleep 30
clean_index.sh
restAPI_reindexDataJob.sh
restAPI_reindexMappingsJob.sh
fi


#echo "---> workaround:"
#echo "Sleeping and waiting for ${TOMCAT}/webapps/unidata-frontend/customer.json ..."
#while [[ ! -e "${TOMCAT}/webapps/unidata-frontend/customer.json" ]]; do
#sleep 3
#done
#cp -v /usr/share/tomcat/webapps/unidata-frontend/customer.json /usr/share/tomcat/webapps/unidata-frontend-admin/  && sed -i "s/.*\"APP_MODE\": \"user\",/\"APP_MODE\": \"admin\",/g" /usr/share/tomcat/webapps/unidata-frontend-admin/customer.json
#echo "---> workaround is applied"


echo "---> Done"
status_all.sh
ls -l unidata
ls -l unidata-${PREFIX}-
date
