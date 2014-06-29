 

for attach in "$@"
do

	read -p "Address to e-mail this image to? " address
	if  test -n $address
	then
		read -p "Message to accompany image? " message
		echo "$message" | mutt -s 'image' -a "$attach" -- "$address"
		#mail $email $message
	else
		echo "Email cannot be null"
		exit 1 
	fi


done
