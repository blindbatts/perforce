#!/bin/bash

# Variables
adminmail=edit@me.com
subject="NAS Backup rsync results"
remote=/media/qnap
local=/perforce
log=/perforce/scripts/p4sync.log
pid=$$

echo "`date +%x-%R` - $pid - Started Perforce to NAS rsync:" \n >> $log

echo "Copying new checkpoint files if they exist:" >> $log
#if [ -e $local/db/checkpoint.??.gz ]; then
#	rsync -avz $local/db/db.chk*.* $remote/db/ >> $log
#	else
#		echo "No new checkpoint files to sync - skipping." >>$log
#fi
echo "Copying new journal files if they exist:" >> $log
#if [ -e $local/db/journal.* ]; then
	rsync -avz $local/db/journal.* $remote/db/ >> $log
#	else
#		echo "No new journal files to sync - skipping.." >>$log
#fi
echo \n "Synchronizing depot file changes:" >> $log
	rsync -avz  $local/depots $remote/ >> $log
echo \n "synchronizing scripts:" >> $log
	rsync -avz $local/scripts/*.sh $remote/scripts/ >> $log
echo \n "synchronizing new log files if they exist:" >> $log
	rsync -avz $local/*.log $remote/ >> $log

#echo \n "Deleting any local checkpoint/journal files to trim space on db drive" >> $log
#if [ -e $local/db/journal.* ]; then
#	rm -f $local/db/journal.91*
#	else
#		echo "No journal files to delete, was a journal just truncated?" >>$log
#fi
#if [ -e $local/db/checkpoint.??.gz ]; then
#	rm -f $local/db/checkpoint.??.gz
#	else
#		echo "No checkpoint files to delete." \n >>$log
#fi

echo "`date +%x-%R` - $pid - Sync Finished!" >> $log

# Send the email
cat $log | mailx -s "$subject" "$adminmail"

rm $log

exit 0
