#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

git status
git pull
git status
git commit -a -m 'auto commit'
git status
git push
git status

#git config --global credential.helper cache
