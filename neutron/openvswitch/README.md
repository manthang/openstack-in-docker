# 1. BUILD
docker build -t controller:4000/openvswitch .

# 2. RUN
docker run -itd --name openvswitch --network=host --privileged --user root --cap-add NET_ADMIN -v /var/run/openvswitch:/var/run/openvswitch controller:4000/openvswitch
