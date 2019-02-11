#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

systemctl|egrep "postgres|elasticsearch|tomcat" --color=always
