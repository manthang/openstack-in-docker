#!/bin/bash

sudo change_volume_perms.sh

sed -i "s/MY_IP/$MY_IP/g" /etc/glance/glance-registry.conf

sed -i "s/GLANCE_DBPASS/$GLANCE_DBPASS/g" /etc/glance/glance-registry.conf
sed -i "s/DB_HOST/$DB_HOST/g" /etc/glance/glance-registry.conf

sed -i "s/CONTROLLER_HOST/$CONTROLLER_HOST/g" /etc/glance/glance-registry.conf
sed -i "s/GLANCE_PASS/$GLANCE_PASS/g" /etc/glance/glance-registry.conf

sed -i "s|TRANSPORT_URL|$TRANSPORT_URL|g" /etc/glance/glance-registry.conf

sed -i "s/MEMCACHED_SERVERS/$MEMCACHED_SERVERS/g" /etc/glance/glance-registry.conf
sed -i "s/MEMCACHE_SECRET_KEY/$MEMCACHE_SECRET_KEY/g" /etc/glance/glance-registry.conf

glance-registry
