FROM ubuntu:16.04
MAINTAINER thangmv@vcs-team

ENV SERVICE="keystone"

#Create $service user
RUN useradd --home-dir "/var/lib/$SERVICE" \
        --create-home \
        --system \
        --shell /bin/false \
        $SERVICE

#Create and set ownership of essential dirs
RUN mkdir -p /var/log/$SERVICE \
        && mkdir -p /etc/$SERVICE/credential-keys \
        && mkdir -p /etc/$SERVICE/fernet-keys \
        && chown -R $SERVICE:$SERVICE /var/log/$SERVICE \
        && chown -R $SERVICE:$SERVICE /var/lib/$SERVICE \
        && chown -R $SERVICE:$SERVICE /etc/$SERVICE \
        && chmod 700 /etc/$SERVICE/*-keys

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
        && apt-get install -y git python-pip python-pymysql python-memcache apache2 libapache2-mod-wsgi libssl-dev libffi-dev \
	&& apt-get clean

RUN git clone https://github.com/openstack/keystone.git \
        && cd keystone \
        && git checkout tags/11.0.2 -b stable/ocata \
        && cp -r etc/* /etc/keystone \
        && cp httpd/wsgi-keystone.conf /etc/apache2/sites-available \
        && pip --no-cache-dir install --install-option="--install-scripts=/usr/bin" --install-option="--install-lib=/usr/lib/python2.7/dist-packages" --upgrade -c http://git.openstack.org/cgit/openstack/requirements/plain/upper-constraints.txt?h=stable/ocata . \
	&& rm -rf /keystone

COPY keystone.conf /etc/keystone/keystone.conf
COPY keystone-paste.ini /etc/keystone/keystone-paste.ini
COPY wsgi-keystone.conf /etc/apache2/sites-available/wsgi-keystone.conf
COPY start_keystone.sh /usr/local/bin/start_keystone.sh
COPY bootstrap.sh /usr/local/bin/bootstrap.sh

RUN chmod +x /usr/local/bin/start_keystone.sh \
	&& chmod +x /usr/local/bin/bootstrap.sh \
	&& ln -s /etc/apache2/sites-available/wsgi-keystone.conf /etc/apache2/sites-enabled/ \
	&& a2dissite 000-default.conf \
	&& echo > /etc/apache2/ports.conf \
	&& echo ServerName localhost >> /etc/apache2/apache2.conf \
	&& rm -f /var/lib/keystone/keystone.db

VOLUME ["/var/log/apache2", "/etc/keystone/credential-keys", "/etc/keystone/fernet-keys"]

EXPOSE 5000 35357

USER root

CMD ["start_keystone.sh"]

