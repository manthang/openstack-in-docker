#!/bin/bash
DOCKER_REGISTRY=os-controller:4000

printf "\nPushing keystone image..."
docker push $DOCKER_REGISTRY/keystone

printf "\nPushing glance images..."
docker push $DOCKER_REGISTRY/glance-api
docker push $DOCKER_REGISTRY/glance-registry

printf "\nPushing nova images..."
docker push $DOCKER_REGISTRY/nova-api
docker push $DOCKER_REGISTRY/nova-conductor
docker push $DOCKER_REGISTRY/nova-consoleauth
docker push $DOCKER_REGISTRY/nova-novncproxy
docker push $DOCKER_REGISTRY/nova-placement-api
docker push $DOCKER_REGISTRY/nova-scheduler

printf "\nPushing neutron images..."
docker push $DOCKER_REGISTRY/neutron-server
docker push $DOCKER_REGISTRY/neutron-ovs-agent
docker push $DOCKER_REGISTRY/neutron-dhcp-agent
docker push $DOCKER_REGISTRY/neutron-metadata-agent

printf "\nPushing cinder images..."
docker push $DOCKER_REGISTRY/cinder-api
docker push $DOCKER_REGISTRY/cinder-scheduler
docker push $DOCKER_REGISTRY/cinder-volume

printf "\nPushing horizon image..."
docker push $DOCKER_REGISTRY/horizon

