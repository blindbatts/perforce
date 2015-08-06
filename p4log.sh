#!/bin/bash

adminmail=edit@me.com
subject="P4D: Nightly Log file rotation finished"
remote=/media/qnap
local=/perforce
log=$local/p4chkpt.log
pid=$$

echo "`date +%x-%R` - $pid - Started nightly Perforce log file checkpoint" >> $log

# Do the actual checkpoint
	mv $local/db/p4d.log $local/p4d-$(date +%m%d%y).log

echo "`date +%x-%R` - $pid - Log file checkpointing finished!" >> $log

# Send the email
	cat $log | mailx -s "$subject" "$adminmail"

rm $log

exit 0
