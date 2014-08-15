#!/bin/awk -f
BEGIN {
	  KS=(strftime("%H")*3600+strftime("%M")*60+strftime("%S"))/1000;
	    printf("It is %s kiloseconds.\n",KS);
    }

