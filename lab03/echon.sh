
if test $# -eq 2 
then
   if test $1 -ge 0 
   then
      for x in `seq 1 $1`
      do
         echo "$2"
      done
      exit 0
   else
      echo "argument 1 must be a non-negative integer"
      exit 2
   fi
else
   echo "Usage: ./echon.sh"
   exit 2
fi
