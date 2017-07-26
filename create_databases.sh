#!/bin/bash

MYSQL_USER=root
MYSQL_PASS=MDFiODY0NjQ3NzYxN2Qw

KEYSTONE_PASS=
GLANCE_PASS=
NOVA_PASS=
NEUTRON_PASS=
CINDER_PASS=

config_keystone="CREATE DATABASE IF NOT EXISTS keystone; GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' IDENTIFIED BY '$KEYSTONE_PASS'; GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' IDENTIFIED BY '$KEYSTONE_PASS';"

config_glance="CREATE DATABASE IF NOT EXISTS glance; GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' IDENTIFIED BY '$GLANCE_PASS'; GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%' IDENTIFIED BY '$GLANCE_PASS';"

config_nova_api="CREATE DATABASE IF NOT EXISTS nova_api; GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'localhost' IDENTIFIED BY '$NOVA_PASS'; GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'%' IDENTIFIED BY '$NOVA_PASS';"

config_nova="CREATE DATABASE IF NOT EXISTS nova; GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost' IDENTIFIED BY '$NOVA_PASS'; GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%' IDENTIFIED BY '$NOVA_PASS';"

config_nova_cell0="CREATE DATABASE IF NOT EXISTS nova_cell0; GRANT ALL PRIVILEGES ON nova_cell0.* TO 'nova'@'localhost' IDENTIFIED BY '$NOVA_PASS'; GRANT ALL PRIVILEGES ON nova_cell0.* TO 'nova'@'%' IDENTIFIED BY '$NOVA_PASS';"

config_neutron="CREATE DATABASE IF NOT EXISTS neutron; GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost' IDENTIFIED BY '$NEUTRON_PASS'; GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'%' IDENTIFIED BY '$NEUTRON_PASS';"

config_cinder="CREATE DATABASE IF NOT EXISTS cinder; GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'localhost' IDENTIFIED BY '$CINDER_PASS'; GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'%' IDENTIFIED BY '$CINDER_PASS';"

mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" -e "$config_keystone"
mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" -e "$config_glance"
mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" -e "$config_nova_api"
mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" -e "$config_nova"
mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" -e "$config_nova_cell0"
mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" -e "$config_neutron"
mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" -e "$config_cinder"
