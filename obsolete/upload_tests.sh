#!/bin/bash

# work pc
if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg
# sun_server / home_pc
elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg
fi

echo "uploading to fsp_server($fsp_server:$fsp_port)... to remote $target_folder/tests..."
if [ -z "$1" ]; then
scp -C -p -P $fsp_port "test_"* $user@$fsp_server:$target_folder/tests
else
scp -C -p -P $fsp_port "$1"* $user@$fsp_server:$target_folder/tests
fi
echo


echo "uploading to dvbs_server($dvbs_server:$dvbs_port)... to remote $target_folder/tests..."
if [ -z "$1" ]; then
scp -C -p -P $dvbs_port "test_"* $user@$dvbs_server:$target_folder/tests
else
scp -C -p -P $dvbs_port "$1"* $user@$dvbs_server:$target_folder/tests
fi
echo


echo "uploading to zodiac_server($zodiac_server:$zodiac_port)... to remote $target_folder/tests..."
if [ -z "$1" ]; then
scp -C -p -P $zodiac_port "test_"* $user@$zodiac_server:$target_folder/tests
else
scp -C -p -P $zodiac_port "$1"* $user@$zodiac_server:$target_folder/tests
fi
echo

user="kir"
target_folder="/home/kir/cygwin"

echo "uploading to sun_server($sun_server:$sun_port)... to remote $target_folder/tests..."
if [ -z "$1" ]; then 
scp -C -p -P $sun_port "test_"* $user@$sun_server:$target_folder/tests
else
scp -C -p -P $sun_port "$1"* $user@$sun_server:$target_folder/tests
fi
