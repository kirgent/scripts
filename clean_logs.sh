#!/bin/bash
df -h /
sudo find /var/log/ -size +30M -iname "*.log" -exec rm -rf {} \;
df -h /
