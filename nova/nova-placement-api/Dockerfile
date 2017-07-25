FROM ubuntu:16.04
MAINTAINER thangmv@vcs-team

ENV SERVICE="nova"

#Create $service user
RUN useradd --home-dir "/var/lib/$SERVICE" \
        --create-home \
        --system \
        --shell /bin/false \
        $SERVICE

#Create and set ownership of essential dirs
RUN mkdir -p /var/log/$SERVICE \
        && mkdir -p /etc/$SERVICE \
        && chown -R $SERVICE:$SERVICE /var/log/$SERVICE \
        && chown -R $SERVICE:$SERVICE /var/lib/$SERVICE \
        && chown -R $SERVICE:$SERVICE /etc/$SERVICE

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
        && apt-get install -y git python-pip python-pymysql python-memcache apache2 libapache2-mod-wsgi libssl-dev libffi-dev libxml2-dev libxslt1-dev iptables sudo \
	&& apt-get clean

RUN git clone https://github.com/openstack/nova.git \
	&& cd nova \
	&& git checkout tags/15.0.6 -b stable/ocata \
        && cp -R etc/nova/* /etc/nova \
        && pip --no-cache-dir install --install-option="--install-scripts=/usr/bin" --install-option="--install-lib=/usr/lib/python2.7/dist-packages" --upgrade -c http://git.openstack.org/cgit/openstack/requirements/plain/upper-constraints.txt?h=stable/ocata . \
	&& rm -rf /nova

VOLUME ["/var/log/apache2"]

COPY nova.conf /etc/nova/nova.conf
COPY nova_sudoers /etc/sudoers.d/nova_sudoers
COPY nova-placement-api.conf /etc/apache2/sites-available/nova-placement-api.conf
COPY start_nova-placement-api.sh /usr/local/bin/start_nova-placement-api.sh

RUN chmod +x /usr/local/bin/start_nova-placement-api.sh \
        && ln -s /etc/apache2/sites-available/nova-placement-api.conf /etc/apache2/sites-enabled/ \
	&& a2dissite 000-default.conf \
	&& echo > /etc/apache2/ports.conf \
	&& echo ServerName localhost >> /etc/apache2/apache2.conf

EXPOSE 8778

USER root

CMD ["start_nova-placement-api.sh"]

