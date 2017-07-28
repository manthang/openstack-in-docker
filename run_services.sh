#!/bin/bash

cd ./run_vars

#
#Keystone
#
printf "\nStart keystone containers...."

docker run -d --name keystone --network=host -u root -v /var/log/apache2:/var/log/apache2 -v /etc/keystone/credential-keys:/etc/keystone/credential-keys -v /etc/keystone/fernet-keys:/etc/keystone/fernet-keys -v /etc/localtime:/etc/localtime --env-file="./general.env" --env-file="./keystone.env" os-controller:4000/keystone

#
#Glance
#
printf "\nStart glance containers...."

docker run -d --name glance-api --network=host -v /var/log/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /etc/localtime:/etc/localtime -u glance --env-file="./general.env" --env-file="./glance.env" os-controller:4000/glance-api

docker run -d --name glance-registry --network=host -v /var/log/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /etc/localtime:/etc/localtime -u glance --env-file="./general.env" --env-file="./glance.env" os-controller:4000/glance-registry

#
#Nova
#
printf "\nStart nova containers...."

docker run -d --name nova-api --network=host --privileged -u nova -v /var/log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /etc/localtime:/etc/localtime --env-file="./general.env" --env-file="./nova.env" os-controller:4000/nova-api

docker run -d --name nova-conductor --network=host --privileged -u nova -v /var/log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /etc/localtime:/etc/localtime --env-file="./general.env" --env-file="./nova.env" os-controller:4000/nova-conductor

docker run -d --name nova-consoleauth --network=host --privileged -u nova -v /var/log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /etc/localtime:/etc/localtime --env-file="./general.env" --env-file="./nova.env" os-controller:4000/nova-consoleauth

docker run -d --name nova-novncproxy --network=host --privileged -u nova -v /var/log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /etc/localtime:/etc/localtime --env-file="./general.env" --env-file="./nova.env" os-controller:4000/nova-novncproxy

docker run -d --name nova-scheduler --network=host --privileged -u nova -v /var/log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /etc/localtime:/etc/localtime --env-file="./general.env" --env-file="./nova.env" os-controller:4000/nova-scheduler

docker run -d --name nova-placement-api --network=host --privileged -u root -v /var/log/apache2:/var/log/apache2 -v /var/lib/nova:/var/lib/nova -v /etc/localtime:/etc/localtime --env-file="./general.env" --env-file="./nova.env" os-controller:4000/nova-placement-api

#
#Neutron
#
printf "\nStart neutron containers...."

docker run -d --name neutron-server --network=host --privileged --user neutron -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /etc/localtime:/etc/localtime --env-file="./general.env" --env-file="./neutron.env" os-controller:4000/neutron-server

docker run -d --name neutron-ovs-agent --network=host --privileged --user neutron -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run:/run:shared -v /run/netns:/run/netns:shared -v /run/openvswitch:/run/openvswitch -v /etc/localtime:/etc/localtime --env-file="./general.env" --env-file="./neutron.env" os-controller:4000/neutron-ovs-agent

docker run -d --name neutron-dhcp-agent --network=host --privileged --user neutron -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run:/run:shared -v /run/netns:/run/netns:shared -v /run/openvswitch:/run/openvswitch -v /etc/localtime:/etc/localtime --env-file="./general.env" --env-file="./neutron.env" os-controller:4000/neutron-dhcp-agent

docker run -d --name neutron-metadata-agent --network=host --privileged --user neutron -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run/netns:/run/netns:shared -v /etc/localtime:/etc/localtime --env-file="./general.env" --env-file="./neutron.env" os-controller:4000/neutron-metadata-agent

#
#Cinder
#
printf "\nStart cinder containers...."

docker run -d --name cinder-api --network=host -u root -v /var/log/apache2:/var/log/apache2 -v /etc/localtime:/etc/localtime --env-file="./general.env" --env-file="./cinder.env" os-controller:4000/cinder-api

docker run -d --name cinder-scheduler --network=host -u cinder -v /var/log/cinder:/var/log/cinder -v /etc/localtime:/etc/localtime --env-file="./general.env" --env-file="./cinder.env" os-controller:4000/cinder-scheduler

docker run -d --name cinder-volume --network=host -u cinder -v /var/log/cinder:/var/log/cinder -v /etc/localtime:/etc/localtime --env-file="./general.env" --env-file="./cinder.env" os-controller:4000/cinder-volume

#
#Horizon
#
printf "\nStart horizon container...."

docker run -d --name horizon --network=host -u root -v /var/log/apache2:/var/log/apache2 -v /etc/localtime:/etc/localtime --env-file="./general.env" os-controller:4000/horizon

printf "\nFinishing to run containers for OpenStack services!!!"

