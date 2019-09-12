#!/bin/bash

cd ~/IdeaProjects/nativator/docker
IP=$(./print_ip.sh)
echo "Bind ip: $IP"
export EXTERNAL_IP=$IP

cd ~/IdeaProjects/nativator/docker/services && docker-compose restart rotator
