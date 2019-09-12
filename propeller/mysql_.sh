#!/bin/bash
cd ~/IdeaProjects/nativator/docker
IP=$(./print_ip.sh)
echo "Bind ip: $IP"
export EXTERNAL_IP=$IP
MYSQL_HOST=${EXTERNAL_IP}
MYSQL_PORT=3306

sed "s/{EXTERNAL_IP}/${EXTERNAL_IP}/g" init/mysql/handicap.sql | mysql -h ${MYSQL_HOST} -P ${MYSQL_PORT} -u openx -psecret openx
