#!/bin/bash

sudo cp /etc/wpa_supplicant/wpa_supplicant.conf.high /etc/wpa_supplicant/wpa_supplicant.conf

sudo /etc/init.d/net.wlp2s0 restart
