#!/bin/bash
adminmail=edit@me.com
subject="Perforce journal truncated"
remote=/media/qnap/
local=/perforce
log=$local/scripts/p4jj.log
pid=$$

echo "`date +%x-%R` - $pid - Started Perforce journal truncation" >> $log

	/usr/local/bin/p4d -jj -r $local/db -J $local/journals/Journal >> $log

echo "`date +%x-%R` - $pid - Finished!" >> $log

## Send the email
	cat $log | mailx -s "$subject" "$adminmail"

rm $log
exit 0
