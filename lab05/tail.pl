#!/usr/bin/perl


#if there are no arguments (no file)

if ($#ARGV == -1) {
	$count = 0;
	while (<>) {	
		my($line) = $_;
		chomp($line);
		push(@lines, $line);
		$count++;
	}

	for ($num = $count-1; $num >= 0; $num--) {
		print "$lines[$#lines - $num]\n";
	}
} elsif (($ARGV[0] =~ /-/) && ($#ARGV == 0)) {
	$limit = $ARGV[0];
 	$limit =~ s/-//g;
shift;
	#pop(@ARGV);
	$count = 0;

	while (<>) {	
		my $line = $_;
		chomp($line);
		push(@lines, $line);
		$count++;
	}
	if ($limit > $count) {
		$limit = $count;
	}

	for ($num = $limit-1; $num >= 0; $num--) {
		print "$lines[$#lines - $num]\n";
	}

} else {
	if ($ARGV[0] =~ /-/) {
		$origlimit = $ARGV[0];
		$origlimit =~ s/-//g;	
		#print "$limit\n";
		$dash = 1;	
	} else {
		$dash = 0;
		$origlimit = 10;
		$limit = $origlimit;
		$filename = $ARGV[0];		
		#open first file
		if (! -r $filename) {
			print "tail.pl: can't open $filename\n";
		}
		open(DATA,"<$filename") or die "file not open";
		while(<DATA>) {
			my($line) = $_;
			chomp($line);
			#print "$line\n";
			push(@lines, $line);			
		}
		if ($limit > $#lines+1) {
			$limit = $#lines+1;
		}
		if ($#ARGV >= 1) {
			print "==> $filename <==\n";
		}
		
		for ($num = $limit-1; $num >= 0; $num--) {
			print "$lines[$#lines - $num]\n";
		}

		#clear array
		@lines = ();
		close(DATA);

		
	}	
	$limit = $origlimit;
	for ($i = 1; $i <= $#ARGV; $i++) {
		$filename = $ARGV[$i];
		#print "limit - $limit\n";
		if (! -r $filename) {
			print "tail.pl: can't open $filename\n";
			next;	
		} 		
		open(DATA,"<$filename") or die "file not open";
		while(<DATA>) {
			my($line) = $_;
			chomp($line);
			#print "$line\n";
			push(@lines, $line);			
		}		
		

		#if limit is bigger than size of array, make limit the size of the array
		#print "$limit\n";
		#print "$#lines\n";
		if ($limit > $#lines+1) {
			$limit = $#lines+1;
		}
		#print "limit - $limit\n";
		if (($#ARGV >= 1 && $dash == 0) || ($#ARGV >= 2 && $dash == 1)) {
			print "==> $filename <==\n";
		}

		for ($num = $limit-1; $num >= 0; $num--) {
			print "$lines[$#lines - $num]\n";
		}

		#clear array
		@lines = ();
		close(DATA);

		$limit = $origlimit;	

	
	}
	

}



