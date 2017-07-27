#!/bin/bash

sudo change_volume_perms.sh

sed -i "s/MY_IP/$MY_IP/g" /etc/neutron/neutron.conf

sed -i "s/NEUTRON_DBPASS/$NEUTRON_DBPASS/g" /etc/neutron/neutron.conf
sed -i "s/DB_HOST/$DB_HOST/g" /etc/neutron/neutron.conf

sed -i "s/CONTROLLER_HOST/$CONTROLLER_HOST/g" /etc/neutron/neutron.conf
sed -i "s/REGION_NAME/$REGION_NAME/g" /etc/neutron/neutron.conf
sed -i "s/NEUTRON_PASS/$NEUTRON_PASS/g" /etc/neutron/neutron.conf
sed -i "s/NOVA_PASS/$NOVA_PASS/g" /etc/neutron/neutron.conf

sed -i "s|TRANSPORT_URL|$TRANSPORT_URL|g" /etc/neutron/neutron.conf

sed -i "s/MEMCACHED_SERVERS/$MEMCACHED_SERVERS/g" /etc/neutron/neutron.conf
sed -i "s/MEMCACHE_SECRET_KEY/$MEMCACHE_SECRET_KEY/g" /etc/neutron/neutron.conf

neutron-dhcp-agent --config-file=/etc/neutron/neutron.conf --config-file=/etc/neutron/dhcp_agent.ini --log-file=/var/log/neutron/neutron-dhcp-agent.log
