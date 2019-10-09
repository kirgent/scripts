#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

sudo systemctl restart network-manager.service
sudo systemctl restart networking.service

systemctl status network-manager.service --no-pager
systemctl status networking.service --no-pager