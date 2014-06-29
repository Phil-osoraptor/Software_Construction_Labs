#!/usr/bin/perl


foreach $file (@ARGV) {

	open(DATA, "<$file") or die "file not open $file";
	chomp($line = <DATA>);
	print "$line";
	while($line = <DATA>) {
		chomp($line);
		print "\t$line";
	}
	close(DATA);
	print "\n";

}
