#!/bin/bash

if [ $(whoami) != "root" ]; then
echo "you must be root to run"
exit 1
fi

chown -R tomcat:tomcat /usr/share/tomcat
chown -R tomcat:tomcat /usr/share/java/tomcat
chown -R tomcat:tomcat /var/cache/tomcat
