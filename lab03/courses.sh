#1 is the grep search
#eg grep JAPN 


wget -q -O- "http://www.handbook.unsw.edu.au/vbook2012/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr=All" | grep "2012/$1" |
sed -e 's/<TD class\=\"\"><A href="http\:\/\/www\.handbook\.unsw\.edu\.au\/undergraduate\/courses\/2012\///g' -e 's/\.html\">//g' -e 's/<\/A><\/TD>//g' -e 's/<TD class\=\"evenTableCell\"><A href\=\"http\:\/\/www\.handbook\.unsw\.edu\.au\/undergraduate\/courses\/2012\///g' | cut -f9 | sed 's/[0-9][0-9][0-9][0-9]/& /g'
