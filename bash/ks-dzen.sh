#!/bin/sh

echo "It's $((($(date +%s) - $(date +%s -d $(LC_ALL="C" date +%x)))/1000)) kiloseconds."  | dzen2 -p 60 -fn '-*-*-*-*-*-*-20-*-*-*-*-*-iso10646-*' -x 200 -y 200 -w 300 -l 1 -bg blue  -sa c -e 'onstart=uncollapse;button3=exit'
