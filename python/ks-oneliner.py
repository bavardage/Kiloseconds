#!/usr/bin/env python

# If nothing else, this example proves that it is possible to write difficult to read code also in python...
# Uses list comprehension, lambdas, map, zip and string formatting.

import time
print "It is %2.3f kiloseconds."%(sum(map((lambda t: t[0]*t[1]),zip(time.localtime()[3:6],[60**(2-i) for i in range(3)])))/1e3)

