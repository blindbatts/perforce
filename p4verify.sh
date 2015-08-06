#!/bin/bash

# Variables
adminmail=itreports@zindagigames.com
subject="Perforce: Weekly depot verification results"
remote=/media/qnap/
local=/perforce
log=$local/scripts/p4verify.log
pid=$$

echo "`date +%x-%R` - $pid - Starting P4Verify any inconsistancies found will follow:" >> $log

# Do the actual verify script
	p4 verify -q //... >> $log

echo "`date +%x-%R` - $pid - P4Verify Finished!" >> $log

## Send the email
        cat $log | mailx -s "$subject" "$adminmail"

rm $log
exit 0
