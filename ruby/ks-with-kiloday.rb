#!/bin/bash
ruby -e "ENV['TZ']='US/Central';a=Time.now;puts \"Today is kiloday #{(a.year*365+a.month*12+a.day*24)/1000.0}, and the time is currently #{(a.hour*3600+a.min*60+a.sec)/1000.0} kiloseconds, #{a.zone}.\""

