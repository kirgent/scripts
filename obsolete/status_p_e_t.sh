#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

systemctl|egrep "postgresql|elasticsearch\.|tomcat" --color=always
