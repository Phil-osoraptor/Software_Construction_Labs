#!/usr/bin/perl




if (($ARGV[0] eq '-r') && $#ARGV == 1) {
	$recurse = 1;	
	search($ARGV[1]);
	
	foreach $subject (sort(@courseList)) {
		print "$subject\n"; 		
	} 

} else {
	search($ARGV[0]);
	foreach $subject (sort(@courseList)) {
		print "$subject\n"; 		
	} 
}

sub in {
	my ($x) = @_;
	my ($found);
	foreach $elem (@courseList) {
		if ($x eq $elem) {
			$found = 1;
		}
	}
	return $found;
}
	
sub search {
	my ($course) = @_;

	$begin = "http://www.handbook.unsw.edu.au/undergraduate/courses/2012/";
	
	#$course = $ARGV[0];
	$end = ".html";
	
	$url = $begin.$course.$end;

	open F, "wget -q -O- $url|" or die;
	while ($line = <F>) {
		if ($line =~ /.*Prerequisite.*/) {
			push(@list, $line =~ /[A-Z]{4}[0-9]{4}/g);	
		}
	}
	close (F);

	$begin = "http://www.handbook.unsw.edu.au/postgraduate/courses/2012/";
	$url = $begin.$course.$end;

	open F, "wget -q -O- $url|" or die;
	while ($line = <F>) {
		if ($line =~ /.*Prerequisite.*/) {
			push(@list, $line =~ /[A-Z]{4}[0-9]{4}/g);	
		}
	}
	close (F);

	foreach $subject (@list) {	
		if (! in ($subject)) {	
			push (@courseList, $subject);
			#print "$subject\n";
			search($subject) if $recurse;
		}
	}
	return @list;
}

