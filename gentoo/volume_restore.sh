#!/bin/bash
sudo amixer -q set "Master" 30% unmute
sudo amixer -q set "PCM" 100%
sudo amixer -q set "Speaker" 100% unmute
sudo amixer -q set "Headphone" 0% mute
sudo amixer -q set "Headphone Mic" 0% mute
sudo amixer -q set "Headphone Mic Boost" 0%
sudo amixer -q set "Internal Mic Boost" 0%
