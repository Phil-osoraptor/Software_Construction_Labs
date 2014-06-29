#!/bin/sh

cat <<eof
Content-type: text/html

<!DOCTYPE html>
<html lang="en">
<head></head>
<body>
<pre>

<table border=1>
<tr>
<td>Browser IP Address</td>
<td>$REMOTE_ADDR</td>
</tr>
<tr>
<td>Browser Hostname</td>
<td>`hostname`</td>
</tr>
<tr>
<td>Browser</td>
<td>$HTTP_USER_AGENT</td>
</tr>
</table>



</pre>
</body>
</html>
eof


#`env`
#`REMOTE_ADDR`
#`HTTP_USER_AGENT`
#`SERVER_ADDR`
