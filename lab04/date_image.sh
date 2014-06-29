 

for file in $@
do

	 month="`ls -l $file | cut -f6 -d' '`"
	 day="`ls -l $file | cut -f7 -d' '`"
 	 time="`ls -l $file | cut -f8 -d' '`"
         stamp="$month $day $time"
	 echo $stamp
	 convert -gravity south -pointsize 36 -annotate 0 "$stamp" $file result.png

	  mv result.png $file
	 touch -d"$stamp" $file
	
	 

done

