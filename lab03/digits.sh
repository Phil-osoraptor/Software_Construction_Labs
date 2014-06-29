
while read line
do     
    sed -e 's/[0-4]/</g' -e 's/[6-9]/>/g'
done


