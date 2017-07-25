#!/bin/bash

sudo change_volume_perms.sh

sed -i "s/MY_IP/$MY_IP/g" /etc/glance/glance-api.conf
sed -i "s/REGISTRY_HOST/$REGISTRY_HOST/g" /etc/glance/glance-api.conf

sed -i "s/GLANCE_DBPASS/$GLANCE_DBPASS/g" /etc/glance/glance-api.conf
sed -i "s/DB_HOST/$DB_HOST/g" /etc/glance/glance-api.conf

sed -i "s/CONTROLLER_HOST/$CONTROLLER_HOST/g" /etc/glance/glance-api.conf
sed -i "s/GLANCE_PASS/$GLANCE_PASS/g" /etc/glance/glance-api.conf

sed -i "s|TRANSPORT_URL|$TRANSPORT_URL|g" /etc/glance/glance-api.conf
sed -i "s/MEMCACHED_SERVERS/$MEMCACHED_SERVERS/g" /etc/glance/glance-api.conf

glance-api
