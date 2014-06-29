#!/usr/bin/perl


my (@courses) = ();


	@lines = ();
	$url = "http://www.timetable.unsw.edu.au/current/${ARGV[0]}KENS.html";

	open F, "wget -q -O- $url|" or die;
		while ($line = <F>) {
			push(@lines, $line =~ /[A-Z]{4}[0-9]{4}/g);
		}
	close (F);

	foreach $line (@lines) {
		if (! in ($line)) {
			push(@courses, $line);		
		}
	}

	foreach $course (sort @courses) {
		print "$course\n";
	}



sub in {
	my ($x) = @_;
	my ($found);
	foreach $elem (@courses) {
		if ($x eq $elem) {
			$found = 1;
		}
	}

	return $found;
}
