#!/bin/bash

#Region
openstack --os-region-name $1 endpoint create --region $2 identity admin http://$3:35357/v3/
openstack --os-region-name $1 endpoint create --region $2 identity public http://$3:5000/v3/
openstack --os-region-name $1 endpoint create --region $2 identity internal http://$3:5000/v3/

#Glance
openstack --os-region-name $1 endpoint create --region $2 image public http://$3:9292
openstack --os-region-name $1 endpoint create --region $2 image internal http://$3:9292
openstack --os-region-name $1 endpoint create --region $2 image admin http://$3:9292

#Nova
openstack --os-region-name $1 endpoint create --region $2 compute public http://$3:8774/v2.1
openstack --os-region-name $1 endpoint create --region $2 compute internal http://$3:8774/v2.1
openstack --os-region-name $1 endpoint create --region $2 compute admin http://$3:8774/v2.1
openstack --os-region-name $1 endpoint create --region $2 placement public http://$3:8778
openstack --os-region-name $1 endpoint create --region $2 placement internal http://$3:8778
openstack --os-region-name $1 endpoint create --region $2 placement admin http://$3:8778

#Neutron
openstack --os-region-name $1 endpoint create --region $2 network public http://$3:9696
openstack --os-region-name $1 endpoint create --region $2 network internal http://$3:9696
openstack --os-region-name $1 endpoint create --region $2 network admin http://$3:9696

#Cinder
openstack --os-region-name $1 endpoint create --region $2 volumev2 public http://$3:8776/v2/%\(project_id\)s
openstack --os-region-name $1 endpoint create --region $2 volumev2 internal http://$3:8776/v2/%\(project_id\)s
openstack --os-region-name $1 endpoint create --region $2 volumev2 admin http://$3:8776/v2/%\(project_id\)s
openstack --os-region-name $1 endpoint create --region $2 volumev3 public http://$3:8776/v3/%\(project_id\)s
openstack --os-region-name $1 endpoint create --region $2 volumev3 internal http://$3:8776/v3/%\(project_id\)s
openstack --os-region-name $1 endpoint create --region $2 volumev3 admin http://$3:8776/v3/%\(project_id\)s
