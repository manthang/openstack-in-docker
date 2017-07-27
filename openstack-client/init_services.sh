#!/bin/bash

# 'service' project
openstack project create --domain default --description "Service Project" service

#Glance
openstack user create --domain default --password $GLANCE_PASS glance
openstack role add --project service --user glance admin
openstack service create --name glance --description "OpenStack Image" image
openstack endpoint create --region $REGION_NAME image public http://$CONTROLLER_HOST:9292
openstack endpoint create --region $REGION_NAME image internal http://$CONTROLLER_HOST:9292
openstack endpoint create --region $REGION_NAME image admin http://$CONTROLLER_HOST:9292

#Nova
openstack user create --domain default --password $NOVA_PASS nova
openstack role add --project service --user nova admin
openstack service create --name nova --description "OpenStack Compute" compute
openstack endpoint create --region $REGION_NAME compute public http://$CONTROLLER_HOST:8774/v2.1
openstack endpoint create --region $REGION_NAME compute internal http://$CONTROLLER_HOST:8774/v2.1
openstack endpoint create --region $REGION_NAME compute admin http://$CONTROLLER_HOST:8774/v2.1

openstack user create --domain default --password $PLACEMENT_PASS placement
openstack role add --project service --user placement admin
openstack service create --name placement --description "Placement API" placement
openstack endpoint create --region $REGION_NAME placement public http://$CONTROLLER_HOST:8778
openstack endpoint create --region $REGION_NAME placement internal http://$CONTROLLER_HOST:8778
openstack endpoint create --region $REGION_NAME placement admin http://$CONTROLLER_HOST:8778

#Neutron
openstack user create --domain default --password $NEUTRON_PASS neutron
openstack role add --project service --user neutron admin
openstack service create --name neutron --description "OpenStack Networking" network
openstack endpoint create --region $REGION_NAME network public http://$CONTROLLER_HOST:9696
openstack endpoint create --region $REGION_NAME network internal http://$CONTROLLER_HOST:9696
openstack endpoint create --region $REGION_NAME network admin http://$CONTROLLER_HOST:9696

#Cinder
openstack user create --domain default --password $CINDER_PASS cinder
openstack role add --project service --user cinder admin
openstack service create --name cinderv2 --description "OpenStack Block Storage" volumev2
openstack service create --name cinderv3 --description "OpenStack Block Storage" volumev3
openstack endpoint create --region $REGION_NAME volumev2 public http://$CONTROLLER_HOST:8776/v2/%\(project_id\)s
openstack endpoint create --region $REGION_NAME volumev2 internal http://$CONTROLLER_HOST:8776/v2/%\(project_id\)s
openstack endpoint create --region $REGION_NAME volumev2 admin http://$CONTROLLER_HOST:8776/v2/%\(project_id\)s
openstack endpoint create --region $REGION_NAME volumev3 public http://$CONTROLLER_HOST:8776/v3/%\(project_id\)s
openstack endpoint create --region $REGION_NAME volumev3 internal http://$CONTROLLER_HOST:8776/v3/%\(project_id\)s
openstack endpoint create --region $REGION_NAME volumev3 admin http://$CONTROLLER_HOST:8776/v3/%\(project_id\)s

