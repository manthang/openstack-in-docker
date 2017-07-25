FROM ubuntu:16.04
MAINTAINER thangmv@vcs-team

ENV SERVICE="glance"

#Create $service user
RUN useradd --home-dir "/var/lib/$SERVICE" \
        --create-home \
        --system \
        --shell /bin/false \
        $SERVICE

#Create and set ownership of essential dirs
RUN mkdir -p /var/log/$SERVICE \
        && mkdir -p /etc/$SERVICE \
        && mkdir -p /var/lib/$SERVICE/images \
        && mkdir -p /var/lib/$SERVICE/image-cache \
        && mkdir -p /var/lib/$SERVICE/scrubber \
        && chown -R $SERVICE:$SERVICE /var/log/$SERVICE \
        && chown -R $SERVICE:$SERVICE /var/lib/$SERVICE \
        && chown -R $SERVICE:$SERVICE /etc/$SERVICE

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
        && apt-get install -y git python-pip python-pymysql python-memcache libssl-dev libffi-dev libxml2-dev libxslt1-dev sudo \
        && apt-get clean

RUN git clone https://github.com/openstack/glance.git \
        && cd glance \
        && git checkout tags/14.0.0 -b stable/ocata \
        && cp -R etc/* /etc/glance \     
        && pip --no-cache-dir install --install-option="--install-scripts=/usr/bin" --install-option="--install-lib=/usr/lib/python2.7/dist-packages" --upgrade -c http://git.openstack.org/cgit/openstack/requirements/plain/upper-constraints.txt?h=stable/ocata . \
        && rm -rf /glance

VOLUME ["/var/log/glance", "/var/lib/glance"]

COPY glance-registry.conf /etc/glance/glance-registry.conf
COPY glance_sudoers /etc/sudoers.d/glance_sudoers
COPY start_glance-registry.sh /usr/local/bin/start_glance-registry.sh
COPY change_volume_perms.sh /usr/local/bin/change_volume_perms.sh

RUN chmod +x /usr/local/bin/start_glance-registry.sh \
	&& chmod +x /usr/local/bin/change_volume_perms.sh \
	&& echo "glance ALL=(root) NOPASSWD: /usr/local/bin/change_volume_perms.sh" >> /etc/sudoers

EXPOSE 9191

USER glance

CMD ["start_glance-registry.sh"]

