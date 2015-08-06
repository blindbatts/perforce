#!/bin/bash

adminmail=edit@me.com
subject="Starting up Perforce Server"
remote=/media/qnap/perforce
local=/perforce
log=$local/p4start.log
pid=$$

echo "`date +%x-%R` - $pid - Starting Perforce server, any errors will follow:" >> $log

## Start the P4D Server
	/usr/local/bin/p4d -r $local/db -J $local/journals/Journal -L $local/db/p4d.log -In master -p 1666& >> $log
	echo "`date +%x-%R` - $pid - Perforce Started!" >> $log
## Send the email
        cat $log | mailx -s "$subject" "$adminmail"
## Delete the temp log used to create the email
        rm $log
exit 0
