#!/bin/bash


for file in *.jpg
do
	if test ! -r $file
	then
echo "$file already exists"
	exit 1
	fi
        echo "$file"        
        f=${file%.*}
        if test -f "$f.png"
        then
		echo "$file already exists"
		exit 1
	else
		convert "$f.jpg" "$f.png"
		rm "$f.jpg"
	fi

done
