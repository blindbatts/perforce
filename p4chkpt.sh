#!/bin/bash
# Variables
adminmail=edit@me.com
subject="Perforce weekly checkpoint finished"
remote=/media/qnap
local=/perforce
log=$local/scripts/p4chkpt.log
pid=$$

echo "`date +%x-%R` - $pid - Started weekly Perforce checkpoint" >> $log

# Do the actual checkpoint
/usr/local/bin/p4d -r $local/db -jc /$remote/db >> $log

echo "`date +%x-%R` - $pid - Checkpointing Finished!" >> $log

# Send the email
        cat $log | mailx -s "$subject" "$adminmail"
# Delete the temp log file used to create the email
      rm $log
exit 0
