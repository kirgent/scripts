#!/bin/bash
# tar   is required!
# unzip is required!
# psql  is required!
# sed   is required!
# awk   is required!

if [ ! -x "$(which tar 2> /dev/null)" ]; then echo "tar is not found"; exit; fi
if [ ! -x "$(which unzip 2> /dev/null)" ]; then echo "unzip is not found"; exit; fi
if [ ! -x "$(which psql 2> /dev/null)" ]; then echo "psql is not found"; exit; fi
if [ ! -x "$(which sed 2> /dev/null)" ]; then echo "sed is not found"; exit; fi
if [ ! -x "$(which awk 2> /dev/null)" ]; then echo "awk is not found"; exit; fi

if [ $(whoami) != "root" ]; then
echo "you must be root to run"
exit 1
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
# where Unidata-*.zip is located and will be looked for:
LOOKING_DIR="$HOMEUSER/d"
TEMP="distribution"

while [[ ! -e "`ls -x $LOOKING_DIR/Unidata-*.zip`" ]]; do
echo "File Unidata-*.zip not exist in $LOOKING_DIR!"
sleep 3
done
ZIP="`ls -x $LOOKING_DIR/Unidata-*.zip`"

echo "Unzipping $ZIP will be started in 3 seconds..."
sleep 3

cd $HOMEUSER
rm -v Unidata-*.zip && echo "---> old zip is removed OK"
unzip "$ZIP" && echo "---> zip is unpacked OK"
mv -v "$ZIP" $HOMEUSER && echo "---> zip is moved OK"

# get full filename (unidata-rX.X-xxxxxxx.tar.gz)
TARGZ="`ls -x $TEMP/unidata-*|cut -f2 -d/`"
# move to home
mv -v $TEMP/$TARGZ $HOMEUSER && echo "---> targz is moved OK"
rmdir -v $TEMP && echo "---> $TEMP is removed OK"

# get rX.X prefix (unidata-rX.X-yyyyyyy)
PREFIX="`ls -x $TARGZ|cut -f2 -d-`"

# get yyyyyyy postfix (unidata-rX.X-yyyyyyy)
POSTFIX="`ls -x $TARGZ|cut -f3 -d-|cut -f1 -d.`"

UNIDATA="unidata-$PREFIX"


echo "UPDATE_CONF=$UPDATE_CONF"
echo "UPDATE_LINKS=$UPDATE_LINKS"
echo "$UNIDATA-$POSTFIX will be deployed in 5 seconds..."
sleep 5


###############################################
#### REMOVING OLD
rm -rf $TOMCAT/webapps/ && echo "---> old tomcat/webapps are removed OK"
rm -rf "$UNIDATA" && echo "---> old $UNIDATA is removed OK"

###############################################
#### UNPACKING NEW
tar -xf "$TARGZ" && echo "---> $TARGZ is unpacked OK"

systemctl stop elasticsearch && echo "---> elasticsearch is stopped OK"
ps aux|grep java|grep tomcat|awk '{print $1" "$2}'
systemctl stop tomcat && echo "---> tomcat is stopped OK"


sed -i 's/export JAVA_HOME/#\0/' $UNIDATA/database/init_env.sh
cd $UNIDATA/database
#./update_database.sh > /dev/null && echo "---> update_database(migration) is OK"
./update_database.sh && echo "---> update_database(migrate) is OK"
cd $HOMEUSER


sudo -u postgres `which psql` -U postgres <<'SQL'
\c unidata
SELECT script FROM schema_version ORDER BY installed_rank DESC LIMIT 10;
SQL
echo "---> above are last 10 script migrations"


unzip -o $UNIDATA/ThirdParty/ElasticSearch/plugins/analysis-morphology/elasticsearch-analysis-morphology-*.zip -d $ELASTICSEARCH/plugins/analysis-morphology/ && echo "---> elasticsearch plugins are unzipped OK"
mv $ELASTICSEARCH/plugins/analysis-morphology/elasticsearch/* $ELASTICSEARCH/plugins/analysis-morphology/ && echo "---> elasticsearch plugins are moved OK"
rmdir $ELASTICSEARCH/plugins/analysis-morphology/elasticsearch

###############################################
#### COPIYNG NEW
cp -rv $UNIDATA/Tomcat/lib/* $TOMCAT/lib/ && echo "---> tomcat/lib are copied OK"

if [ ! -d "$TOMCAT/conf/unidata" ]; then
cp -rv $UNIDATA/Tomcat/conf/* $TOMCAT/conf/ && echo "---> tomcat/conf are copied OK"
else
if [ "$UPDATE_CONF" == "true" ]; then
cp -rv $UNIDATA/Tomcat/conf/* $TOMCAT/conf/ && echo "---> tomcat/conf are copied OK"
fi
fi

cp -rv $UNIDATA/Tomcat/webapps/* $TOMCAT/webapps/ && echo "---> tomcat/webapps are copied OK"

chown -R tomcat:tomcat $TOMCAT/webapps/ $TOMCAT/conf/ $TOMCAT/logs/ && echo "---> tomcat/* are chowned OK"

systemctl start elasticsearch && echo "---> elasticsearch is started OK"
systemctl start tomcat && echo "---> tomcat is started OK"

ln -sfvn "$UNIDATA" unidata
ln -sfv "$TARGZ" unidata-
ln -sfv "$TARGZ" unidata-$PREFIX- && echo "---> symlinks are updated OK"

if [ "$UPDATE_LINKS" == "true" ]; then
ln -sfv $TOMCAT/conf/unidata/backend.properties backend.properties
ln -sfv $TOMCAT/conf/unidata/logback.xml logback.xml
ln -sfv $TOMCAT/conf/server.xml server.xml
ln -sfv $TOMCAT/conf/Catalina/localhost/unidata-backend.xml unidata-backend.xml
ln -sfv $TOMCAT/conf/unidata/unidata-conf.xml unidata-conf.xml
ln -sfv $TOMCAT/logs/unidata_backend.log unidata_backend.log
ln -sfv $TOMCAT/webapps/unidata-frontend/customer.json customer.json
ln -sfv $TOMCAT/webapps/unidata-frontend-admin/customer.json customer.json_
ln -sfv /etc/elasticsearch/elasticsearch.yml elasticsearch.yml
ln -sfv /var/log/elasticsearch/elasticsearch.log elasticsearch.log
ln -sfv /var/lib/pgsql/9.6/data/postgresql.conf postgresql.conf
echo "---> config symlinks are updated OK"
fi

status_all.sh

ls -l unidata-$PREFIX-
ls -l unidata

### WORKAROUND
echo "sleep 60..."
sleep 60
cp /usr/share/tomcat/webapps/unidata-frontend/customer.json /usr/share/tomcat/webapps/unidata-frontend-admin/  && sed -i "s/.*\"APP_MODE\": \"user\",/\"APP_MODE\": \"admin\",/g" /usr/share/tomcat/webapps/unidata-frontend-admin/customer.json
