#!/bin/bash

if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi

user="kir"
echo "connecting to sun_server($sun_server:$sun_port)..."
ssh $user@$sun_server -p $sun_port "./grep3.sh"


if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi

echo
echo "connecting to fsp_server($fsp_server:$fsp_port)..."
ssh $user@$fsp_server -p $fsp_port "./grep3.sh"

echo
echo "connecting to dvbs_server($dvbs_server:$dvbs_port)..."
ssh $user@$dvbs_server -p $dvbs_port "./grep3.sh"

echo
echo "connecting to zodiac_server($zodiac_server:$zodiac_port)..."
ssh $user@$zodiac_server -p $zodiac_port "./grep3.sh"
