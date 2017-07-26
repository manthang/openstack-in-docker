#!/bin/bash
DOCKER_REGISTRY=os-controller:4000

printf "\nPulling keystone image..."
docker pull $DOCKER_REGISTRY/keystone

printf "\nPulling glance images..."
docker pull $DOCKER_REGISTRY/glance-api
docker pull $DOCKER_REGISTRY/glance-registry

printf "\nPulling nova images..."
docker pull $DOCKER_REGISTRY/nova-api
docker pull $DOCKER_REGISTRY/nova-conductor
docker pull $DOCKER_REGISTRY/nova-consoleauth
docker pull $DOCKER_REGISTRY/nova-novncproxy
docker pull $DOCKER_REGISTRY/nova-placement-api
docker pull $DOCKER_REGISTRY/nova-scheduler

printf "\nPulling neutron images..."
docker pull $DOCKER_REGISTRY/neutron-server
docker pull $DOCKER_REGISTRY/neutron-ovs-agent
docker pull $DOCKER_REGISTRY/neutron-dhcp-agent
docker pull $DOCKER_REGISTRY/neutron-metadata-agent

printf "\nPulling cinder images..."
docker pull $DOCKER_REGISTRY/cinder-api
docker pull $DOCKER_REGISTRY/cinder-scheduler
docker pull $DOCKER_REGISTRY/cinder-volume

printf "\nPulling horizon image..."
docker pull $DOCKER_REGISTRY/horizon
