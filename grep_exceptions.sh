#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

echo "egrep \"com\.unidata.*Exception: |Exception: \" /var/log/tomcat/unidata_backend.log | wc -l"
echo
egrep "com\.unidata.*Exception: |Exception: " /var/log/tomcat/unidata_backend.log | wc -l
