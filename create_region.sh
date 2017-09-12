#!/bin/bash

openstack --os-region-name $1 endpoint create --region $2 identity admin http://$3:35357/v3/
openstack --os-region-name $1 endpoint create --region $2 identity public http://$3:5000/v3/
openstack --os-region-name $1 endpoint create --region $2 identity internal http://$3:5000/v3/
