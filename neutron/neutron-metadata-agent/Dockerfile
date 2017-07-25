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
        && chown -R $SERVICE:$SERVICE /var/log/$SERVICE \
        && chown -R $SERVICE:$SERVICE /var/lib/$SERVICE \
        && chown -R $SERVICE:$SERVICE /etc/$SERVICE

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
        && apt-get install -y git python-pip python-pymysql python-memcache libssl-dev libffi-dev libxml2-dev libxslt1-dev sudo iptables ipset \
        && apt-get clean

RUN git clone https://github.com/openstack/neutron.git \
        && cd neutron \
        && git checkout tags/10.0.2 -b stable/ocata \
        && cp etc/*.* /etc/neutron \
        && cp -R etc/neutron/rootwrap.d/* /etc/neutron/rootwrap.d \
        && pip --no-cache-dir install --install-option="--install-scripts=/usr/bin" --install-option="--install-lib=/usr/lib/python2.7/dist-packages" --upgrade -c http://git.openstack.org/cgit/openstack/requirements/plain/upper-constraints.txt?h=stable/ocata . \
        && rm -rf /neutron

VOLUME ["/var/log/neutron", "/var/lib/neutron", "/run/netns"]

COPY neutron.conf /etc/neutron/neutron.conf
COPY metadata_agent.ini /etc/neutron/metadata_agent.ini
COPY neutron_sudoers /etc/sudoers.d/neutron_sudoers
COPY start_neutron-metadata-agent.sh /usr/local/bin/start_neutron-metadata-agent.sh
COPY change_volume_perms.sh /usr/local/bin/change_volume_perms.sh

RUN chmod +x /usr/local/bin/start_neutron-metadata-agent.sh \
        && chmod +x /usr/local/bin/change_volume_perms.sh \
        && echo "neutron ALL=(root) NOPASSWD: /usr/local/bin/change_volume_perms.sh" >> /etc/sudoers

USER neutron

CMD ["start_neutron-metadata-agent.sh"]

