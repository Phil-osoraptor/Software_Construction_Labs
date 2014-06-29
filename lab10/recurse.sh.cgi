#!/bin/sh

cat <<eof
Content-type: text/html

<!DOCTYPE html>
<html lang="en">
<head></head>
<body>
<pre>
<p>Level `expr $QUERY_STRING + 1`: <a href="$SCRIPT_URI?`expr $QUERY_STRING + 1`">Run me again
</a>
</p>


</pre>
</body>
</html>
eof
