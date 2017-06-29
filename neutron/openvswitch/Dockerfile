FROM ubuntu:16.04
MAINTAINER thangmv@vcs-team

ENV SERVICE="ovs"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
        && apt-get install -y sudo iptables ipset openvswitch-switch python-openvswitch

VOLUME ["/var/run/openvswitch"]

EXPOSE 6640

COPY start_ovs.sh /start_ovs.sh
RUN chmod +x /start_ovs.sh

CMD ["/start_ovs.sh"]
