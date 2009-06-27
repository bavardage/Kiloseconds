#!/bin/sh
# Note you need to install zenity ( pacman -S zenity)
export DISPLAY=:0.0

DATE=$((($(date +%s) - $(date +%s -d $(LC_ALL="C" date +%x)))/1000))
zenity --info --text "$DATE kiloseconds"
