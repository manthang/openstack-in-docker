#!/bin/bash

MYSQL_PASS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)

KEYSTONE_DBPASS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)
GLANCE_DBPASS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)
NOVA_DBPASS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)
NEUTRON_DBPASS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)
CINDER_DBPASS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)

ADMIN_PASS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)

GLANCE_PASS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)
NOVA_PASS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)
PLACEMENT_PASS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)
NEUTRON_PASS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)
CINDER_PASS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)

METADATA_PROXY_SHARED_SECRET=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)

RABBIT_PASS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)

MEMCACHED_PASS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)

sed -i "s/ADMIN_PASS/$ADMIN_PASS/g" ./run_vars/openstackclient.env

echo "ADMIN_PASS=$ADMIN_PASS" >> ./run_vars/keystone.env
echo "KEYSTONE_DBPASS=$KEYSTONE_DBPASS" >> ./run_vars/keystone.env

echo "GLANCE_DBPASS=$GLANCE_DBPASS" >> ./run_vars/glance.env
echo "GLANCE_PASS=$GLANCE_PASS" >> ./run_vars/glance.env

echo "NOVA_DBPASS=$NOVA_DBPASS" >> ./run_vars/nova.env
echo "NOVA_PASS=$NOVA_PASS" >> ./run_vars/nova.env
echo "PLACEMENT_PASS=$PLACEMENT_PASS" >> ./run_vars/nova.env
echo "NEUTRON_PASS=$NEUTRON_PASS" >> ./run_vars/nova.env
echo "METADATA_PROXY_SHARED_SECRET=$METADATA_PROXY_SHARED_SECRET" >> ./run_vars/nova.env

echo "NEUTRON_DBPASS=$NEUTRON_DBPASS" >> ./run_vars/neutron.env
echo "NEUTRON_PASS=$NEUTRON_PASS" >> ./run_vars/neutron.env
echo "NOVA_PASS=$NOVA_PASS" >> ./run_vars/neutron.env
echo "METADATA_PROXY_SHARED_SECRET=$METADATA_PROXY_SHARED_SECRET" >> ./run_vars/neutron.env

echo "CINDER_DBPASS=$CINDER_DBPASS" >> ./run_vars/cinder.env
echo "CINDER_PASS=$CINDER_PASS" >> ./run_vars/cinder.env

sed -i "s/RABBIT_PASS/$RABBIT_PASS/g" ./run_vars/general.env
sed -i "s/MEMCACHED_PASS/$MEMCACHED_PASS/g" ./run_vars/general.env

sed -i "s/mysql_pass/$MYSQL_PASS/g" ./create_databases.sh
sed -i "s/keystone_dbpass/$KEYSTONE_DBPASS/g" ./create_databases.sh
sed -i "s/glance_dbpass/$GLANCE_DBPASS/g" ./create_databases.sh
sed -i "s/nova_dbpass/$NOVA_DBPASS/g" ./create_databases.sh
sed -i "s/neutron_dbpass/$NEUTRON_DBPASS/g" ./create_databases.sh
sed -i "s/cinder_dbpass/$CINDER_DBPASS/g" ./create_databases.sh
