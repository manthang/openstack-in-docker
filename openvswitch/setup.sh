#!/bin/bash

PROVIDER_BRI=br-provider
PROVIDER_INT=$1

printf "\nInstall openvswitch package...."
apt update \
	&& apt install -y openvswitch-switch

printf "\nCreate provider bridge and interface..."
ovs-vsctl add-br $PROVIDER_BRI
ovs-vsctl add-port $PROVIDER_BRI $PROVIDER_INT

