#!/bin/bash

sed -i "s/KEYSTONE_DBPASS/$KEYSTONE_DBPASS/g" /etc/keystone/keystone.conf
sed -i "s/DB_HOST/$DB_HOST/g" /etc/keystone/keystone.conf

chown -R keystone.keystone /etc/keystone/
chmod 700 /etc/keystone/{credential-keys,fernet-keys}

su -s /bin/sh -c "keystone-manage db_sync" keystone

keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

keystone-manage bootstrap --bootstrap-password $ADMIN_PASS \
  --bootstrap-admin-url http://$CONTROLLER_HOST:35357/v3/ \
  --bootstrap-internal-url http://$CONTROLLER_HOST:5000/v3/ \
  --bootstrap-public-url http://$CONTROLLER_HOST:5000/v3/ \
  --bootstrap-region-id $REGION_NAME

