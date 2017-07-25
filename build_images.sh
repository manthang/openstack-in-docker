#!/bin/bash

#Keystone
docker build -t os-controller:4000/keystone ./keystone/

#OpenStack client
docker build -t os-controller:4000/openstack-client ./openstack-client/

#Glance
docker build -t os-controller:4000/glance-api ./glance/glance-api/
docker build -t os-controller:4000/glance-registry ./glance/glance-registry/

#Nova
docker build -t os-controller:4000/nova-api ./nova/nova-api/
docker build -t os-controller:4000/nova-conductor ./nova/nova-conductor/
docker build -t os-controller:4000/nova-consoleauth ./nova/nova-consoleauth/
docker build -t os-controller:4000/nova-novncproxy ./nova/nova-novncproxy/
docker build -t os-controller:4000/nova-placement-api ./nova/nova-placement-api/
docker build -t os-controller:4000/nova-scheduler ./nova/nova-scheduler/

#Neutron
docker build -t os-controller:4000/neutron-server ./neutron/neutron-server/
docker build -t os-controller:4000/neutron-dhcp-agent ./neutron/neutron-dhcp-agent/
docker build -t os-controller:4000/neutron-metadata-agent ./neutron/neutron-metadata-agent/
docker build -t os-controller:4000/neutron-ovs-agent ./neutron/neutron-ovs-agent/

#Cinder
docker build -t os-controller:4000/cinder-api ./cinder/cinder-api/
docker build -t os-controller:4000/cinder-scheduler ./cinder/cinder-scheduler/
docker build -t os-controller:4000/cinder-volume ./cinder/cinder-volume/

#Horizon
docker build -t os-controller:4000/horizon ./horizon/

