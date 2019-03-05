#!/bin/bash

r="${HOME}/.bashrc"
scripts="/home/${USER}"

echo "HOME=${HOME}"
echo "USER=${USER}"
echo "---> Current version:"
egrep --color=always "^(alias|export PATH)" ${r}

#echo "sleeping for 10sec..."
#sleep 10

echo

###############################################
#### patching
sed -i "s/.*alias rm.*/alias rm='rm -vi'/" ${r}
sed -i "s/.*alias ls.*/alias ls='ls -l --color=always'/" ${r}
sed -i "s/.*alias grep.*/alias grep='grep --color=always'/" ${r}
sed -i "s/.*alias egrep.*/alias egrep='egrep --color=always'/" ${r}
sed -i "s/.*alias vi.*/alias vi='vim'/" ${r}

#sed -i "s.*/PATH.*/${PATH}:/home/${USER}/" ${r}

echo "---> Patched version:"
egrep --color=always "^(alias|export PATH)" ${r}
