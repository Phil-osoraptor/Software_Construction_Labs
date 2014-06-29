#!/usr/bin/perl


foreach $file (glob "*.txt") {
	if (grep(/poem/, $file)) {next;}
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
	
	close (F); 
	

	
	foreach $word (keys %wordHash) {
	
		$logs{$file}{$word} = log(($wordHash{$word} + 1) / $total);	
	}	
	$logs{$file}{'oneDividedByTotal'} = log(1 / $total);	
	
}

foreach $poem (@ARGV) {

	$max = -9999;
	foreach $file (keys %logs) {
		$logTotal = 0;

		open F, "<$poem" or die;

		while ($line = <F>) {
			@words = split("[^A-Za-z]",$line);
			foreach $word (@words) {
				$word =~ tr/A-Z/a-z/;
				if ($word !~ /^$/) {
					if (! $logs{$file}{$word}) {
						$logTotal += $logs{$file} {'oneDividedByTotal'};
					} else {
						$logTotal += $logs{$file}{$word};
					}
				}
			}
		}
		close (F);

		$file =~ s/.txt//;	
		$file =~ s/_/ /g;

		if ($logTotal > $max) {
			$max = $logTotal;
			$chosenFile = $file;
		}
		#print "$poem : $file : $logTotal\n";
		
	}
	printf ("%s most resembles the work of %s (log-probability=%.1f)\n", $poem, $chosenFile, $max);

							
}
