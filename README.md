#!/bin/bash

source /thangmv-rc

NOW=$(date +"%Y-%m-%d-%H%M")

openstack volume list -c ID -c "Display Name" -f csv > /var/log/cron/volume-list.$NOW 2>&1

while read line
do
	VOLUME_ID=$(echo $line | cut -d ',' -f 1)
	VOLUME_NAME=$(echo $line | cut -d ',' -f 2)

	openstack snapshot create --force --name $NOW_$VOLUME_NAME $VOLUME_ID
	sleep 8

	STATUS=$?
	if [ STATUS == 0]; then
		echo "Created snapshot for volume $VOLUME_NAME successfully." >> /var/log/cron/snapshot-report.$NOW 2>&1
	else
		echo "Failed to create snapshot of volume $VOLUME_NAME." >> /var/log/cron/snapshot-report.$NOW 2>&1
	fi

done < /var/log/cron/volume-list.$NOW

