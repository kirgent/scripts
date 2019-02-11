#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

echo "---> git status:"
git status && echo "---> git status-ed"

echo "sleep for 5 sec..."
sleep 5

echo "---> git pull:"
git pull && echo "---> git pull-ed OK"

echo "---> git status:"
git status && echo "---> git status-ed OK"
echo "---> git commit:"
git commit -a -m 'auto commit' && echo "---> git commit-ed"

echo "---> git status:"
git status && echo "---> git status-ed"
echo "---> git push:"
git push && echo "---> git push-ed"


echo "---> git status:"
git status && echo "---> git status-ed"
