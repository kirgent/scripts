#!/bin/bash
echo "egrep \"com\.unidata.*Exception: |Exception: \" /var/log/tomcat/unidata_backend.log | wc -l"
echo
egrep "com\.unidata.*Exception: |Exception: " /var/log/tomcat/unidata_backend.log | wc -l
