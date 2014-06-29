#!/usr/bin/perl

#1)
$url = $ARGV[0];
open F, "wget -q -O- $url|" or die;
while ($line = <F>) {
	@tags = $line =~ /<\/?([\w]+)/g;
	foreach $tag(@tags) {
		$count{$tag}++;
	}
}

foreach $tag(sort keys %count) {
	print "$tag $count{$tag}\n";
}

@sorted = sort{$count{$a}<==>$count{$b}} keys %count;



#3)
sub getn {
	$n_lines = $_[0]; #or @_ to grab all
	while ($n_lines > 0) {
		$result .= <>;
	}
	return $result;
}


#4)
foreach $file (glob "*.c") {
	open F, "<$file" or die;
	while ($line = <F>) {
		$line =~ s/".*?"//g;
		$line =~ s/\/\/.*//;
		$line =~ s/\/[*].*?[*]\///g;
		if ($line =~ /^\w.*$match/) {
			print "$file $match $defined\n";
		} else if ($line =~ /\s+.*$match/) {
			print "$file $match $usedin\n";
		}
	}
}


#5)
open F, "<$ARGV[0]" or die;
while ($line = <F>) {
	$line =~ /^\w+.*\(.*\)/ or next;
	$first = $1;
	$second = $2;
	@parts = split /(\w+[^\w]+(\w+)/;
	print "func type = $1\n";
	print "func name = $2\n";
}


#6)

sub printFile ($) {
	($file) = @_;
	open my $F, "$file" or die;
	while (my $line = <$F>) {
		if ($line =~ /#include "(.*)"/) {
			my $x = $1
			printFile($x);
		} else {
			print $line;
		}
	}
}


#7)

@dirs = ('/usr/include','/usr/local/include','linux gnu');
foreach $file (@dirs) {
	$full = "$path/$file";
	if (open my $f, "<$full") {
		break;
	}
}


#8)
$rows = $ARGV[0];
$cols = $ARGV[1];
$width = $ARGV[2];

foreach $r (1..$rows) {
	printf ("%${width}d ", $r);
	foreach $c (1..$cols) {
		printf ("%${width}d", $r*$c);
	}
	print "\n";
}






































 
