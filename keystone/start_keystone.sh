#!/bin/bash

# NOTE(pbourke): apache2  will not clean up after itself in some cases which
# results in the container not being able to restart. (bug #1489676, 1557036)

# Loading Apache2 ENV variables
. /etc/apache2/envvars
rm -rf /var/run/apache2/*

chown -R keystone.keystone /etc/keystone/
chmod 700 /etc/keystone/{credential-keys,fernet-keys}

sed -i "s/KEYSTONE_DBPASS/$KEYSTONE_DBPASS/g" /etc/keystone/keystone.conf
sed -i "s/DB_HOST/$DB_HOST/g" /etc/keystone/keystone.conf

sed -i "s/MEMCACHED_SERVERS/$MEMCACHED_SERVERS/g" /etc/keystone/keystone.conf

sed -i "s/localhost/$HOSTNAME/g" /etc/apache2/apache2.conf

/usr/sbin/apache2ctl -D FOREGROUND
