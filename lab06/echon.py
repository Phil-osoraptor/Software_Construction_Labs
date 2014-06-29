#!/usr/bin/python

import sys

if len(sys.argv) != 3:
	print "Usage: ./echon.py"

else:
	for x in range(0, int(sys.argv[1])):
		print "%s" % sys.argv[2] 
