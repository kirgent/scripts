#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

sudo systemctl restart docker

systemctl status docker.service --no-pager