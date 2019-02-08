#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

tail -f /var/log/tomcat/unidata_backend.log | egrep --color=always -i -B1 -A5 -f "/home/centuser/scripts/patterns.txt"
