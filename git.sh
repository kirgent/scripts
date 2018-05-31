#!/bin/bash
# written by Kirill Grushin (kirill.grushin@dev.zodiac.tv)

git status
git pull
git status
git commit -a -m 'auto commit'
git status
git push
git status

#git config credential.helper store
#git push https://github.com/repo.git
