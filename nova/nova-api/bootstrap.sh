#!/bin/bash

sudo change_volume_perms.sh

sed -i "s/NOVA_DBPASS/$NOVA_DBPASS/g" /etc/nova/nova.conf
sed -i "s/DB_HOST/$DB_HOST/g" /etc/nova/nova.conf

sed -i "s|TRANSPORT_URL|$TRANSPORT_URL|g" /etc/nova/nova.conf

nova-manage api_db sync
nova-manage cell_v2 map_cell0
nova-manage cell_v2 create_cell --name=$CELL_NAME --verbose
nova-manage db sync

