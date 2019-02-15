#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)
# tar   is required!
# unzip is required!
# psql  is required!
# sed   is required!
# awk   is required!

if [[ ! -x "$(which tar 2> /dev/null)" ]]; then echo "tar is not found"; exit; fi
if [[ ! -x "$(which unzip 2> /dev/null)" ]]; then echo "unzip is not found"; exit; fi
if [[ ! -x "$(which psql 2> /dev/null)" ]]; then echo "psql is not found"; exit; fi
if [[ ! -x "$(which sed 2> /dev/null)" ]]; then echo "sed is not found"; exit; fi
if [[ ! -x "$(which awk 2> /dev/null)" ]]; then echo "awk is not found"; exit; fi

if [[ $(whoami) != "root" ]]; then
echo "You must be root to run"
exit
fi

# copy all new tomcat/conf/* files to target tomcat/conf?:
UPDATE_CONF=true
# create symbolic links to all configs?:
UPDATE_LINKS=true
# where tomcat lives:
TOMCAT="/usr/share/tomcat"
# where elasticsearch lives:
ELASTICSEARCH="/usr/share/elasticsearch"
# unidata will be unpacked to this folder:
HOMEUSER="/home/centuser"
FILE="$1"


if [[ -z "$FILE" ]]; then
echo "No input tar.gz file specified!"
exit
else
if [[ ! -e "$FILE" ]]; then echo "File $FILE not exist!"
exit
else
TARGZ="`ls -x $FILE`"
if [[ `echo "$TARGZ" | rev |  cut -f1-2 -d. | rev` != "tar.gz" ]]; then echo "File is not tar.gz!"
exit
fi
fi
fi








# get rX.X prefix (unidata-rX.X-yyyyyyy)
PREFIX="`ls -x ${TARGZ}|cut -f2 -d-`"

#get yyyyyyy postfix (unidata-rX.X-yyyyyyy)
POSTFIX="`ls -x ${TARGZ}|cut -f3 -d-|cut -f1 -d.`"

UNIDATA="unidata-$PREFIX"


echo "UPDATE_CONF=$UPDATE_CONF"
echo "UPDATE_LINKS=$UPDATE_LINKS"
echo "$UNIDATA-$POSTFIX will be deployed in 5 seconds..."
sleep 5


###############################################
#### REMOVING OLD
rm -rf ${TOMCAT}/webapps/ && echo "---> old tomcat/webapps are removed OK"
rm -rf "$UNIDATA" && echo "---> old $UNIDATA is removed OK"

###############################################
#### UNPACKING NEW
tar -xf "$TARGZ" && echo "---> $TARGZ is unpacked OK"

systemctl stop elasticsearch && echo "---> elasticsearch is stopped OK"
echo "tomcat pid=$(ps aux|grep java|grep tomcat|awk '{print $2}')"
systemctl stop tomcat && echo "---> tomcat is stopped OK"


##################################
### OBSOLETE - WILL BE REMOVED SOON
#cd /
#sudo -u postgres `which psql` -U postgres <<'SQL'
#drop database unidata;
#create database unidata;
#SQL
#echo "---> database unidata is recreated OK"
#cd $HOMEUSER


sed -i 's/export JAVA_HOME/#\0/' ${UNIDATA}/database/init_env.sh
cd ${UNIDATA}/database
#./update_database.sh > /dev/null && echo "---> update_database(migration) is OK"
./update_database.sh && echo "---> update_database(migrate) is OK"
cd ${HOMEUSER}


sudo -u postgres `which psql` -U postgres <<'SQL'
\c unidata
SELECT script FROM schema_version ORDER BY installed_rank DESC LIMIT 10;
SQL
echo "---> above are last 10 script migrations"


