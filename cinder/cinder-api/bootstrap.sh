#!/bin/bash

sed -i "s/CINDER_DBPASS/$CINDER_DBPASS/g" /etc/cinder/cinder.conf
sed -i "s/DB_HOST/$DB_HOST/g" /etc/cinder/cinder.conf

cinder-manage db sync
