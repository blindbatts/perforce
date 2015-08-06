#!/bin/bash
adminmail=edit@me.com
subject="Perforce Nightly checkpoint and journal clean up results"
remote=/media/qnap
local=/perforce
log=/perforce/scripts/p4cleanup.log
pid=$$

echo "`date +%x-%R` - $pid - Started cleanup of log + checkpoint + journal files >10 days old" >> $log

	find $remote/db*.* -type f -mtime +10 -exec rm {} \; >> $log
	find $remote/db/journal.* -type f -mtime +10 -exec rm {} \; >> $log
	find $local/db/journal.* -type f -mtime +10 -exec rm {} \; >> $log
	find $local/p4d*.log -type f -mtime +10 -exec rm {} \; >> $log
	find $local/*.csv -type f -mtime +10 -exec rm {} \; >> $log

echo "`date +%x-%R` - $pid - Finished" >> $log

## Send the email
	cat $log | mailx -s "$subject" "$adminmail"
        rm $log
exit 0
