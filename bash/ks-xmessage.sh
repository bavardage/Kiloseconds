#!/bin/sh
export DISPLAY=:0.0

DATE=$((($(date +%s) - $(date +%s -d $(LC_ALL="C" date +%x)))/1000))
xmessage -center "$DATE Kiloseconds" -buttons ok
