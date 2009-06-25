#!/bin/bash
echo "It's $((($(date +%s) - $(date +%s -d $(LC_ALL="C" date +%x)))/1000)) kiloseconds."
