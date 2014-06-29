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
	if (defined $wordHash{$ARGV[0]}) {
		printf ("%4d", $wordHash{$ARGV[0]});
		$perc = $wordHash{$ARGV[0]} / $total;
	} else {
		printf  ("%4d", 0);
		$perc = 0;
	}
	close (F); 
	#change author format
	$file =~ s/.txt//;	
	$file =~ s/_/ /g;	
	
	printf ("/%6d = %.9f %s\n", $total, $perc, $file);
	
}
