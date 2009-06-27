#!/usr/bin/env python

import subprocess
import time

#Get time in kiloseconds

tm = time.localtime()
ks = (tm.tm_hour*3600+tm.tm_min*60+tm.tm_sec)/1000.0



info = "The time in kiloseconds: "
msg =  str(ks)
subprocess.call(('notify-send',info,msg))
