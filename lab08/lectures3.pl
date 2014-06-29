#!/usr/bin/perl 



if ($ARGV[0] eq "-d") {
	$d = 1;
	shift(@ARGV);
}
if ($ARGV[0] eq "-t") {
	$t = 1;
	shift(@ARGV);
}



foreach $subject (@ARGV) {
	#print "$subject\n";
$url = "http://www.timetable.unsw.edu.au/2012/${subject}.html";

	@lines = ();
	@sems = ();
	$first = 0;
	$sem;
	$prevSem;
	#$semone = 0;
	open F, "wget -q -O- $url|" or die;
		while ($line = <F>) {
			#if ($line =~ /Lecture/) {print $line, "\n";}
			if ($line =~ /Lecture/i && $line =~ /S1|S2/) {
				#print $line, "\n";
				#if ($line =~ /S1/) {$semone = 1;}
				chomp $line;
				$line =~ s/ {2,}//;
				$line =~ s/\<|\>|td|class="data"|\/|a href="#|"|Lecture|a//g;
				$line =~ s/ {2,}/ /g;
				$line =~ s/^ //;
				#print "$line\n";
				$sem = substr($line, 0,2);				
				#push(@lines, $line);
			}	
			
			if ($line =~ /Mon|Tue|Wed|Thu|Fri/ && $line =~ /[0-9]{2}:[0-9]{2} -/) {
				
				chomp $line;
				$line =~ s/ {2,}//;
				$line =~ s/\<|\>|td|class="data"|\///g;
				$line =~ s/ {2,}/ /g;
				$line =~ s/^ //;
				#print $line, "\n";
				if ((! ($prevSem eq $sem)) || $first == 0) {
					push(@lines, $line);
					push(@sems, $sem);
					$first = 1;
				}
				$prevSem = $sem;

							
			} 
			
			
		}
	close (F);
	
	$i = 0;
	foreach $course (@lines) {
		if ($d) {
			$course =~ s/,|-|Weeks:|\(|\)|:00//g;
			$course =~ s/ {2,}/ /g;
			($day1, $time11, $time12, $null, $day2, $time21, $time22, $null, $day3, $time31, $time32) = split(' ',$course);
			#print "$day1, $time11, $time12, $day2, $time21, $time22\n";
			for ($x = $time11; $x < $time12; $x++) {
				print "$sems[$i] $subject $day1 $x\n";
			}
			for ($x = $time21; $x < $time22; $x++) {
				print "$sems[$i] $subject $day2 $x\n";
			}
			for ($x = $time31; $x < $time32; $x++) {
				print "$sems[$i] $subject $day3 $x\n";
			}
			
			#print "$subject: $sems[$i] $course\n";

		} elsif ($t) {

			$course =~ s/,|-|Weeks:|\(|\)|:00//g;
			$course =~ s/ {2,}/ /g;
			$course =~ s/09/9/g; #09 cannot be stored in array
			($day1, $time11, $time12, $null, $day2, $time21, $time22, $null, $day3, $time31, $time32) = split(' ',$course);
			#print "$day1, $time11, $time12, $day2, $time21, $time22\n";
			#$subjects{$day1}{$x}++;
			for ($x = $time11; $x < $time12; $x++) {
				$subjects{$sems[$i]}{$x}{$day1}++;
			}
			for ($x = $time21; $x < $time22; $x++) {
				$subjects{$sems[$i]}{$x}{$day2}++;
			}
			for ($x = $time31; $x < $time32; $x++) {
				$subjects{$sems[$i]}{$x}{$day3}++;
			}

			#print "$subject: $sems[$i] $course\n";


		} else {	
			#print "$subject: $sems[$i] $course\n";
		}

		$i++;
	}

	

}

foreach $sem (keys %subjects) {

	print "$sem\tMon\tTue\tWed\tThu\tFri\n";
	print "0";
	for ($x = 9; $x <= 20; $x++) {
		printf "$x:00";
		#print $subjects{$sem}{$x};
		@days = ();	
		if (defined $subjects{$sem}{$x}) {
			foreach $day (sort keys %{$subjects{$sem}{$x}}) {
							
				push(@days, $day);				
				#print "\t$subjects{$sem}{$x}{$day}";
			}
		}
		
		print "\t";
		$day = 'Mon';
		if (in($day)) {
			print "$subjects{$sem}{$x}{$day}";
		}
		print "\t";
		$day = 'Tue';
		if (in($day)) {
			print "$subjects{$sem}{$x}{$day}";
		}
		print "\t";
		$day = 'Wed';
		if (in($day)) {
			print "$subjects{$sem}{$x}{$day}";
		}
		print "\t";
		$day = 'Thu';
		if (in($day)) {
			print "$subjects{$sem}{$x}{$day}";
		}
		print "\t";
		$day = 'Fri';
		if (in($day)) {
			print "$subjects{$sem}{$x}{$day}";
		}

		print "\n";
		
	}
	
	
}

sub in {
	my ($x) = @_;
	my ($found);
	foreach $elem (@days) {
		if ($x eq $elem) {
			$found = 1;
		}
	}

	return $found;
}
