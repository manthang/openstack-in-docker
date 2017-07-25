#!/bin/bash

sudo change_volume_perms.sh

sed -i "s/MY_IP/$MY_IP/g" /etc/cinder/cinder.conf

sed -i "s/CINDER_DBPASS/$CINDER_DBPASS/g" /etc/cinder/cinder.conf
sed -i "s/DB_HOST/$DB_HOST/g" /etc/cinder/cinder.conf

sed -i "s/CONTROLLER_HOST/$CONTROLLER_HOST/g" /etc/cinder/cinder.conf
sed -i "s/CINDER_PASS/$CINDER_PASS/g" /etc/cinder/cinder.conf

sed -i "s|TRANSPORT_URL|$TRANSPORT_URL|g" /etc/cinder/cinder.conf
sed -i "s/MEMCACHED_SERVERS/$MEMCACHED_SERVERS/g" /etc/cinder/cinder.conf

cinder-volume
