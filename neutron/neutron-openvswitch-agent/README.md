# 1. BUILD
docker build -t controller:4000/neutron-openvswitch-agent .

# 2. RUN
docker run -d --name neutron-openvswitch-agent --network=host --privileged --user neutron -v /var/run/openvswitch:/var/run/openvswitch controller:4000/neutron-openvswitch-agent
