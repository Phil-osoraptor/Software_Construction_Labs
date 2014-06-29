#!/usr/bin/python

import sys
import re

for line in sys.stdin:
	line = re.sub(r"[0-4]", "<", line);
	line = re.sub(r"[6-9]", ">", line);
	line = re.sub(r"\n", "", line);
	print "%s" % line

	
	 
