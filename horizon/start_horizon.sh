#!/bin/bash

# NOTE(pbourke): apache2  will not clean up after itself in some cases which
# results in the container not being able to restart. (bug #1489676, 1557036)

# Loading Apache2 ENV variables
. /etc/apache2/envvars
rm -rf /var/run/apache2/*

chown www-data: /var/lib/openstack-dashboard/secret_key
chmod 0600 /var/lib/openstack-dashboard/secret_key

sed -i "s/CONTROLLER_HOST/$CONTROLLER_HOST/g" /etc/openstack-dashboard/local_settings.py
sed -i "s/MEMCACHED_SERVER/$MEMCACHED_SERVER/g" /etc/openstack-dashboard/local_settings.py

sed -i "s/localhost/$HOSTNAME/g" /etc/apache2/apache2.conf

/usr/sbin/apache2ctl -D FOREGROUND
