#!/usr/bin/perl

$count = 0;
while (<>) {
	my($line) = $_;
	chomp($line);
	push(@lines, $line);
	$count++;
}

$i = 0;

while ($i < $count) {
	$r = rand($count);
	if ($lines[$r] !~ /^$/) {
		print "$lines[$r]\n";
		$lines[$r] = '';
		$i++;	
	}
}
