#!/bin/bash

# NOTE(pbourke): apache2  will not clean up after itself in some cases which
# results in the container not being able to restart. (bug #1489676, 1557036)

# Loading Apache2 ENV variables
. /etc/apache2/envvars
rm -rf /var/run/apache2/*

chown -R nova.nova /etc/nova/
chown -R nova.nova /var/lib/nova/
chown -R nova.nova /var/log/nova/

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

sed -i "s/localhost/$HOSTNAME/g" /etc/apache2/apache2.conf

/usr/sbin/apache2ctl -D FOREGROUND
