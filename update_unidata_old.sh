#!/bin/bash

if [ $(whoami) != "root" ];then
echo -e "You must be root to run!"
exit 1
fi

TOMCAT="/usr/share/tomcat"
HOMEUSER="/home/centuser"
TARGZ="`ls -x $1`"
#UNIDATA="$HOMEUSER/unidata-`echo $TARGZ|cut -f2 -d-`"

### $TARGZ = unidata-r4.10-fa925e6.tar.gz
if [ -z "$TARGZ" ]; then
echo -e "No input file specified!"
exit
else
if [ ! -e "$TARGZ" ]; then echo "file not exist!"
exit
fi
fi













# get rX.X prefix (unidata-rX.X-1234567)
PREFIX="`ls -x $TARGZ|cut -f2 -d-`"

#get xxxxxxx postfix (unidata-r4.9-xxxxxxx)
POSTFIX="`ls -x $TARGZ|cut -f3 -d-|cut -f1 -d.`"

UNIDATA="unidata-$PREFIX"


echo "$UNIDATA-$POTSFIX will be deployed in 5 seconds..."
sleep 5

rm -rf $UNIDATA && echo "---> old $UNIDATA is removed OK"

tar -xf "$TARGZ" && echo "---> $TARGZ is unpacked OK"

ln -sfnv "$TARGZ" unidata && echo "---> symlink is updated OK"

systemctl stop elasticsearch && echo "---> elasticsearch is stopped OK"
systemctl stop tomcat && echo "---> tomcat is stopped OK"


### FOR SAVING YOUR MODEL DATA !!!
#cd /
#sudo -u postgres `which psql` -U postgres <<'SQL'
#drop database unidata;
#create database unidata;
#SQL
#echo "---> database unidata is recreated OK"
#cd $HOMEUSER


sed -i 's/export JAVA_HOME/#\0/' $UNIDATA/database/init_env.sh
cd $UNIDATA/database
#./update_database.sh > /dev/null && echo "---> update_database(migration) is OK"
./update_database.sh && echo "---> update_database(migrate) is OK"
cd $HOMEUSER


cd /
sudo -u postgres `which psql` -U postgres <<'SQL'
\c unidata
select relname from pg_stat_user_tables where schemaname = 'public' order by relname;
SQL
echo "---> schemaname=public is fine and OK"
cd $HOMEUSER


unzip -o $UNIDATA/ThirdParty/ElasticSearch/plugins/analysis-morphology/elasticsearch-analysis-morphology-5.6.3.zip -d /usr/share/elasticsearch/plugins/analysis-morphology/ && echo "---> elasticsearch plugins are unzipped OK"
mv /usr/share/elasticsearch/plugins/analysis-morphology/elasticsearch/* /usr/share/elasticsearch/plugins/analysis-morphology/ && echo "---> elasticsearch plugins are moved OK"
rmdir /usr/share/elasticsearch/plugins/analysis-morphology/elasticsearch

rm -rf $TOMCAT/webapps/ && echo "---> old tomcat/webapps are removed OK"

cp -rv $UNIDATA/Tomcat/lib/* $TOMCAT/lib/ && echo "---> tomcat/lib are copied OK"

#cp -rv $UNIDATA/Tomcat/conf/* $TOMCAT/conf/ && echo "---> tomcat/conf are copied OK"

cp -rv $UNIDATA/Tomcat/webapps/* $TOMCAT/webapps/ && echo "---> tomcat/webapps are copied OK"

chown -R tomcat:tomcat $TOMCAT/webapps/ $TOMCAT/conf/ $TOMCAT/logs/  && echo "---> tomcat/* are chowned OK"

systemctl start elasticsearch && echo "---> elasticsearch is started OK"
systemctl start tomcat && echo "---> tomcat is started OK"

status_all.sh

ls -l unidata

#colordiff backend.properties backend.properties.kir
