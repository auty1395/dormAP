#!/bin/bash
LOGFILE=network.log

echo "last checked:" $(date)  >  $LOGFILE

if [ $(ping -c1 -n -w1 8.8.8.8 2>&1 | grep -o unreachable)  ] 
then 
	echo "Unreachable. Trying again.." | tee -a $LOGFILE
	if [ $(ping -c3 -n 8.8.8.8 2>&1 | grep -o unreachable) ]
	then
		echo "still unreachable..." | tee -a $LOGFILE
		echo "scrambling MAC and reconnecting.." | tee -a $LOGFILE
		./macrandom.sh |& tee -a $LOGFILE
	else 
		echo "network good" | tee -a $LOGFILE
	fi

else
echo "network good" | tee -a $LOGFILE
fi
echo
