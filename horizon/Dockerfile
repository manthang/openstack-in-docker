FROM ubuntu:16.04
MAINTAINER thangmv@vcs-team

ENV SERVICE="horizon"

#Create $service user
RUN useradd --home-dir "/var/lib/$SERVICE" \
        --create-home \
        --system \
        --shell /bin/false \
        $SERVICE

#Create and set ownership of essential dirs
RUN mkdir -p /etc/openstack-dashboard

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
        && apt-get install -y git python-pip python-pymysql python-memcache apache2 libapache2-mod-wsgi gettext locales tzdata \
        && apt-get clean

RUN git clone https://github.com/openstack/horizon.git \
        && cd /horizon \
        && git checkout tags/11.0.3 -b stable/ocata \
        && pip --no-cache-dir install --install-option="--install-scripts=/usr/bin" --install-option="--install-lib=/usr/lib/python2.7/dist-packages" --upgrade -c http://git.openstack.org/cgit/openstack/requirements/plain/upper-constraints.txt?h=stable/ocata .

COPY local_settings.py /etc/openstack-dashboard/local_settings.py

RUN cd /horizon \
	&& cp /etc/openstack-dashboard/local_settings.py openstack_dashboard/local/ \
        && ./manage.py compilemessages \
        && ./manage.py collectstatic --noinput \
        && ./manage.py compress \
        && ./manage.py make_web_conf --wsgi \
	&& cp openstack_dashboard/wsgi/horizon.wsgi /usr/lib/python2.7/dist-packages/openstack_dashboard/wsgi/ \
	&& cp -r static /usr/lib/python2.7/dist-packages/static \
	&& cp -r openstack_dashboard/conf/* /etc/openstack-dashboard/ \
        && chown -R horizon: /etc/openstack-dashboard \
	&& ln -s /etc/openstack-dashboard/local_settings.py /usr/lib/python2.7/dist-packages/openstack_dashboard/local/ \
	&& rm -rf /horizon

COPY horizon.conf /etc/apache2/sites-available/horizon.conf
COPY start_horizon.sh /usr/local/bin/start_horizon.sh

RUN chmod +x /usr/local/bin/start_horizon.sh \
        && ln -s /etc/apache2/sites-available/horizon.conf /etc/apache2/sites-enabled/ \
	&& a2dissite 000-default.conf \
	&& echo > /etc/apache2/ports.conf \
	&& echo ServerName localhost >> /etc/apache2/apache2.conf \
	&& chown www-data: /var/lib/openstack-dashboard/secret_key

VOLUME ["/var/log/apache2", "/var/lib/openstack-dashboard"]

EXPOSE 80 443

USER root

CMD ["start_horizon.sh"]

