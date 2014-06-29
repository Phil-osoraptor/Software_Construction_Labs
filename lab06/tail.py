#!/usr/bin/python

import sys
import re
from array import *

once = 0;
for arg in sys.argv:
	if (once == 0):
		once = 1
	else:
		lines = []
		f = open(arg)
		for line in f:
			line = re.sub(r"\n", "", line);
			lines.append(line)
		
		limit = 10
		if len(lines) < 10:
			limit = len(lines)

		for x in range((len(lines) - limit),len(lines)):
			print lines[x]


