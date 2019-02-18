#!/bin/bash

r="${HOME}/.bashrc"

echo "env HOME=${HOME}"
echo "env USER=${USER}"
echo "---> Current version:"
egrep --color=always -w "^(alias|export PATH)" ${r}

#echo "sleeping for 10sec..."
#sleep 10

echo

###############################################
#### patching
sed -i "s/.*alias ls.*/alias ls='ls -l --color=always'/" ${r}
sed -i "s/.*alias grep.*/alias grep='grep --color=always'/" ${r}
sed -i "s/.*alias vi.*/alias vi='vim'/" ${r}

echo "---> Patched version:"
egrep --color=always "^(alias|export PATH)" ${r}
