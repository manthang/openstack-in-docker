FROM ubuntu:16.04
MAINTAINER thangmv@vcs-team

ENV SERVICE="neutron"

#Create $service user
RUN useradd --home-dir "/var/lib/$SERVICE" \
        --create-home \
        --system \
        --shell /bin/false \
        $SERVICE

#Create and set ownership of essential dirs
RUN mkdir -p /var/log/$SERVICE \
        && mkdir -p /etc/$SERVICE/rootwrap.d \
        && mkdir -p /etc/$SERVICE/plugins/ml2 \
        && chown -R $SERVICE:$SERVICE /var/log/$SERVICE \
        && chown -R $SERVICE:$SERVICE /var/lib/$SERVICE \
        && chown -R $SERVICE:$SERVICE /etc/$SERVICE

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
        && apt-get install -y git python-pip python-pymysql python-memcache libssl-dev libffi-dev \
                sudo iptables ipset

RUN git clone https://github.com/openstack/neutron.git \
	&& cd neutron \
	&& git checkout tags/10.0.2 -b stable/ocata \
        && cp etc/{*.*} /etc/neutron \
        && cp -R etc/neutron/rootwrap.d/* /etc/neutron/rootwrap.d \
        && pip --no-cache-dir install --upgrade .

VOLUME ["/var/log/neutron","/var/lib/neutron"]

COPY neutron.conf /etc/neutron/neutron.conf
COPY ml2_conf.ini /etc/neutron/plugins/ml2/ml2_conf.ini
COPY sudoers_neutron /etc/sudoers.d/neutron

EXPOSE 9696

CMD ["neutron-server", "--config-file=/etc/neutron/neutron.conf", "--config-file=/etc/neutron/plugins/ml2/ml2_conf.ini", "--log-file=/var/log/neutron/neutron-server.log"]
