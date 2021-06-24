#!/bin/bash

# Variables
adminmail=edit@me.com
subject="Perforce: Weekly depot verification results"
remote=/media/qnap/
local=/perforce
log=$local/scripts/p4verify.log
pid=$$

echo "`date +%x-%R` - $pid - Starting p4d -xv any inconsistancies found will follow:" >> $log
	p4d -r $P4ROOT -xv >> $log

echo "`date +%x-%R` - $pid - Starting P4Verify any inconsistancies found will follow:" >> $log

# Do the actual verify script
	p4 verify -q //... >> $log

echo "`date +%x-%R` - $pid - P4Verify Finished!" >> $log

## Send the email
        cat $log | mailx -s "$subject" "$adminmail"

rm $log
exit 0
