#!/bin/bash

sudo change_volume_perms.sh

sed -i "s/GLANCE_DBPASS/$GLANCE_DBPASS/g" /etc/glance/glance-api.conf
sed -i "s/DB_HOST/$DB_HOST/g" /etc/glance/glance-api.conf

glance-manage db_sync
