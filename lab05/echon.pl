#!/usr/bin/perl

if ($#ARGV != 1) {
print "Usage: ./echon.pl\n";	
exit 1;
}

$one = $ARGV[0];
$two = $ARGV[1];

for ($i = 0; $i < $one; $i++) {
	print "$two\n";
}

