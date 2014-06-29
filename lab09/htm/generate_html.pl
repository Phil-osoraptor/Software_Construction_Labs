#!/usr/bin/perl



open E, "<enrollments.txt" or die;
open C, "<course_codes.txt" or die;

$out = "<h2>Index Page</h2><h2>All Courses</h2>";

$out = $out."<ul>";

$c = `cut -f1 -d'|' enrollments.txt | sort | uniq`;
@courses = split /\n/,$c;
foreach $course (@courses) {
	$c = `grep $course course_codes.txt`;
	#print "$c";
	chomp $c;
	$li = "<li><a href=\"$course.html\">$c</a>";
	$out = $out.$li;

	$file = "$course.html";
	if (-e $file) {
		$a = `rm $course.html`;
	}
	open X, ">>${course}.html" or die;
	$s = `grep $course enrollments.txt | cut -f2,3 -d'|' | sort -t'|' -k2`;
	$s =~ s/\|/ /g;
	$s =~ s/[ ]{2,}//g;
	
	$sOut = "<h2>Students Enrolled in $c</h2>";
	$sOut = $sOut."<ul>";
	@students = split /\n/,$s;
	foreach $student (@students) {
		#print "$student";	
		chomp $student;
		$s = substr($student,0,7);
		$li = "<li><a href=\"$s.html\">$student</a>";
		$sOut = $sOut.$li;
	}
	$sOut = $sOut."</ul>";
	
	print X $sOut;
	close(X);
}

$out= $out."</ul>";



$out = $out."<h2>All Students</h2>";
$out = $out."<ul>";
$s = `grep COMP enrollments.txt | cut -f2,3 -d'|' | sort -t'|' -k2 | uniq`;
$s =~ s/\|/ /g;
$s =~ s/[ ]{2,}//g;

#print $s;
@students = ();
@students = split /\n/,$s;
foreach $student (@students) {
	#print "$student";	
	chomp $student;
	$s = substr($student,0,7);
	$li = "<li><a href=\"$s.html\">$student</a>";
	$out = $out.$li;


	$file = "$s.html";
	if (-e $file) {
		$a = `rm $s.html`;
	}
	open X, ">>$s.html" or die;
	$c = `grep $s enrollments.txt | cut -f1 -d'|' | sort | uniq`;
	

	$cOut = "<h2>Courses taken by $student</h2>";
	$cOut = $cOut."<ul>";
	@courses = ();
	@courses = split /\n/,$c;
	foreach $course (@courses) {
		$c = `grep $course course_codes.txt`;
		#print "$student";	
		chomp $c;
		$li = "<li><a href=\"$course.html\">$c</a>";
		$cOut = $cOut.$li;
	}
	$cOut = $cOut."</ul>";
	
	print X $cOut;
	close(X);
}

$out= $out."</ul>";


$a = `rm index.html`;
open A, ">>index.html" or die;
print A $out;
