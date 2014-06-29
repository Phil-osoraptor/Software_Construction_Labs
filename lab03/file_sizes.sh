
small="Small files: "
medium="Medium-sized files: "
large="Large files: " 

#loop through all files in directory
for x in *
do
        #count number of lines
	count=0
	while read line
	do     
	    count=`expr $count + 1`
	done < $x

	#echo "$x - $count"

        #sort by line size and concatenate to appropriate variable
        if test $count -lt 10 
        then
           small="$small $x"
        elif test $count -lt 100
        then
           medium="$medium $x"
        else
           large="$large $x"
        fi

done

echo $small
echo $medium
echo $large
