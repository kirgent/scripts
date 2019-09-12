#!/bin/bash

cd ~/IdeaProjects/nativator/docker
IP=$(./print_ip.sh)
echo "Bind ip: $IP"
export EXTERNAL_IP=$IP

#export RTB__REVCONTENT_BASE_URL=http://${IP}:2345/api/v2
#export RTB__REVCONTENT_IMPRESSION_TRACKER=http://${IP}:2345/api/v2/track.php?d=
#export RTB__ACTIONTEASER_BASE_URL=http://${IP}:2345/news.php

cd ~/IdeaProjects/nativator/docker && ./env.sh

#cd ~/IdeaProjects/nativator/js && yarn build

echo =========================================

cd ~/IdeaProjects/nativator && go run cmd/nativator/main.go --env docker
