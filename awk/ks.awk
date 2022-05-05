#!/bin/awk -f
BEGIN {
	patsplit(strftime("%T"), t, /[0-9]{2}/)
	printf "It is %.3f kiloseconds.\n", (t[1]*3600 + t[2]*60 + t[3]) / 1000
}
