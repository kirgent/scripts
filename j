#!/bin/bash

if [ $(whoami) != "root" ]; then
echo "you must be root to run"
exit 1
fi

journalctl -xf
