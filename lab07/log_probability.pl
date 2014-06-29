#!/usr/bin/perl


foreach $file (glob "*.txt") {
	$total = 0;
        #print "$file\n";
	%wordHash = ();

	open F, "<$file" or die;

	while ($line = <F>) {
		@words = split("[^A-Za-z]",$line);
		foreach $word (@words) {
			$word =~ tr/A-Z/a-z/;
			if ($word !~ /^$/) {
				$wordHash{$word}++;
				$total++;
				#print "$word\n";
			}
		}
	}
	print "log((";
	if (defined $wordHash{$ARGV[0]}) {
		printf ("%d+1)", $wordHash{$ARGV[0]});
		$perc = $wordHash{$ARGV[0]} / $total;
	} else {
		printf  ("%d+1)", 0);
		$perc = 0;
	}
	close (F); 
	#change author format
	$file =~ s/.txt//;	
	$file =~ s/_/ /g;

	$logCalc = log((($perc * $total) + 1) / $total);	
	
	printf ("/%6d) = %8.4f %s\n", $total, $logCalc, $file);
	
}
