#!/usr/bin/python

import sys, re, subprocess

f = 0
if sys.argv[1] == '-f':
	f = 1
	sys.argv[1] = sys.argv[2] 

lines = []
partLine = []
url = sys.argv[1]
p = subprocess.Popen(["wget","-q","-O-",url], stdout=subprocess.PIPE)
for line in iter(p.stdout.readline, ""):
	line = line.rstrip('\n')	
	#line = re.sub(r'^[^<]*<' , '', line)
	if re.match(r'.*<[^!]*>', line):
		line = re.sub(r' [^<>]*', '', line)
		line = re.sub(r'^[^<]*<', '', line)
		#line = re.sub(r'^[^>]*>', '', line)
		
		#line = re.sub(r'<|>|\/', '', line)
    		#print line
		#lines.append(line)
		partLine = []
		partLine = line.split("<")
		for part in partLine:
			#print part
			part = part.rstrip('\n')
			part = re.sub(r'>.*', '', part)
			#print part
			part = re.sub(r'<|\/|>', '', part)
			part = re.sub(r'\t|-|!', '', part)
			#print part
			if not re.match(r'^$', part):
				lines.append(part)
				#print part


lines.sort()
newList = list(set(lines))

if not f:
	for x in newList:
		num = lines.count(x)
		print("%s %d" % (x, num))
else:
	a = []
	for x in newList:
		num = lines.count(x)
		b = []
		b.append(x)
		b.append(num)
		a.append(b)

	a.sort(key=lambda y: y[1])
	z = 0
	for d in a:
		print("%s %d" % (d[0], d[1]))
		z = z + 1
	
		





