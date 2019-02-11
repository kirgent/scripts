#!/bin/sh

server=cooldob.developonbox.ru
#server=167.206.135.18
port=22

echo "downloading EPG data from $server:/var/www/opg/test/data_v1.6.2/10.251.229.52/ -> /cygdrive/c/Users/User/10.251.229.52/ ..."
scp -C -p -P $port kirill.grushin@$server:/var/www/opg/test/data_v1.6.2/10.251.229.52/* /cygdrive/c/Users/User/10.251.229.52/

echo "downloading EPG data from $server:/var/www/opg/test/data_v1.6.2/10.251.226.65/ -> /cygdrive/c/Users/User/10.251.226.65/ ..."
scp -C -p -P $port kirill.grushin@$server:/var/www/opg/test/data_v1.6.2/10.251.226.65/* /cygdrive/c/Users/User/10.251.226.65/
