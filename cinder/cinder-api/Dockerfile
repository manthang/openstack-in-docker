FROM ubuntu:16.04
MAINTAINER thangmv@vcs-team

ENV SERVICE="cinder"

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
        && apt-get install -y git python-pip python-pymysql python-memcache libssl-dev libffi-dev libxml2-dev libxslt1-dev sudo apache2 libapache2-mod-wsgi \
        && apt-get clean

RUN git clone https://github.com/openstack/cinder.git \
        && cd cinder \
        && git checkout tags/10.0.3 -b stable/ocata \
        && cp -R etc/cinder/* /etc/cinder \     
        && pip --no-cache-dir install --install-option="--install-scripts=/usr/bin" --install-option="--install-lib=/usr/lib/python2.7/dist-packages" --upgrade -c http://git.openstack.org/cgit/openstack/requirements/plain/upper-constraints.txt?h=stable/ocata . \
	&& rm -rf /cinder

COPY cinder.conf /etc/cinder/cinder.conf
COPY cinder_sudoers /etc/sudoers.d/cinder_sudoers
COPY cinder-wsgi.conf /etc/apache2/sites-available/cinder-wsgi.conf
COPY start_cinder-api.sh /usr/local/bin/start_cinder-api.sh
COPY bootstrap.sh /usr/local/bin/bootstrap.sh

RUN chmod +x /usr/local/bin/start_cinder-api.sh \
        && chmod +x /usr/local/bin/bootstrap.sh \
	&& a2dissite 000-default.conf \
	&& echo > /etc/apache2/ports.conf \
	&& echo ServerName localhost >> /etc/apache2/apache2.conf \
        && ln -s /etc/apache2/sites-available/cinder-wsgi.conf /etc/apache2/sites-enabled/cinder-wsgi.conf

VOLUME ["/var/log/apache2"]

EXPOSE 8776

USER root

CMD ["start_cinder-api.sh"]

