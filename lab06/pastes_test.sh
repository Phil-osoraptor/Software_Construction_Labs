#!/bin/sh

echo "Running /usr/bin/paste\n"
paste -s /home/cs2041/public_html/lab/perl/paste/data? > output1

echo "Running ./pastes.pl\n"
./pastes.pl /home/cs2041/public_html/lab/perl/paste/data? > output2

echo "Running diff on the output\n";

if diff output1 output2 
then echo "Test succeeded - output of ./pastes.pl matched /usr/bin/paste"
fi