unzip -o ${UNIDATA}/ThirdParty/ElasticSearch/plugins/analysis-morphology/elasticsearch-analysis-morphology-*.zip -d ${ELASTICSEARCH}/plugins/analysis-morphology/ && echo "---> elasticsearch plugins are unzipped OK"
mv ${ELASTICSEARCH}/plugins/analysis-morphology/elasticsearch/* ${ELASTICSEARCH}/plugins/analysis-morphology/ && echo "---> elasticsearch plugins are moved OK"
rmdir ${ELASTICSEARCH}/plugins/analysis-morphology/elasticsearch

###############################################
#### COPIYNG NEW
cp -rv ${UNIDATA}/Tomcat/lib/* ${TOMCAT}/lib/ && echo "---> tomcat/lib are copied OK"

if [[ ! -d "$TOMCAT/conf/unidata" ]]; then
cp -rv ${UNIDATA}/Tomcat/conf/* ${TOMCAT}/conf/ && echo "---> tomcat/conf are copied OK"
else
if [[ "$UPDATE_CONF" == "true" ]]; then
cp -rv ${UNIDATA}/Tomcat/conf/* ${TOMCAT}/conf/ && echo "---> tomcat/conf are copied OK"
fi
fi

cp -rv ${UNIDATA}/Tomcat/webapps/* ${TOMCAT}/webapps/ && echo "---> tomcat/webapps are copied OK"

chown -R tomcat:tomcat ${TOMCAT}/webapps/ ${TOMCAT}/conf/ ${TOMCAT}/logs/  && echo "---> tomcat/* are chowned OK"

systemctl start elasticsearch && echo "---> elasticsearch is started OK"


###############################################
#### patching
sed -i 's/unidata.password.policy.expiration.email.notification.period.days=.*/unidata.password.policy.expiration.email.notification.period.days=1/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.password.policy.admin.expiration.days=.*/unidata.password.policy.admin.expiration.days=1/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.password.policy.user.expiration.days=.*/unidata.password.policy.user.expiration.days=1/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.password.policy.check.last.repeat=.*/unidata.password.policy.check.last.repeat=0/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.password.policy.regexp=.*/unidata.password.policy.regexp=((?=.*[0-9])(?=.*[a-z])).{1,}/' ${TOMCAT}/conf/unidata/backend.properties

sed -i 's/unidata.notification.enabled=.*/unidata.notification.enabled=true/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.activiti.task.mailServerHost=.*/unidata.activiti.task.mailServerHost=smtp.gmail.com/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.activiti.task.mailServerPort=.*/unidata.activiti.task.mailServerPort=465/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.activiti.task.mailServerUseSSL=.*/unidata.activiti.task.mailServerUseSSL=true/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.activiti.task.mailServerDefaultFrom=.*/unidata.activiti.task.mailServerDefaultFrom=kirill.grushin@unidata-platform.ru/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.activiti.task.mailServerUsername=.*/unidata.activiti.task.mailServerUsername=kirill.grushin@unidata-platform.ru/' ${TOMCAT}/conf/unidata/backend.properties
sed -i 's/unidata.activiti.task.mailServerPassword=.*/unidata.activiti.task.mailServerPassword=qwpoexplorer/' ${TOMCAT}/conf/unidata/backend.properties
echo "---> custom patching is done OK"
systemctl start tomcat && echo "---> tomcat is started OK"


ln -sfvn "$UNIDATA" unidata
ln -sfv "$TARGZ" unidata---
ln -sfv "$TARGZ" unidata-${PREFIX}- && echo "---> symlinks are updated OK"

if [[ "$UPDATE_LINKS" == "true" ]]; then
ln -sfv ${TOMCAT}/conf/unidata/backend.properties backend.properties
ln -sfv ${TOMCAT}/conf/unidata/logback.xml logback.xml
ln -sfv ${TOMCAT}/conf/server.xml server.xml
ln -sfv ${TOMCAT}/conf/Catalina/localhost/unidata-backend.xml unidata-backend.xml
ln -sfv ${TOMCAT}/conf/unidata/unidata-conf.xml unidata-conf.xml
ln -sfv ${TOMCAT}/logs/unidata_backend.log unidata_backend.log
ln -sfv ${TOMCAT}/webapps/unidata-frontend/customer.json customer.json
ln -sfv ${TOMCAT}/webapps/unidata-frontend-admin/customer.json customer.json_
ln -sfv /etc/elasticsearch/elasticsearch.yml elasticsearch.yml
ln -sfv /var/log/elasticsearch/elasticsearch.log elasticsearch.log
ln -sfv /var/lib/pgsql/9.6/data/postgresql.conf postgresql.conf
echo "---> config symlinks are updated OK"
fi


echo "---> workaround:"
while [[ ! -e "${TOMCAT}/webapps/unidata-frontend/customer.json" ]]; do
echo "sleeping for 3sec, waiting for ${TOMCAT}/webapps/unidata-frontend/customer.json ..."
sleep 3
done
cp -v /usr/share/tomcat/webapps/unidata-frontend/customer.json /usr/share/tomcat/webapps/unidata-frontend-admin/  && sed -i "s/.*\"APP_MODE\": \"user\",/\"APP_MODE\": \"admin\",/g" /usr/share/tomcat/webapps/unidata-frontend-admin/customer.json
echo "---> workaround is applied"


echo "---> Done"
status_all.sh
ls -l unidata
ls -l unidata-${PREFIX}-
