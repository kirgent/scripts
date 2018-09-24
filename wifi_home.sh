#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

sudo cp /etc/wpa_supplicant/wpa_supplicant.conf.home /etc/wpa_supplicant/wpa_supplicant.conf

sudo /etc/init.d/net.wlp2s0 restart
