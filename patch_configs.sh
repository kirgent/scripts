#!/bin/bash

vimrc="/root/.vimrc"
if [ -z "`grep "syntax on" $vimrc`" ]; then
echo "syntax on" >> $vimrc
echo "set hlsearch" >> $vimrc
echo "set incsearch" >> $vimrc
echo "set encoding=utf-8" >> $vimrc
echo "set fileencoding=utf-8" >> $vimrc
echo "$vimrc is patched"
fi

vimrc="/home/$USER/.vimrc"
if [ -z "`grep "syntax on" $vimrc`" ]; then
echo "syntax on" >> $vimrc
echo "set hlsearch" >> $vimrc
echo "set incsearch" >> $vimrc
echo "set encoding=utf-8" >> $vimrc
echo "set fileencoding=utf-8" >> $vimrc
echo "$vimrc is patched"
fi


alias_ls="alias ls='ls -l --color=always'"
alias_grep="alias grep='grep --color=always'"
alias_egrep="alias egrep='egrep --color=always'"
alias_vi="alias vi='vim'"

bashrc="/root/.bashrc"
if [ -z "`grep "$alias_ls" $bashrc`" ]; then
echo "$alias_ls" >> $bashrc
echo "$alias_grep" >> $bashrc
echo "$alias_egrep" >> $bashrc
echo "$alias_vi" >> $bashrc
echo "alias ls was absent, now added"
fi

bashrc="/home/$USER/.bashrc"
if [ -z "`grep "$alias_ls" $bashrc`" ]; then
echo $alias_ls >> $bashrc
echo "$alias_grep" >> $bashrc
echo "$alias_egrep" >> $bashrc
echo "$alias_vi" >> $bashrc
echo "alias ls was absent, now added"
fi
