#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

git status
git pull
echo "======================="

git status
git commit -a -m 'auto commit'
echo "======================="

git status
git push
echo "======================="

git status
