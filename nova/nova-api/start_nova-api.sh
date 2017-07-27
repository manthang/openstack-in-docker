#!/bin/bash

sudo change_volume_perms.sh

sed -i "s/MY_IP/$MY_IP/g" /etc/nova/nova.conf

sed -i "s/NOVA_DBPASS/$NOVA_DBPASS/g" /etc/nova/nova.conf
sed -i "s/DB_HOST/$DB_HOST/g" /etc/nova/nova.conf

sed -i "s/CONTROLLER_HOST/$CONTROLLER_HOST/g" /etc/nova/nova.conf
sed -i "s/REGION_NAME/$REGION_NAME/g" /etc/nova/nova.conf

sed -i "s/NOVA_PASS/$NOVA_PASS/g" /etc/nova/nova.conf
sed -i "s/PLACEMENT_PASS/$PLACEMENT_PASS/g" /etc/nova/nova.conf
sed -i "s/NEUTRON_PASS/$NEUTRON_PASS/g" /etc/nova/nova.conf

sed -i "s/METADATA_PROXY_SHARED_SECRET/$METADATA_PROXY_SHARED_SECRET/g" /etc/nova/nova.conf

sed -i "s|TRANSPORT_URL|$TRANSPORT_URL|g" /etc/nova/nova.conf

sed -i "s/MEMCACHED_SERVERS/$MEMCACHED_SERVERS/g" /etc/nova/nova.conf
sed -i "s/MEMCACHE_SECRET_KEY/$MEMCACHE_SECRET_KEY/g" /etc/nova/nova.conf

nova-api
