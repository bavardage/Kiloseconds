import time
tm = time.localtime()
print (tm.tm_hour*3600+tm.tm_min*60+tm.tm_sec)/1000.0, "kiloseconds"
