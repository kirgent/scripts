#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

git status
git pull
echo "===================was git pull===="

git status
git commit -a -m 'auto commit'
echo "===================was git commit===="

git status
git push
echo "===================was git push===="

git status
