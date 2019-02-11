#!/bin/bash

if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi

echo "connecting to fsp_server($fsp_server:$fsp_port)..."
ssh $user@$fsp_server -p $fsp_port
#ssh $user@$fsp_server1 -p $fsp_port1 || ssh $user@$fsp_server2 -p $fsp_port2 || ssh $user@$fsp_server3 -p $fsp_port3
