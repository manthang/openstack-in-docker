#!/bin/bash

# NOTE(pbourke): apache2  will not clean up after itself in some cases which
# results in the container not being able to restart. (bug #1489676, 1557036)

# Loading Apache2 ENV variables
. /etc/apache2/envvars
rm -rf /var/run/apache2/*

sed -i "s/MY_IP/$MY_IP/g" /etc/cinder/cinder.conf

sed -i "s/CINDER_DBPASS/$CINDER_DBPASS/g" /etc/cinder/cinder.conf
sed -i "s/DB_HOST/$DB_HOST/g" /etc/cinder/cinder.conf

sed -i "s/CONTROLLER_HOST/$CONTROLLER_HOST/g" /etc/cinder/cinder.conf
sed -i "s/CINDER_PASS/$CINDER_PASS/g" /etc/cinder/cinder.conf

sed -i "s|TRANSPORT_URL|$TRANSPORT_URL|g" /etc/cinder/cinder.conf

sed -i "s/MEMCACHED_SERVERS/$MEMCACHED_SERVERS/g" /etc/cinder/cinder.conf
sed -i "s/MEMCACHE_SECRET_KEY/$MEMCACHE_SECRET_KEY/g" /etc/cinder/cinder.conf

sed -i "s/localhost/$HOSTNAME/g" /etc/apache2/apache2.conf

/usr/sbin/apache2ctl -D FOREGROUND
