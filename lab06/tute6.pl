#!/usr/bin/perl


#2)
foreach $url (@ARGV) {
	open F, "wget -q -O- $url |" or die; 
# -O- means stdout

	while ($line = <F>) {
		@nums = split /[^/d-]/, $line
		foreach $num (@nums) {
			$num =~ s/\D//g;
			print "$num\n" if length $num >= 8 && length $num <= 15
		}
	}
}

#3)
#a) (x) ((x)) (((x)))
#b) hell 
#c) 11,12,13
#d) 

#4) 

$total = 0;
foreach $file (glob("*.c *.h")) {
	open F, "< $file" or die;
	@lines = <F>;
	$size = scalar@lines;
	print "$size $file\n";
	$total += $size;

}
print $total;



#5)
while ($line = <>) {
	($id, $mark) = split (/ /, $line);
#can do ($id, @rest) for multiple fields
	print "$id "
	if ($mark =~ /^\d+$/) {
	print "??" if ($mark < 0 || $mark > 100) { 
		} elsif ($mark < 50) {
			print "FL";
		} elsif ($mark < 65) {
			print "PS";
		} else {
			print "HD";
		}
		
	}
}


#6)
#using hashes

open <P>, "<phones.txt" or die;
while ($line = <P>) {
	($user, $type, $num) = split /,/,$linel
	$phones{"$user, $type"} = $num;
	open P, "<people.txt" or die;
	while ($line = <P>) {
		($user, $real_name, $addr) = split /,/,$line;
		$num_phones = 0;
		print "$real_name\n$addr\n";
		@types = ("mobile", "home", "work");
		foreach $type (@types) {
			$key = $user.$type;
			if (defined $phones{$key}) {
				print "$phones{$key} ($type)\n";
				$phones++;
				#print ""
			}
		}
		 	
	}

	
